//
//  MusicListViewController.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 24/07/22.
//

import UIKit

// TODO: Criar a model `Music
class MusicListViewController: UIViewController {
    
    // TODO: Criar o botão de `+`
    private lazy var addMusicButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapAddMusicButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemBlue
        button.sizeToFit()
        return button
    }()
    
    //TODO: Conectar as Outlets
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addMusicButton)

    }
    
    
    // TODO: Criar função para adicionar artista e música
    @objc func didTapAddMusicButton() {
        var artist = String()
        var title = String()
        
        // TODO: criar o alert para pegar as informações de `artist` e `title`
        let alert = UIAlertController(title: String(),
                                      message: "Input text",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Artist Name"
            artist = textField.text!
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Music Title"
            title = textField.text!
        }
        
        // TODO: Adicionar o botão de ok e chamar a função de post
        
        self.present(alert, animated: true, completion: nil)
        
        
         // Chamar a função para fazer o `post` de `artist` e `title` como parâmetros
        postMusic(artist: artist, title: title)
    }

    // TODO: Criar função para fazer o `post` de `artist` e `title` como parâmetros
    func postMusic(artist: String, title: String) {
        Network.shared.postMusic(artist: artist, title: title)
    }

}
