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
                musicTitleLabel.text = musicLayout.title
                artistLabel.text = musicLayout.artist
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
