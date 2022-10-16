//
//  AuthenticationView.swift
//  FlickerApiApp
//
//  Created by Berksu Kısmet on 12.10.2022.
//

import UIKit

final class AuthenticationView: UIView{

    var password: String? {
        get{
            if(segmentedControl.selectedSegmentIndex == 0){
                if let password = passwordTextField.text{
                    return password
                }
            }else{
                if let password = passwordTextField.text, let reTypedPassword = passwordRetypeTextField.text{
                    if password == reTypedPassword{
                        return password
                    }
                }
            }
            return nil
        }
    }
    
    var mailAddress: String?{
        get{
            if let email = userNameTextField.text, email.isValidEmail{
                return email
            }
            return nil
        }
    }
    
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        addTitleLabel()
        segmentedControl.selectedSegmentIndex = 0
        passwordRetypeTextField.isHidden = segmentedControl.selectedSegmentIndex == 0 ? true:false
        jobTextLabel.isHidden = segmentedControl.selectedSegmentIndex == 0 ? true:false

        // Add all views in stack view
        let stackView = UIStackView(arrangedSubviews: [segmentedControl,
                                                       userNameTextField,
                                                       passwordTextField,
                                                       passwordRetypeTextField,
                                                       jobTextLabel,
                                                       signInSignUpButton])
        

        
        stackView.axis = .vertical
        stackView.spacing = 20.0
        stackView.distribution = .fillEqually
        //stackView.alignment = .center
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16.0)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16.0)
        }
        //addTitleLabel()
        //addSegmentedControl()
        //addUserNameTextField()
        //addPasswordTextField()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "Flicker Api App"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    func addTitleLabel(){
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    let segmentedControl = {
        let items = ["Sign In", "Sign Up"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 35, y: 200, width: 250, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 1
        return segmentedControl
    }()
    
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
            switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                signInSignUpButton.setTitle("Sign In", for: .normal)
                passwordRetypeTextField.isHidden = true
                jobTextLabel.isHidden = true
            case 1:
                signInSignUpButton.setTitle("Sign Up", for: .normal)
                passwordRetypeTextField.isHidden = false
                jobTextLabel.isHidden = false
            default:
                break
            }
    }
    
    func addSegmentedControl(){
        addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32.0)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
        }
    }
    
    
    private let userNameTextField = {
        let textfield = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        textfield.placeholder = "Username"
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.tintColor = .black
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8.0
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.backgroundColor = .white
        textfield.textColor = .darkGray
        return textfield
    }()
    
    func addUserNameTextField(){
        addSubview(userNameTextField)
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(32.0)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(32.0)
        }
    }
    
    private let passwordTextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        textfield.textAlignment = .left
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        textfield.tintColor = .black
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8.0
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.backgroundColor = .white
        textfield.textColor = .darkGray
        return textfield
    }()
    
    private let passwordRetypeTextField = {
        let textfield = UITextField()
        textfield.placeholder = "Re-type Password"
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        textfield.textAlignment = .left
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.isSecureTextEntry = true
        textfield.tintColor = .black
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8.0
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.backgroundColor = .white
        textfield.textColor = .darkGray
        return textfield
    }()

    private let jobTextLabel = {
        let textfield = UITextField()
        textfield.placeholder = "Job Title"
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textfield.leftViewMode = .always
        textfield.leftView = spacerView
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.tintColor = .black
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 8.0
        textfield.layer.borderColor = UIColor.darkGray.cgColor
        textfield.layer.borderWidth = 1.0
        textfield.backgroundColor = .white
        textfield.textColor = .darkGray
        return textfield
    }()
    
    func addPasswordTextField(){
        addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(16.0)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-16.0)
        }
    }
    
    // MARK: - Define UIButtons
    let signInSignUpButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1.0
        button.setTitle("Sign In", for: .normal)
        return button
    }()
    
    
}
