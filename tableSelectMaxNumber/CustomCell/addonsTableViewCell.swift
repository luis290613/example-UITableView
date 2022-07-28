//
//  addonsTableViewCell.swift
//  SectionInTableView
//
//  Created by Diego on 28/07/22.
//  Copyright © 2022 SHUBHAM AGARWAL. All rights reserved.
//

import UIKit

enum stateCheck {
    case check
    case uncheck
    case bloqueado
}

class addonsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameExample: UILabel!
    @IBOutlet weak var imageExample: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func config(name: String, state: stateCheck){
        self.configState(state: state)
        nameExample.text = name
    }
    
    func configState(state: stateCheck){
        switch state {
        case .check:
            imageExample.image = .check
            imageExample.tintColor = .black
            nameExample.textColor = .black
        case .uncheck:
            imageExample.image = .unCheck
            imageExample.tintColor = .black
            nameExample.textColor = .black
        default:
            imageExample.tintColor = .lightGray
            nameExample.textColor = .lightGray
            
        }
    }
    
}

extension UIImage {
    static let check = UIImage(named: "check")
    static let unCheck = UIImage(named: "uncheck")
}
