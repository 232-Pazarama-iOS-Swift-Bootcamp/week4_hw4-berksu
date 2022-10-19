//
//  ProfileView.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 17.10.2022.
//

import UIKit

final class ProfileView: UIView{
    
    var name: String?{
        didSet{
            nameLabel.text = name
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person")!
        imageView.contentMode = .scaleAspectFit
        //imageView.setRounded()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var userInfoStackView:UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [profileImageView, nameLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0.0
        return stackView
    }()
    
    let segmentedControl: UISegmentedControl = {
       let sc = UISegmentedControl(items: ["One", "Two"])
           sc.selectedSegmentIndex = 0
           sc.translatesAutoresizingMaskIntoConstraints = false
           return sc
    }()
    
    
    // MARK: - Properties
    private let cellInset: CGFloat = 5.0
    private let cellMultiplier: CGFloat = 0.45
    private var cellDimension: CGFloat {
        .screenWidth * cellMultiplier - cellInset
    }
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellDimension, height: cellDimension)
        return flowLayout
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
                    
        addSubview(userInfoStackView)
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }
        
        addSubview(segmentedControl)
        let favoriteImage = UIImage(named: "favourite")
        segmentedControl.setImage(favoriteImage , forSegmentAt: 0)

        let saveImage = UIImage(named: "save")
        segmentedControl.setImage(saveImage , forSegmentAt: 1)

        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(32.0)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }

        collectionView.register(ProfileViewCell.self , forCellWithReuseIdentifier: "cell")
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16.0)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.equalTo(self.snp.leading).offset(16.0)
            make.trailing.equalTo(self.snp.trailing).offset(-16.0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage{
    func image(scaledTo newSize: CGSize) -> UIImage {
            UIGraphicsBeginImageContext(newSize)
            self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
}

extension UIImageView {

   func setRounded() {
       self.layer.cornerRadius = self.frame.size.height/2
       self.layer.borderWidth = 1
       self.layer.borderColor = UIColor.blue.cgColor
       self.layer.masksToBounds = false

       self.clipsToBounds = true
   }
}
