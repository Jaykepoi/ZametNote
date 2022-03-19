//
//  RegisterViewController.swift
//  Notes
//
//  Created by Mikhail Kim on 07.11.2021.
//


import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    
    
    let api = NotesApi.shared
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        registerUser()
    }
    
    
    private func registerUser() {
        guard
            let login = emailTextField.text,
            let password = passwordTextField.text,
            let userName = userNameTextField.text,
            let userLastName = userLastNameTextField.text,
            !login.isEmpty,
            !password.isEmpty,
            !userName.isEmpty,
            !userLastName.isEmpty
        else {
            showAlert(title: "Ошибка!",
                      message: "Заполните все поля")
            return
        }
        
        
        var dict = [String: String]()
        
        dict["email"] = login
        dict["password"] = password
        dict["name"] = userName
        dict["last_name"] = userLastName
        
        api.registerUser(dict: dict) { isSuccess in
            if isSuccess {
                self.showAlert(title: "Успех",
                               message: "Вы успешно прошли регистрацию, теперь вам надо авторизоваться") {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.showAlert(title: "Ошибка",
                               message: "Не удалось зарегестирроваться, повторите попытку поздее")
            }
        }
    }
}
