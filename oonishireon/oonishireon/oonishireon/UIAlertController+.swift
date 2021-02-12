//
//  UIAlertController+.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/11.
//

import UIKit

extension UIAlertController {
    static func alert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "閉じる", style: .default, handler: handler))
        return alert
    }
}
