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
    
    var id: Int?
    var musicList = [Music]()
    var idList = [Int]()
    
    private var username: String?
    
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
        
        fetchMusicList(username: username ?? String())
    }
    
    public func configure(with username: String?) {
        self.username = username
    }
    
    private func setUpTableView() {
        // TODO: Registrar a célula (XIB)
        tableView.register(cellType: MusicTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
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
        Network.shared.postMusic(id: id ?? 1, artist: artist, title: title, username: self.username ?? String())
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            self.fetchMusicList(username: self.username ?? String())
            self.tableView.reloadData()
        }
        
    }
    
    // TODO: Fazer a requisição para o backend
    func fetchMusicList(username: String) {
        Network.shared.fetchMusic(username: username, completion: { result in
            switch result {
            case .success(let musicResponse):
                //if the result carries an optional value, it should be unwrapped or given two ?? optional chains and the data type as a default value.
                
                DispatchQueue.main.async {
                    //adding musicResponse into musicList
                    self.musicList = musicResponse ?? []
                    // Percorrer o array de musicResponse
                    debugPrint("id global antes do for: \(self.id)")
                    musicResponse!.forEach({
                        // Se o id (variável global) for nil, então id (variável global) vai receber do musicResponse.id (valor do back e ele sobrescreve)
                        if self.id == nil {
                            self.id = $0.id
                            debugPrint("id global caso valor seja nil: \(self.id)")
                            debugPrint("musicResponse.id: \($0.id)")
                        } else {
                            // Se o valor do id (variável global) for diferente do valor que vem do musicResponse.id (valor do back), então id (variável global) vai receber do musicResponse.id (valor do back e ele sobrescreve)
                            if self.id != $0.id {
                                self.id = $0.id
                                debugPrint("id global caso valor seja diferente do valor vindo do back: \(self.id)")
                                debugPrint("musicResponse.id: \($0.id)")
                            }
                        }
                    })
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                debugPrint(error)
            }
        })
    }
}

//MARK: - TableViewDataSource Extension
extension MusicListViewController: UITableViewDataSource {
    // TODO: Retornar a quantidade de itens da lista
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    
    // TODO: Instanciar a célula (XIB) e passar as informações vindas de cada linha (IndexPath) para preencher a célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.musicLayout = musicList[indexPath.row]
        return cell
        
    }
}

extension MusicListViewController: UITableViewDelegate {
    //This fucntion let table view knows you can delete a music entry
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // TODO: Função da TableView que faz a ação dos swipes e chama as funções de deletar e editar
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteRow(indexPath)
            completionHandler(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [delete])

        return configuration
    }
    
    // TODO: Função que vai fazer o delete (chamar a API de delete) da linha
    func deleteRow(_ indexPath: IndexPath) {
        tableView.beginUpdates()
        Network.shared.deleteMusic(username: musicList[indexPath.row].username ?? String() , id: musicList[indexPath.row].id ?? 0)
        musicList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    // TODO: Função que vai fazer o edit (chamar a API de edit) da linha}
}
