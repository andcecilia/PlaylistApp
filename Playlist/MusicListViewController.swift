//
//  MusicListViewController.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 24/07/22.
//

import UIKit
import Foundation

// TODO: Criar a model `Music
class MusicListViewController: UIViewController {
    
    var id = 0
    var musicList = [Music]()
    
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
        
        setUpTableView()
    }
    
    private func setUpTableView() {
           // TODO: Registrar a célula (XIB)
           tableView.register(cellType: MusicTableViewCell.self)
           
           tableView.dataSource = self
       }
    
    // TODO: Criar função para adicionar artista e música
    @objc func didTapAddMusicButton() {
        
        // TODO: criar o alert para pegar as informações de `artist` e `title`
        let alert = UIAlertController(title: "Teste",
                                      message: "Teste",
                                      preferredStyle: .alert)
        
        alert.addTextField { firstTextfield in
            firstTextfield.placeholder = "Type the artist name"
        }
        
        alert.addTextField { secondTextField in
            secondTextField.placeholder = "Type the music title"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add",
                                      style: .default,
                                      handler: { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
            if let firstText = textFields[0].text,
               let secondText = textFields[1].text {
                
                // Chamar a função para fazer o `post` de `artist` e `title` como parâmetros
                self.postMusic(artist: firstText, title: secondText)
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    // TODO: Criar função para fazer o `post` de `artist` e `title` como parâmetros
    func postMusic(artist: String, title: String) {
        id += 1
        Network.shared.postMusic(id: id, artist: artist, title: title, username: "Ceci")
    }
}

//MARK: - TableViewDataSource Extension
extension MusicListViewController: UITableViewDataSource {
    // TODO: Retornar a quantidade de itens da lista
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //musicList.count
    }
    
    
    // TODO: Instanciar a célula (XIB) e passar as informações vindas de cada linha (IndexPath) para preencher a célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        //cell.musicLayout = musicList[indexPath.row]
        return cell
        
    }
}
