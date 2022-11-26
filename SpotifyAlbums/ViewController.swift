//
//  ViewController.swift
//  SpotifyAlbums
//
//  Created by Zardasht on 11/26/22.
//

import UIKit

class ViewController: UIViewController {
    
    let songs = ["Overture",
                 "The Grid",
                 "The Son of Flynn",
                 "Recognizer",
                 "Armory",
                 "Arena",
                 "Rinzler",
                 "The Game Has Changed",
                 "Outlands",
                 "Adagio for TRON",
                 "Nocturne",
                 "End of Line",
                 "Derezzed",
                 "Fall",
                 "Solar Sailer",
                 "Rectifier",
                 "Disc Wars",
                 "C.L.U.",
                 "Arrival",
                 "Flynn Lives",
                 "TRON Legacy (End Titles)",
                 "Finale",
    ]
    
    //MARK: - HeaderKind
    static let headerKind = "header-element-kind"
    var collectionView: UICollectionView! = nil
    var headerView: HeaderView?
    var floatingHeaderView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
}

//MARK: - ViewController + Extentions
extension ViewController {
    
    private func layout() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.resueIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: ViewController.headerKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //MARK: - Floating HeaderView
        floatingHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingHeaderView)
        floatingHeaderView.track = Track(imageName: "tron")
        floatingHeaderView.isFloating = true
        NSLayoutConstraint.activate([
            floatingHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            floatingHeaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        //ListCell Layout
        
        //What That mean is we like ourselves a go fully across the WIDTH and fully take the HEIGHT of however we describe its SIZE in its group so we are basically saying fractional width 1:1 just fill the space we given to you
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //we said that the item inside in this group to be HEIGHT of (44)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        //then what directions should be go , which is HORIZONTAl
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Then the ITEM and the GROUP sit in this thing called SECTION which is another layout..
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        //HeaderLayout
        let headerFooterSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: ViewController.headerKind, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
}

//MARK: - ViewController + Delegate & DataSource
extension ViewController: UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    //ListCell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.resueIdentifier, for: indexPath)
                as? ListCell else { return UICollectionViewCell() }
        
        cell.label.text = songs[indexPath.row]
        return cell
    }
    
    
    //MARK: - HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else { return UICollectionReusableView() }
        
        let track = Track(imageName: "tron")
        headerView.track = track
        self.headerView = headerView
        self.headerView?.isHidden = true
        return headerView
        
    }
    
    //ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.scrollViewDidScroll(scrollView)
        floatingHeaderView.scrollViewDidScroll(scrollView)
    }
}
