//
//  RegisterViewController.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 19/07/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // Criar variaveis para poder guardar os valores das textFields
    var user = String()
    var username = String()
    
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
    }
    
    //Ação de clicar no registerButton
    @IBAction func didTapRegisterButton(_ sender: Any) {
        //chamar a função de validação de campos, passando como parametros, as variaveis criadas para guardar os valores das textFields
        validateFields(name: user, username: username)
    }
    
    // Função de validação para verificar se os campos estao vazios
    func validateFields(name: String, username: String) {
        if !name.isEmpty && !username.isEmpty {
            // Chamar a funcao que habilita o botao
            self.enableRegisterButton()
            
            // Faz a chamada de POST para a API
            Network.shared.postUser(name: name, username: username)
        }
    }

    // Funcao para habilitar o registerButton
    func enableRegisterButton() {
        registerButton.isEnabled = true
    }
    
    // Quando é clicado e adicionado valor no campo nameTextField, o valor é alterado
    @IBAction func nameTextFieldEditingDidEnd(_ sender: Any) {
        //Guarda-se o valor digitado no campo pelo usuário na variável
                user = nameTextField.text ?? String()
    }
   
    // Quando é clicado e adicionado valor no campo userTextField, o valor é alterado
    
    @IBAction func userTextFieldEditingDidEnd(_ sender: Any) {
        //Guarda-se o valor digitado no campo pelo usuário na variávell
                username = userTextField.text ?? String()
            }
}
