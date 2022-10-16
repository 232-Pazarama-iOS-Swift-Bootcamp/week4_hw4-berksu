//
//  SearchViewCell.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 17.10.2022.
//

import UIKit

final class SearchViewCell: UICollectionViewCell{
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(4.0)
            make.bottom.equalTo(self.snp.bottom).offset(-4.0)
            make.leading.equalTo(self.snp.leading).offset(8.0)
            make.trailing.equalTo(self.snp.trailing).offset(-8.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
