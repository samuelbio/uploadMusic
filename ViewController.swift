//
//  ViewController.swift
//  Piker files
//
//  Created by BioS on 30/09/2016.
//  Copyright © 2016 BioS. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var ui_progressBar: UIProgressView!
    @IBOutlet weak var ui_image: UIImageView!
    
    var image:UIImage?
    
    var apiURL:String = "http://192.168.8.102:3000/upload"
    var imageURlOriginale:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func SendToServerBTn(_ sender: AnyObject) {
        
        let imageData = UIImagePNGRepresentation(image!)
        
       Alamofire.upload(multipartFormData: { (multipart) in
        multipart.append(imageData!, withName: "myFile", fileName: "iphone", mimeType: "image/jpg")
       }, to: apiURL) { (encodingResult) in
            
                print(encodingResult)
            
        }
    }
    
    
    
    @IBAction func imagePiker(_ sender: AnyObject) {
        let imagePiker = UIImagePickerController()
        imagePiker.delegate = self
        self.present(imagePiker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        if let imgURl = info[UIImagePickerControllerReferenceURL] as? URL {
            imageURlOriginale = imgURl
        }
        if let imgPiked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            image = imgPiked
            
          
            self.ui_image.image = imgPiked
            
            


        }
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      self.dismiss(animated: true, completion: nil)
    }


}

