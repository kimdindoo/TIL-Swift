//
//  StockRankCollectionViewCell.swift
//  StockRank
//
//  Created by 김진수 on 2022/07/07.
//

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    
    // uicomponent 연결하자
    // uicomponent 에 데이터를 업데이트 하는 코드를 넣자
    
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var companyIconImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPriceLabel: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    
    func configure(_ stock: StockModel) {
        rankLabel.text = "\(stock.rank)"
        companyIconImageView.image = UIImage(named: stock.imageName)
        companyNameLabel.text = stock.name
        companyPriceLabel.text = "\(convertToCurrencyFormat(price: stock.price)) 원"
        
//        diffLabel.text = "\(stock.diff)%"
//        let firstIndex = stock.diff.description.prefix(1)
//        if firstIndex == "-" {
//            diffLabel.textColor = .blue
//        }
        
//        let color: UIColor
//        if stock.diff > 0 {
//            color = UIColor.systemRed
//        } else {
//            color = UIColor.systemBlue
//        }
//        diffLabel.textColor = color
//        diffLabel.text = "\(stock.diff)%"
        
        
        diffLabel.textColor = stock.diff > 0 ? UIColor.systemRed : UIColor.systemBlue
        diffLabel.text = "\(stock.diff)%"

        
    }
    
    func convertToCurrencyFormat(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        let result = numberFormatter.string(from: NSNumber(value: price)) ?? ""
        return result
    }
    
    
}
