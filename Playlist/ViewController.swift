//
//  ViewController.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 19/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    // Declarar as variáveis para guardar os valores vindos da UITextField
    var name = String()
    var username = String()
    var usernameList = [String]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Inicializar o botão "loginButton" como desabilitado (false)
        self.loginButton.isEnabled = false
        
        // Adicionar listener nas UITextField para quando o evento de edição for executado
        [nameTextField, userTextField].forEach({ $0?.addTarget(self,
                                                               action: #selector(editingChanged),
                                                               for: .editingChanged)
        })
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        Network.shared.fetchUsers(name: nameTextField.text!,
                                  username:userTextField.text!,
                                  completion: { result in
            switch result {
            case .success(let userResponse):
                // Percorrer a lista do userResponse
                //Fazer condição para verificar se o usuário passado na variável declarada é igual a algum listado no userResponse
                userResponse!.forEach({
                    if $0.username == self.username {
                        self.usernameList.append($0.username!)
                    }
                })
                
                self.usernameList = self.usernameList.filter { $0 == self.username }
                
                // Se existir, iremos criar a tela de lista de musicas e chamar ela passando o parametro 'userTextField.text'
                if !self.usernameList.isEmpty {
                    // Chamar a função que chama a tela de músicas
                    self.showMusicListViewController(username: self.username)
                } else {
                    //Se nao existir, mandar uma alert com a mensagem de 'usuario nao cadastrado' e com o botao de ok, enviar para tela RegisterViewController
                    self.showAlertView()
                }

            case .failure(let error):
                debugPrint(error)
            }
        })
    }
    
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        showRegisterViewController()
    }
    
    // Chama a RegisterViewController
    private func showRegisterViewController() {
        // Instancia a Storyboard que a ViewController está
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instancia a ViewController a ser chamada
        if let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            
            self.navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
    // TODO: Criar função que chama a tela de lista de músicas (MusicListViewController) passando `username` como parâmetro
    private func showMusicListViewController(username: String) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let musicListViewController = storyboard.instantiateViewController(withIdentifier: "MusicListViewController") as? MusicListViewController {
                musicListViewController.configure(with: username)
                self.navigationController?.pushViewController(musicListViewController, animated: true)
            }
        }
    }
    
    // Função para chamar a AlertView
    private func showAlertView() {
        DispatchQueue.main.async {
            AlertView.showAlertWithTwoButtons(view: self,
                                title: "Ops",
                                message: "User not registered",
                                okButton: "Register",
                                onComplete: { self.showRegisterViewController() })
        }
    }
    
    // Função que verifica se as UITextField estão vazias e habilita/desabilita o botão
    @objc func editingChanged() {
        guard let name = nameTextField.text,
              !name.isEmpty,
              let user = userTextField.text,
              !user.isEmpty else {
            self.loginButton.isEnabled = false
            return
        }
        
        self.name = name
        self.username = user
        
        loginButton.isEnabled = true
    }
}

