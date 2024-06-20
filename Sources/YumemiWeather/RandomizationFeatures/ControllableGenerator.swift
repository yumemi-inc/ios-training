//
//  ControllableGenerator.swift
//
//
//  Created by 古宮 伸久 on 2022/04/08.
//

import Foundation

/// 制御可能な乱数生成器です。
struct ControllableGenerator {
    
    /// 唯一のインスタンスを生成します。
    ///
    /// このイニシャライザーは、複数回呼び出しても意味がありません。
    /// 乱数生成方法の都合で、同じ振る舞いをするインスタンスになります。
    private init() {
    }
}

extension ControllableGenerator {
    
    /// 唯一の、制御可能な乱数生成器インスタンスです。
    static var shared = ControllableGenerator()
    
    /// 乱数生成時に使用するシード値を `seed` でリセットします。
    /// - Parameter seed: 新たに使用するシード値です。
    static func reset(withSeed seed: Int) {
        srand48(seed)
    }
    
    /// 乱数生成時に使用するシード値を `area` と `date` から算出してリセットします。
    /// - Parameters:
    ///   - area: シード値の算出に使う、地域情報
    ///   - date: シード値の算出に使う、日付情報
    static func resetUsing(area: Area, date: Date) {
        
        var hasher = Hasher()
        
        hasher.combine(area)
        hasher.combine(date)
        
        let seed = hasher.finalize()
        
        reset(withSeed: seed)
    }
}

extension ControllableGenerator : RandomNumberGenerator {
    
    /// 次の乱数を生成します。
    /// - Returns: 次の乱数です。
    func next() -> UInt64 {
        UInt64(drand48() * Double(UInt64.max))
    }
}
