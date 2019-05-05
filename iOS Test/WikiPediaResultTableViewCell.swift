//
//  WikiPediaResultTableViewCell.swift
//  iOS Test
//
//  Created by Ankush Kumar Singh on 03/09/17.
//  Copyright © 2017 Castle. All rights reserved.
//

import UIKit

class WikiPediaResultTableViewCell: UITableViewCell {

    @IBOutlet weak var resultImage: UIImageView!

    @IBOutlet weak var resultTitle: UILabel!

    @IBOutlet weak var resultSubTitle: UILabel!

    @IBOutlet weak var imageHeight: NSLayoutConstraint!

    @IBOutlet weak var imageWidth: NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
