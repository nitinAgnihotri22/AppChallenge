//
//  MovieDetailTableCell.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import UIKit

class MovieDetailTableCell: UITableViewCell {
    
    @IBOutlet var movieProperty: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
