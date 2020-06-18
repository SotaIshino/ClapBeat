//
//  TinderViewController.swift
//  Deai
//
//  Created by Owner on 2020/06/17.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit
import CoreLocation
import NCMB

class TinderViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    let locationManager = CLLocationManager()
    var displayedUser = NCMBUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gesture:)))
        userImageView.addGestureRecognizer(gesture)
        userImageView.isUserInteractionEnabled = true
        
        self.getCurrentLocationAndDbSave()
    }
    
    func getCurrentLocationAndDbSave() {
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.notDetermined {
            print("didChangeAuthorizationStatus:\(status)")
            self.locationManager.requestAlwaysAuthorization()
        }
        
        NCMBGeoPoint.geoPointForCurrentLocation(inBackground: {(geopoint, error) in
            if error == nil {
                print("geo point success lat:\(geopoint?.latitude), lon:\(geopoint?.longitude)")
                let user = NCMBUser.current()
                user?.setObject(geopoint, forKey: "geopoint")
                user?.saveEventually({(error) in
                    if error == nil {
                        print("現在地保存成功:\(user)")
                        self.fetchUser()
                    } else {
                        print("現在地保存失敗\(error)")
                    }
                })
            } else {
                print("geo point error:\(error)")
            }
        })
    }
    
    func fetchUser() {
        let query1 = NCMBQuery(className: "Action")
        query1?.whereKey("from", equalTo: NCMBUser.current())
        query1?.findObjectsInBackground({(objects, error) in
            if error == nil {
                print("アクション取得成功:\(objects)")
                
                let currentGeoPoint = NCMBUser.current()?.object(forKey: "geopoint") as! NCMBGeoPoint
                print("currentGeoPoint lat:\(currentGeoPoint.latitude), lon:\(currentGeoPoint.longitude)")
                let interestedInWomen = NCMBUser.current()?.object(forKey: "interestedInWomen") as! Bool
                        
                let query2 = NCMBQuery(className: "user")
                query2?.whereKey("geopoint", nearGeoPoint: currentGeoPoint, withinKilometers: 1.0)

                if interestedInWomen == true {
                    query2?.whereKey("gender", equalTo: "female")
                } else {
                    query2?.whereKey("gender", equalTo: "male")
                }
                        
                query2?.limit = 1
                
                var ignoredUsers = [""]
                for object in objects! {
                    let action = object as! NCMBObject
                    let user = action.object(forKey: "to")
                    print("to user:\(user)")
                    ignoredUsers.append((object as AnyObject).objectId as String)
                }
                print("ignoredUsers\(ignoredUsers)")
                query2?.whereKey("objectId", notContainedInArrayTo: ignoredUsers)
                
                query2?.findObjectsInBackground({(objects, error) in
                    if error == nil {
                        print("友達取得成功:\(objects)")
                        if objects!.count > 0 {
                            self.displayedUser = (objects?[0] as AnyObject) as! NCMBUser
                            let fbPictureUrl = "https://ca.slack-edge.com/TMX0CSJFP-U011AQ9SDKK-90df2b714085-512"
//                            let fbPictureUrl = "https://graph.facebook.com/" + (objects?[0] as AnyObject).userName + "/picture?type=large"
                            if let fbpicUrl = NSURL(string: fbPictureUrl) {
                                if let data = NSData(contentsOf: fbpicUrl as URL) {
                                    self.userImageView.image = UIImage(data: data as Data)
                                }
                            }
                        } else {
                            self.userImageView.image = UIImage()
                            self.userImageView.isUserInteractionEnabled = false
                        }
                    } else {
                        print("友達取得失敗:\(error)")
                    }
                })
            } else {
                print("アクション取得失敗:\(error)")
            }
        })
        
        
    }
    
    @objc func wasDragged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        let imageView = gesture.view!
        imageView.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = imageView.center.x - self.view.bounds.width / 2
        let scale = min(100 / abs(xFromCenter), 1)
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 2)
        var stretch = rotation.scaledBy(x: scale, y: scale)
        imageView.transform = stretch
        
        if gesture.state == UIGestureRecognizer.State.ended {
            var acceptedOrRejected = ""
            if imageView.center.x < 10 {
                acceptedOrRejected = "rejected"
            } else if imageView.center.x > self.view.bounds.width - 10 {
                acceptedOrRejected = "accepted"
            }
            print("好みの相手判断:\(acceptedOrRejected)")
            
            if acceptedOrRejected != "" {
                let action = NCMBObject(className: "Action")
                action?.setObject(NCMBUser.current(), forKey: "from")
                action?.setObject(self.displayedUser, forKey: "to")
                action?.setObject(acceptedOrRejected, forKey: "acceptedOrRejected")
                
                let acl = NCMBACL()
                acl.setPublicReadAccess(true)
                action?.acl = acl
                action?.saveInBackground({(error) in
                    if error == nil {
                        print("Actionテーブル保存成功:\(action)")
                        self.fetchUser()
                    } else {
                        print("Actionテーブル保存失敗:\(error)")
                    }
                })
            }
            
            rotation = CGAffineTransform(rotationAngle: 0)
            stretch = rotation.scaledBy(x: 1, y: 1)
            imageView.transform = stretch
            imageView.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        }
    }

}
