//
//  SeedRandomNumberGenerator.swift
//
//
//  Created by 古宮 伸久 on 2022/04/08.
//

import Foundation

struct SeedRandomNumberGenerator: RandomNumberGenerator {
    init(seed: Int) {
        // Set the random seed
        srand48(seed)
    }

    func next() -> UInt64 {
        UInt64(drand48() * Double(UInt64.max))
    }
}
