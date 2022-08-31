//
//  FrameworkListViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/04/24.
//

import UIKit
import Combine

class FrameworkListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias Item = AppleFramework
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
//    let list: [AppleFramework] = AppleFramework.list
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    let didSelect = PassthroughSubject<AppleFramework, Never>()
    let items = CurrentValueSubject<[AppleFramework], Never>(AppleFramework.list)
//    @Published var list: [AppleFramework] = AppleFramework.list

    
    // Data, Presentation, Layout
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CollectionView 설정해주는 것
        //CollectionView 그리는데 필요한 데이터 설정해주는 것
        
        configureCollectionView()
        bind()
        
        // data
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(list, toSection: .main)
//        dataSource.apply(snapshot)
        
    }
    
    private func bind() {
        // input: 사용자 인풋을 받아서, 처리해야 할 것
        // - item 선택 되었을때 처리
        didSelect
            .receive(on: RunLoop.main)
            .sink { [unowned self] framework in
            let sb = UIStoryboard(name: "Detail", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
//            vc.framework = framework
                // FrameworkDetailViewController 에서 framework를 CurrentValueSubjcet 로 바꾸니깐 오류가 떴다.
                vc.framework.send(framework) // framework 자체가 CurrentValueSubjcet 이기 때문에 이렇게 변경만 하면 된다.
            self.present(vc, animated: true)
        }.store(in: &subscriptions)
        
        // output: data, state 변경에 따라서, UI 업데이트 할 것
        // - items 세팅이 되었을때 컬렉셔나뷰를 업데이트
        
        //$list
        items
            .receive(on: RunLoop.main)
            .sink { [unowned self] list in
                self.applySectionItems(list)
        }.store(in: &subscriptions)
        
    }
    
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    private func configureCollectionView() {
        // presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameworkCell", for: indexPath) as? FrameworkCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })

        // layer
        collectionView.collectionViewLayout = layout()
        
        collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 10
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.33))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let groupLayout = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: itemLayout, count:   3)
        groupLayout.interItemSpacing = .fixed(spacing)
        
        // Section
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = spacing
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension FrameworkListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let framework = list[indexPath.item]
        let framework = items.value[indexPath.item]
        print(">>> selected: \(framework.name)")
        didSelect.send(framework)
//        let sb = UIStoryboard(name: "Detail", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
//        vc.framework = framework
//
//        present(vc, animated: true)
    }
}
