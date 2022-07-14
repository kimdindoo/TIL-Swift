//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 김진수 on 2022/07/15.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        
        
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
//        //신규 사용자 생성
//        Auth.auth().createUser(withEmail: email, password: password) {[weak self] AuthDataResult,error in
//            guard let self = self else { return }
//
//            self.showMainViewController()
//
//        }
//
//    }
    
    
    //신규 사용자 생성
    Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
        guard let self = self else { return }
      
        self.showMainViewController()

    }
}
    
    ///Main 화면으로 보내기
    func showMainViewController() {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard?.instantiateViewController(identifier: "MainViewController")
        mainViewController?.modalPresentationStyle = .fullScreen
//        self.navigationController?.show(mainViewController, sender: nil)
        self.present(mainViewController!, animated: true, completion: nil)
    }
}

//    ///Main 화면으로 보내기 - 왜 안될까?
//    func showMainViewController() {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
//        mainViewController.modalPresentationStyle = .fullScreen
//        self.navigationController?.show(mainViewController, sender: nil)
//    }
//}


extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
