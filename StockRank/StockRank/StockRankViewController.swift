//
//  StockRankViewController.swift
//  StockRank
//
//  Created by 김진수 on 2022/07/06.
//

import UIKit

class StockRankViewController: UIViewController {
    
    let stockList: [StockModel] = StockModel.list

    @IBOutlet weak var collectionView: UICollectionView!
    
    // Data, Presentaion, Layout
    // Data - 어떤 데이터? -> stockList
    // Presentaion - 셀을 어떻게 표현?
    // Layout - 셀을 어떻게 배치할꺼야?
    
    // protocol -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}

extension StockRankViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else {
            return UICollectionViewCell()
        }
        let stock = stockList[indexPath.item]
        cell.configure(stock)
        return cell
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // width == collectionView
        // 80
        
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
