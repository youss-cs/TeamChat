//
//  ChannelCell.swift
//  TeamChat
//
//  Created by YouSS on 10/7/18.
//  Copyright © 2018 YouSS. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        layer.backgroundColor = selected ? UIColor(white: 1, alpha: 0.2).cgColor : UIColor.clear.cgColor
    }
    
    func configureCell(channel: Channel) {
        let title = channel.title ?? ""
        channelName.text = "#\(title)"
    }

}
