//
//  RegisterViewController.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 19/07/22.
//

import UIKit
import Lottie

class RegisterViewController: UIViewController {
    
    lazy var checkAnimation = Animation.named("lottiecheck", bundle: .main)
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializar o botao "registerButton" como desabilitado (false)
        registerButton.isEnabled = false
        // Esconder a animação com o 'check' de quando se cria a conta
        checkAnimationView.isHidden = true
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
        Network.shared.postUser(name: name, username: username) { result in
            switch result {
                case true:
                DispatchQueue.main.async {
                    self.hideRegisterElements()
                    self.showCheckAnimation()
                }
                
            case false:
                debugPrint("Deu ruim")
                DispatchQueue.main.async {
                    AlertView.showAlert(view: self,
                                        title: "Ops",
                                        message: "User already exists!",
                                        onComplete: {self.dismiss(animated: true)})
                }
            }
        }
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
    
    func hideRegisterElements() {
        [nameLabel,
         nameTextField,
         userLabel,
         userTextField,
         registerButton].forEach({ $0?.isHidden = true })
    }
    
    func showCheckAnimation() {
        checkAnimationView.isHidden = false
        checkAnimationView.animation = checkAnimation
        checkAnimationView.contentMode = .scaleAspectFill
        checkAnimationView.loopMode = .playOnce
        checkAnimationView.play { (finished) in
            self.checkAnimationView.isHidden = true
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
