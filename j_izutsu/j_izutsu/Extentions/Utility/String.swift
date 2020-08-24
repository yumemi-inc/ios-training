//
//  String.swift
//  j_izutsu
//
//  Created by 井筒 順 on 2020/08/24.
//  Copyright © 2020 井筒 順. All rights reserved.
//

import Foundation

extension String {
    func removeAt(text: String) -> String? {
        if let range = self.range(of: text) { return self.replacingCharacters(in: range, with: "") }
        return nil
    }
}

