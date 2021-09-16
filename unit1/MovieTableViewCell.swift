//
//  MovieTableViewCell.swift
//  unit1
//
//  Created by Desmond Ofori Atta on 9/16/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
