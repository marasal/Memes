//
//  MemeDetailViewController.swift
//  imagePic
//
//  Created by Maram Saleh on 20/02/1441 AH.
//  Copyright © 1441 Maram Saleh. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    var meme: Meme?


    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme?.memedImage
        
    }
    
}
