//
//  MemeCollectionViewController.swift
//  imagePic
//
//  Created by Maram Saleh on 20/02/1441 AH.
//  Copyright © 1441 Maram Saleh. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellIdentifier", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        cell.imageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let meme = memes[indexPath.row]
        performSegue(withIdentifier: "imageShow2", sender: meme)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageShow2" {
            let memeView = segue.destination as! MemeDetailViewController
            memeView.meme = sender as? Meme
        }
    }
}
