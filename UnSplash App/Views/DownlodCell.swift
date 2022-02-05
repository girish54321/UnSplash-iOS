//
//  DownlodCell.swift
//  UnSplash App
//
//  Created by Girish Parate on 18/10/21.
//

import UIKit

class DwonlodCell: UITableViewCell {
    @IBOutlet weak var downlodTitle: UILabel!
    @IBOutlet weak var downlodSub: UILabel!
    @IBOutlet weak var sizeText: UILabel!
    
    func updateTitle(item:DownlodClass) {
        downlodTitle.text = item.title
        downlodSub.text = item.subTitle
        sizeText.text = item.size
    }
    
}
