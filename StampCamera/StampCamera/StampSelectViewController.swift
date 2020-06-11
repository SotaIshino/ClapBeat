//
//  StampSelectViewController.swift
//  StampCamera
//
//  Created by Owner on 2020/06/11.
//  Copyright © 2020 asOne. All rights reserved.
//

import UIKit

class StampSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var imageArray :[UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...6 {
            imageArray.append(UIImage(named: "\(i).png")!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stamp = Stamp()
        stamp.image = imageArray[indexPath.row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.stampArray.append(stamp)
        appDelegate.isNewStampAdded = true
        print(appDelegate.isNewStampAdded)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
