//
//  SheetView.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 18.10.2022.
//

import UIKit

final class SheetView: UIView{
    
    // For controlling user's reactions on image as adding favourite
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
    
    // For controlling user's reactions on image as saving
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
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - User intents
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
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
