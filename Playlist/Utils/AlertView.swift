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
                         cancelButton: String?,
                         okButton: String?,
                         onComplete: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButton ?? "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: okButton ?? "Ok",
                                      style: .default,
                                      handler: { alert in
            onComplete()
        }))
        
        view.present(alert,
                     animated: true,
                     completion: nil)
    }
}
