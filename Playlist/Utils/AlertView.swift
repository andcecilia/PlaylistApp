//
//  AlertView.swift
//  Playlist
//
//  Created by Cecilia Andrea Pesce on 24/07/22.
//

import Foundation
import UIKit

class AlertView: NSObject {
    class func showAlert(view: UIViewController,
                         title: String,
                         message: String,
                         cancelButton: String? = "Cancel",
                         okButton: String? = "Ok",
                         onComplete: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButton, style: .cancel))
        alert.addAction(UIAlertAction(title: okButton,
                                      style: .default,
                                      handler: { alert in
            onComplete()
        }))
        
        view.present(alert,
                     animated: true,
                     completion: nil)
    }
    class func showAlertWithDoubleTextfield(view: UIViewController,
                                            title: String,
                                            message: String,
                                            cancelButton: String? = "Cancel",
                                            okButton: String? = "Ok",
                                            onComplete: @escaping () -> (firstText: String, secondText: String)) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addTextField { firstTextfield in
            firstTextfield.placeholder = "Type the artist name"
        }
        
        alert.addTextField { secondTextField in
            secondTextField.placeholder = "Type the music title"
        }
        
        alert.addAction(UIAlertAction(title: cancelButton, style: .cancel))
        alert.addAction(UIAlertAction(title: okButton,
                                      style: .default,
                                      handler: { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
            if let firstText = textFields[0].text,
               let secondText = textFields[1].text {
                onComplete()
            }
        }))
        
        view.present(alert,
                     animated: true,
                     completion: nil)
        
    }
}
