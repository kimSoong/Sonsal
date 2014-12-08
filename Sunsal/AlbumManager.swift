//
//  AlbumManager.swift
//  Sunsal
//
//  Created by KimSoong on 2014. 11. 10..
//  Copyright (c) 2014년 kims1006. All rights reserved.
//

import UIKit
//간지나는 전역변수
class AlbumManager : NSObject, MWPhotoBrowserDelegate {
   
    var imageFiles : [MWPhoto!] = []
    var thumbnailFiles : [MWPhoto!] = []
    
    class var sharedManager : AlbumManager {
        struct Static {
            static let instance : AlbumManager = AlbumManager();
        }
        return Static.instance;
    }
    
    override init() {
        
        super.init()
        loadFile()
        
    }
    
    func loadFile() {
        var filename = NSBundle.mainBundle().pathForResource("codershigh", ofType: "json")!;
        NSLog("%@", filename);
        
        var fileData = NSData(contentsOfFile: filename)!;
        if let a = NSJSONSerialization.JSONObjectWithData(fileData, options: NSJSONReadingOptions.allZeros, error: nil) as? [String] {
//            imageFileNames = a;
            for f in a {
                var url = "https://www.acmicpc.net" + f;
                var thumbnailurl = url.stringByReplacingOccurrencesOfString(".jpg", withString: "_thumb.jpg", options: NSStringCompareOptions.allZeros, range: nil)
                //NSLog("%@", url);
                //NSLog("%@", thumbnailurl);
                var photo = MWPhoto(URL: NSURL(string: url)!)
                var thumbnail = MWPhoto(URL: NSURL(string: thumbnailurl)!)
                
                imageFiles += [photo]
                thumbnailFiles += [thumbnail];
            }
        }
    }
    
    func numberOfPhotosInPhotoBrowser(photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(imageFiles.count);
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt) -> MWPhotoProtocol! {
        return imageFiles[Int(index)]
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, thumbPhotoAtIndex index: UInt) -> MWPhotoProtocol! {
        return thumbnailFiles[Int(index)]
    }
}
