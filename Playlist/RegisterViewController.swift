//
//  RegisterViewController.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 19/07/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializar o botao "registerButton" como desabilitado (false)
        registerButton.isEnabled = false
        
        // Adicionar listener nas UITextField para quando o evento de edição for executado
        [nameTextField, userTextField].forEach({ $0?.addTarget(self,
                                                               action: #selector(editingChanged),
                                                               for: .editingChanged)})
        
    }
    
    //Ação de clicar no registerButton
    @IBAction func didTapRegisterButton(_ sender: Any) {
        // Validar se os campos digitados nas UITextField não são nulos
        guard let name = nameTextField.text, let username = userTextField.text else {
            self.registerButton.isEnabled = false
            return
        }

            // Faz a chamada de POST para a API
        Network.shared.postUser(name: name, username: username)
    }
    
    // Função que verifica se as UITextField estão vazias e habilita/desabilita o botão
    @objc func editingChanged() {
        guard let name = nameTextField.text,
              !name.isEmpty,
              let user = userTextField.text,
              !user.isEmpty else {
            self.registerButton.isEnabled = false
            return
        }
        
        registerButton.isEnabled = true
    }
    
}
