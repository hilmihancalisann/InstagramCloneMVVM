//
//  RegistrationController.swift
//  InstagramCloneMVVM
//
//  Created by Hilmihan Çalışan on 23.03.2023.
//

import UIKit

class RegistrationController: UIViewController{
    
    
    //MARK: - Properties
    
    private var viewModel = RegisterViewModel()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
        
    }()
    
    private let emailTextField: CustomTextField = {
      
        let rmail = CustomTextField(placeholder: "Email")
        rmail.keyboardType = .emailAddress
        return rmail
    }()
    
    private let passwordTextFiel: UITextField = {
       
        let rpas = CustomTextField(placeholder: "Password")
        rpas.isSecureTextEntry = true
        return rpas
        
    }()
    
    private let fullnameTextField = CustomTextField(placeholder: "Fullname")
    private let usernameTextField = CustomTextField(placeholder: "Usernmae")
    
    private let signUpButton: UIButton = {
       
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = true
         
        return button
        
    }()
    
    private let alreadyHaveAccount: UIButton = {
       
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    
    //MARK: - Actions
    
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else {return}
        guard let password  = passwordTextFiel.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        
        guard let profileImage = self.profileImage else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @objc func handleShowLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        
        if sender == emailTextField {
            viewModel.email = sender.text
            
        }else if sender == passwordTextFiel {
            viewModel.password = sender.text
        }else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        }else {
            viewModel.username = sender.text
        }
        
        updateForm()
        
    }
    
    @objc func handleProfilePhotoSelect() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    
    //MARK: - Helpers
    
    func configureUI(){
        
        configureGradientLayer()
        
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top:view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextFiel, fullnameTextField, usernameTextField, signUpButton])
        
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.centerX(inView: view)
        alreadyHaveAccount.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configureNotificationObservers() {
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextFiel.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
         
    }
    
}



//MARK: - FormViewModel


extension RegistrationController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsVlid
    }
}


//MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}


