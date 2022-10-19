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

    private var isFavouriteTouched = false
    var isFavuriteButtonTouched: Bool{
        get{
            return isFavouriteTouched
        }
        set{
            if newValue {
                addFavouriteButton.setImage(UIImage(named: "favourite_plus"), for: .normal)
                addFavouriteButton.tintColor = .red
            }else {
                addFavouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
                addFavouriteButton.tintColor = .black
            }
            isFavouriteTouched = newValue
        }
    }
    
    private var isSaveTouched = false
    var isSaveButtonTouched: Bool{
        get{
            return isSaveTouched
        }
        set{
            if newValue {
                saveButton.setImage(UIImage(named: "saved"), for: .normal)
                saveButton.tintColor = .green
            }else {
                saveButton.setImage(UIImage(named: "save"), for: .normal)
                saveButton.tintColor = .black
            }
            isSaveTouched = newValue
        }
    }
    
    func createLine() -> UIView {
        var lineView = UIView(frame: CGRect())
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.black.cgColor
        return lineView
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
    
    // MARK: - User intents will be added
    lazy var addFavouriteButton: SubclassedUIButton = {
        let button = SubclassedUIButton()
        button.setImage(UIImage(named: "favourite"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var saveButton: SubclassedUIButton = {
        let button = SubclassedUIButton()
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
        
        let lineAtTheTop = createLine()
        addSubview(lineAtTheTop)
        lineAtTheTop.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.snp.top)
        }
        addSubview(userNameStackView)
        userNameStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8.0)
            make.top.equalTo(lineAtTheTop.snp.bottom).offset(8.0)
        }
        
        let lineAtThebottomOFUserStack = createLine()
        addSubview(lineAtThebottomOFUserStack)
        lineAtThebottomOFUserStack.snp.makeConstraints { make in
            make.top.equalTo(userNameStackView.snp.bottom).offset(16.0)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(lineAtThebottomOFUserStack.snp.bottom).offset(8.0)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let lineAtTheBottomOfImage = createLine()
        addSubview(lineAtTheBottomOfImage)
        lineAtTheBottomOfImage.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(16.0)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(lineAtTheBottomOfImage.snp.bottom).offset(8.0)
            make.bottom.equalTo(self.snp.bottom).offset(-16.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

