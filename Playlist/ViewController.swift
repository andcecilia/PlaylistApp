//
//  ViewController.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 19/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        Network.shared.fetchUsers(name: nameTextField.text!,
                                  username:userTextField.text!,
                                  completion: { result in
            switch result {
            case .success(let userResponse):
                
                //TODO: CHECK IF THE USERNAME ALREADY EXISTS IN THE DATABASE
                // Percorrer a lista -> Se nao existir, mandar uma alert com a mensagem de 'usuario nao cadastrado' e com o botao de ok, enviar para tela RegisterViewController
                // Se existir, iremos criar a tela de lista de musicas e chamar ela passando o parametro 'userTextField.text'
                
                
                debugPrint("\(userResponse)")
            case .failure(let error):
                debugPrint(error)
            }
        })
    }
                                  
    @IBAction func didTapRegisterButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
                    
                    self.navigationController?.pushViewController(registerViewController, animated: true)
                }
    }
}

