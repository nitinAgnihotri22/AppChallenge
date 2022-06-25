//
//  Globals.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import Foundation
import UIKit

struct AppKeys {
    static let omdbKey = "b9bd48a6"
}

func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

let appDel = UIApplication.shared.delegate as! AppDelegate

struct StoryBoardId {
    static let movieList = "ViewController"
    static let movieDetail = "MovieDetailVC"
}

struct StoryBoards {
    static let main = UIStoryboard.init(name: "Main", bundle: nil)
}


import UIKit

struct ProgressDialog {
    static var alert = UIAlertController()
    static var progressView = UIProgressView()
    static var progressPoint : Float = 0{
        didSet{
            if(progressPoint == 1){
                ProgressDialog.alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

struct Sort {
    static let ascending = 0
    static let descending = 1
}

extension UILabel {
    
    func attibutedString(_ str1:String,_ str2:String) {
        let boldAttr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        let regularAttr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        
        let partOne = NSMutableAttributedString(string: str1, attributes: boldAttr as [NSAttributedString.Key : Any])
        let partTwo = NSMutableAttributedString(string: str2, attributes: regularAttr as [NSAttributedString.Key : Any])
        
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        self.attributedText = combination
    }
}
