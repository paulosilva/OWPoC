//
//  Functions.swift
//  OWPoC
//
//  Created by Paulo Silva on 03/07/2018.
//  Copyright © 2018 Paulo Silva. All rights reserved.
//

import Foundation
import UIKit

#if DEBUG

func DLog(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    let _filename = (filename as NSString).lastPathComponent
    NSLog("[\(_filename):\(line)] \(function) - \(message)")
}

#else

func DLog(_ message: String, filename _: String = #file, function _: String = #function, line _: Int = #line) {}

#endif

#if DEBUG

func ULog(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    let _filename = (filename as NSString).lastPathComponent
    let alertView = UIAlertView(title: "[\(_filename):\(line)]", message: "\(function) - \(message)", delegate: nil, cancelButtonTitle: "OK")
    alertView.show()
}

#else

func ULog(_ message: String, filename _: String = #file, function _: String = #function, line _: Int = #line) {}

#endif

func ALog(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    let _filename = (filename as NSString).lastPathComponent
    NSLog("[\(_filename):\(line)] \(function) - \(message)")
}

func dateForUserLocale(_ date: Date, dateStyle: DateFormatter.Style) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = dateStyle //.full
    dateFormatter.timeStyle = .none
    
    // Local
    dateFormatter.locale = Locale(identifier: UserSettings.sharedInstance.localeID)
    
    return dateFormatter.string(from: date)
}

func dateForUserLocale(_ date: String, dateStyle: DateFormatter.Style) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = dateStyle //.full
    dateFormatter.timeStyle = .none
    
    // Local
    dateFormatter.locale = Locale(identifier: UserSettings.sharedInstance.localeID)
    
    return dateFormatter.string(from: stringToDate(date))
}

func timeForUserLocale(_ dateTime: String, timeStyle: DateFormatter.Style) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = timeStyle //.full
    
    // Local
    dateFormatter.locale = Locale(identifier: UserSettings.sharedInstance.localeID)
    
    return dateFormatter.string(from: stringToDateTime(dateTime))
}

func stringToDate(_ date: String) -> Date {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd" // This is the fixe format that open weather use

    return dateFormatter.date(from: date)!

}

func stringToDateTime(_ dateTime: String) -> Date {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // This is the fixe format that open weather use
    
    return dateFormatter.date(from: dateTime)!
    
}

func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        completion(data, response, error)
        }.resume()
    
}

//func downloadImage(url: URL) {
//    DLog("Download Started")
//    getDataFromUrl(url: url) { data, response, error in
//        guard let data = data, error == nil else { return }
//        DLog(response?.suggestedFilename ?? url.lastPathComponent)
//        DLog("Download Finished")
//        DispatchQueue.main.async() {
//            self.imageView.image = UIImage(data: data)
//        }
//    }
//}

func downloadImageNamed(_ imageNamed: String, fromUrl imageUrl: String, completion: @escaping (_ image: UIImage?) -> Void) {
    
    let _named = String(format: "%@.png", imageNamed)
    
    // read to cache the image
    if let image = readImageNamed(_named) {
        
        //
        DispatchQueue.main.async {
            
            completion(image)
            
        }
        
    } else {
        
        let _link = String(format: "%@/%@.png", imageUrl, imageNamed)
        guard let url = URL(string: _link) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async {
                
                // write to cache the image
                _ = writeImageNamed( _named, imageData: image)
                
                //
                completion(image)
                
            }
            
        }.resume()
        
    }
}


func writeImageNamed(_ named: String, imageData: UIImage) -> Bool {
    
    guard let data = UIImageJPEGRepresentation(imageData, 1) ?? UIImagePNGRepresentation(imageData) else {
        return false
    }
    
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    
    do {
        try data.write(to: directory.appendingPathComponent(named)!)
        return true
    } catch {
        DLog(error.localizedDescription)
        return false
    }
    
}

func readImageNamed(_ named: String) -> UIImage? {
    
    if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
        return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
    }
    
    return nil
    
}

