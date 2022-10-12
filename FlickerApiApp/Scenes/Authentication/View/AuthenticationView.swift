//
//  AuthenticationView.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 12.10.2022.
//

import UIKit

final class AuthenticationView: UIView{
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .gray
        addSubview(userNameTextField)
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let userNameTextField = {
        let textfield = UITextField(frame: CGRect(x: 10, y: 320, width: 300, height: 30))
        textfield.placeholder = "Username"
        textfield.borderStyle = UITextField.BorderStyle.line
        textfield.backgroundColor = .white
        textfield.textColor = .blue
        return textfield
    }()
}


//// MARK: - Methods
//   private func setupCoinNameLabelLayout() {
//       addSubview(coinNameLabel)
//       coinNameLabel.snp.makeConstraints { make in
//           make.leading.equalTo(20.0)
//           make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32.0)
//       }
//   }
//
//   private func setupIconImageViewLayout() {
//       addSubview(iconImageView)
//       iconImageView.snp.makeConstraints { make in
//           make.leading.equalTo(coinNameLabel.snp.trailing).offset(4.0)
//           make.centerY.equalTo(coinNameLabel.snp.centerY)
//           make.size.equalTo(24.0)
//       }
//   }
