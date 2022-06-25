//
//  CustomImageView.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {

    // MARK: - Constants

    let imageCache = NSCache<NSString, AnyObject>()

    // MARK: - Properties

    var imageURLString: String?

    func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }

    func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        contentMode = imageMode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
//                self.imageCache.setObject(imageToCache ?? UIImage(), forKey: url.absoluteString as NSString)
                self.image = imageToCache
            }
        }.resume()
        
//        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
//            self.image = cachedImage
//        } else {
//        }
    }
}

extension UIImageView {
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?,contMode:ContentMode) {
        self.image = nil
        contentMode = contMode
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
