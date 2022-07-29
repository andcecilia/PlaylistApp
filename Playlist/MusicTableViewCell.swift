//
//  MusicTableViewCell.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 28/07/22.
//

import UIKit

class MusicTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var musicTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var musicLayout: Music? {
            // TODO: Utilizar o `didSet` para podermos inicializar as informações e não vir nulas
            didSet {
                guard let musicLayout = musicLayout else { return }
                musicTitleLabel.text = musicLayout.title?.capitalized
                musicTitleLabel.font = .boldSystemFont(ofSize: 20)
                artistLabel.text = musicLayout.artist?.capitalized
                artistLabel.font = .systemFont(ofSize: 14, weight: .thin)
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
