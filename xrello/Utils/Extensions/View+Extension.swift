//
//  View+Extension.swift
//  xrello
//
//  Created by Robihamanto on 2022/1/27.
//

import Foundation
import UIKit
import SwiftUI

extension View {
    
    func presentAlertTextField(title: String, message: String? = nil, defaultTextFieldText: String?  = nil, confirmAction: @escaping (String?) -> ()) {
        guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.rootViewController else { return }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = defaultTextFieldText
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            guard let textField = alertController.textFields?.first else { return }
            confirmAction(textField.text)
        }))
        
        rootViewController.present(alertController, animated: true, completion: nil)
    }
    
    
}
