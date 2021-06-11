//
//  OldHomeViewController.swift
//  Plot
//
//  Created by Gavin Andrews on 2/2/21.
//

import UIKit

class OldHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView?
    
    private let models = ["user0", "user1","user2","user0","user1","user2","user0","user1","user2","user0","user1","user2","user0","user1","user2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 125, height: 125)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collectionView?.showsVerticalScrollIndicator = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .clear

        guard let myCollection = collectionView else {
            return
        }
        view.addSubview(myCollection)
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width/2, height: 700).integral
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }

}
