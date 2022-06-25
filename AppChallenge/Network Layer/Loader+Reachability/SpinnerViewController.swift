//
//  SpinnerViewController.swift
//  AppChallenge
//
//  Created by Nitin Agnihotri on 26/06/22.
//

import Foundation
import UIKit

let child = SpinnerViewController()
class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UIViewController {
    
    func showLoader() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeLoader() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
