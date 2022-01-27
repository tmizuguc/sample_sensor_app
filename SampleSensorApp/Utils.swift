//
//  Utils.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/27.
//

import Foundation

// 現在時刻の取得
public func now_yyyymmdd() -> String {
    let date = Date()
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd_HH:mm:ss"
    return df.string(from: date)
}
