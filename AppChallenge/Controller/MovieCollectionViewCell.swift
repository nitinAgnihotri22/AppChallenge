//
//  MovieCollectionViewCell.swift
//  Assignment
//
//  Created by Nitin Agnihotri on 22/06/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var posterImgVw: CustomImageView!
    @IBOutlet var movieYearLbl: UILabel!
    @IBOutlet var movieTitleLbl: UILabel!
    
    func configureCell(_ movie:Search) {
        posterImgVw.imageFromServerURL(movie.poster, placeHolder: nil,contMode: .scaleAspectFill)
//        posterImgVw.downloadImageFrom(urlString: movie.poster, imageMode: .scaleAspectFill)
        movieTitleLbl.text = movie.title
        movieYearLbl.text = "Year: \(movie.year ?? "")"
    }
}
