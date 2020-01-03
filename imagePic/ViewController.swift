//
//  ViewController.swift
//  imagePic
//
//  Created by Maram Saleh on 02/02/1441 AH.
//  Copyright © 1441 Maram Saleh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBAction func share(_ sender: Any) {
        let controller = UIActivityViewController (activityItems: [generateMemedImage()], applicationActivities: nil)
        controller.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
            self.save()
            }
            }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        imageView.image = nil
        top.text = "TOP"
        bottom.text = "BOTTOM"
        dismiss(animated: true, completion: nil)
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if imageView.image == nil { shareButton.isEnabled = false }
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setupTextField(tf: top, text: "TOP")
        setupTextField(tf: bottom, text: "BOTTOM")
        subscribeToKeyboardNotifications()
    
    }
    
    func setupTextField (tf: UITextField, text: String) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        let memeTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.strokeColor: UIColor.black,
                                                                 NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                 NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                                                                 NSAttributedString.Key.strokeWidth: -4, ]
        tf.defaultTextAttributes = memeTextAttributes
        tf.textAlignment = .center
        tf.delegate = self
        tf.text = text
        tf.delegate = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    func updateImage (image : UIImage?){
        imageView.image = image
        shareButton?.isEnabled = (image != nil)
    }
    
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        if sender.tag == 0 {
        imagePicker.sourceType = .photoLibrary
        } else {
             imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            updateImage(image: editedImage)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            updateImage(image: originalImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
    }
        func save (){
        let topText: String = top.text ?? ""
        let bottomText: String = bottom.text ?? ""
        let image = imageView.image!
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topText, bottomText: bottomText, originalImage: image, memedImage: memedImage)
        
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        dismiss(animated: true, completion: nil)
            
        //let object = UIApplication.shared.delegate
        //let appDelegate = object as! AppDelegate
        //appDelegate.memes.append(meme)
            
    }
    
   
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(imageView.frame.size)
        view.drawHierarchy(in: imageView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }

}


extension ViewController:  UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            let testText = textField.text ?? ""
            if (textField == top && testText == "TOP") {
                textField.text = ""
            }
            else if (textField == bottom && testText == "BOTTOM"){
             textField.text = ""
             }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if top.text?.isEmpty ?? true {
            top.text = "TOP"
        } else if bottom.text?.isEmpty ?? true{
            bottom.text = "BOTTOM"
        }
    }
    
    //keybourd
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottom.isEditing{
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    }
    
    @objc func KeyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}
