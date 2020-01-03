//
//  MemeTableViewController.swift
//  imagePic
//
//  Created by Maram Saleh on 19/02/1441 AH.
//  Copyright © 1441 Maram Saleh. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    
    var memes: [Meme] {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.memes
    }
    
    //var memes: [Meme]! {
    //    let object = UIApplication.shared.delegate
    //    let appDelegate = object as! AppDelegate
    //    return appDelegate.memes
    //}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")!
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText)...\(meme.bottomText)..."
        return cell

    }
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let meme = memes[indexPath.row]
        performSegue(withIdentifier: "imageShow", sender: meme)
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageShow" {
            let memeView = segue.destination as! MemeDetailViewController
            memeView.meme = sender as? Meme
        }
    }
}
