//
//  ProfileViewCell.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 18.10.2022.
//

import UIKit

final class ProfileViewCell: UICollectionViewCell{
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
