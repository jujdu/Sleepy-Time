//
//  UIViewController+Extension.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 06.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

extension UIViewController {
    func createAttentionAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Attention", message: "Unfortunately, the application cannot support iCloud Media Library and Apple Music because of copyright issues 😢. However, you still have possibility to upload your own music to iTunes throught Music App.\nThank's for your understanding.\n🙏", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        let neverShow = UIAlertAction(title: "Never show", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(neverShow)
        return alert
    }
}
