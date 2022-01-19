//
//  WorkoutSettingView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct WorkoutSettingView: View {
    let workout_name: String
    @State private var timefrequency = "100"
    @State private var timesecond = "10"
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("データ取得間隔")
                    Spacer()
                    TextField("Frequency", text: $timefrequency).multilineTextAlignment(.trailing).keyboardType(.numberPad).fixedSize()
                    Text("ミリ秒")
                }
                HStack {
                    Text("計測時間")
                    Spacer()
                    TextField("TimeSecond", text: $timesecond).multilineTextAlignment(.trailing).keyboardType(.numberPad).fixedSize()
                    Text("秒")
                }
                
                // 計測開始
                NavigationLink {
                    WorkoutView(workout_name: self.workout_name,
                        timefrequency: Int((self.timefrequency as NSString).intValue), timesecond: Int((self.timesecond as NSString).intValue))
                } label: {
                    Text("開始")
                }
            }
        }
    }
}

struct WorkoutSettingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingView(workout_name: "walk")
    }
}

