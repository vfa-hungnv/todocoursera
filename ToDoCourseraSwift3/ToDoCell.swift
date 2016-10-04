//
//  ToDoCell.swift
//  ToDoCourseraSwift3
//
//  Created by Hung Nguyen on 10/3/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    @IBOutlet var todoDescription: UILabel!
    
    @IBOutlet var todoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
