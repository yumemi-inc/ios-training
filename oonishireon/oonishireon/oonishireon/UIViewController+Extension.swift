//
//  UIViewController+Extension.swift
//  oonishireon
//
//  Created by 大西 玲音 on 2021/02/11.
//

import UIKit

extension UIViewController {
    func present(_ alert: UIAlertController, completion: (() -> Void)? = nil) {
        present(alert, animated: true, completion: completion)
    }
}
