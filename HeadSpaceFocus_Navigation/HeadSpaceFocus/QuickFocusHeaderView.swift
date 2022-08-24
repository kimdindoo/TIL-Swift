//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 김진수 on 2022/08/24.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
    
}
