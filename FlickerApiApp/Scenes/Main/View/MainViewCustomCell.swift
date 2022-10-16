//
//  MainViewCustomCell.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 16.10.2022.
//

import UIKit

final class MainViewCustomCell: UITableViewCell{
    
    static let identifier = "MainViewCustomCell"
    
    var title:String?{
        didSet{
            guard let title = title else { return }
            titleLabel.text = title
        }
    }
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var userNameStackView = {
       let stackView = UIStackView(arrangedSubviews: [profileImageView, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        return stackView
    }()
    
    // TODO: - User intents will be added
    private lazy var addFavouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favourite"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "save"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var buttonStackView = {
       let stackView = UIStackView(arrangedSubviews: [addFavouriteButton, saveButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        addSubview(userNameStackView)
        userNameStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8.0)
            make.top.equalTo(self.snp.top).offset(16.0)
        }
        
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(userNameStackView.snp.bottom).offset(8.0)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(8.0)
            make.bottom.equalTo(self.snp.bottom).offset(-16.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

