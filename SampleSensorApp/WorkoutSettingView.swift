//
//  WorkoutSettingView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct WorkoutSettingView: View {
    @State private var timefrequency = "0"
    @State private var timesecond = "0"
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("データ取得間隔(ms)")
                    TextField("Frequency", text: $timefrequency).keyboardType(.numberPad)
                }
                HStack {
                    Text("計測時間(ms)")
                    TextField("TimeSecond", text: $timesecond).keyboardType(.numberPad)
                }
                
                // 計測開始
                NavigationLink {
                    WorkoutView(timefrequency: (self.timefrequency as NSString).doubleValue, timesecond: (self.timesecond as NSString).doubleValue)
                } label: {
                    Text("開始")
                }
                
                // 計測ログ
                NavigationLink {
                    FileListView()
                } label: {
                    Text("記録")
                }
            }
        }
    }
}

struct WorkoutSettingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingView()
    }
}

