//
//  ViewController.swift
//  upload music
//
//  Created by BioS on 03/10/2016.
//  Copyright © 2016 BioS. All rights reserved.
//

import UIKit
import MediaPlayer
import Alamofire

class ViewController: UIViewController,MPMediaPickerControllerDelegate {

    
    var mediaPiker:MPMediaPickerController!
    var player:MPMusicPlayerController!
    var urlApi:String = "http://192.168.8.104:3000/upload"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickedSound(_ sender: AnyObject) {
        mediaPiker = MPMediaPickerController(mediaTypes: MPMediaType.anyVideo)
        mediaPiker.allowsPickingMultipleItems = false
        mediaPiker.delegate = self
        
        self.present(mediaPiker, animated: true, completion: nil)
    }
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        print(mediaItemCollection.items)
        var dd:MPMediaItem = mediaItemCollection.items[0] as MPMediaItem
        
        print(dd.value(forProperty: MPMediaItemPropertyAssetURL))
        let url = dd.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
        print(url.relativePath)
        print("\n ************")
        
        do {
            let data:Data = try Data(contentsOf: url, options: [])
        } catch {
            print(error)
        }
         
      
        player = MPMusicPlayerController.applicationMusicPlayer()
        player.setQueue(with: mediaItemCollection)
        //print(player)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func playMusic(_ sender: AnyObject) {
        //player.play()
        self.player?.play()
    }
    
    func uplaod(toApi zicData:Data) {
        Alamofire
        .upload(multipartFormData: { (multipart) in
            multipart.append(zicData, withName: "myFile", fileName: "music", mimeType: "music/audio")
            }, to: urlApi) { (encodingResult) in
                //print(encodingResult)
        }
        
    }
}



