//
//  CollectionViewCell.swift
//  Plot
//
//  Created by Gavin Andrews on 12/23/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ColletionViewCell"
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 150.0/2.0
        imageView.backgroundColor = .blue
        
        return imageView
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = contentView.bounds
    }
    
    public func configure(with name: String) {
        myImageView.image = UIImage(named: name)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }

}
