//
//  WorkoutView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

//
//  WorkoutSettingView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI
import CoreMotion

struct WorkoutView: View {
    var timefrequency: Double
    @State var timesecond: Double
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    @ObservedObject var sensor = MotionSensor()
    @ObservedObject var fileManager = SensorFileManager()
    
    var body: some View {
        VStack {
            Text("ワークアウト")
            
            // タイマー
            if self.sensor.isStarted {
                if timesecond > 0 {
                    TimerText(text: "\(Int(timesecond / 1000))")
                        .onReceive(timer) { time in
                            if self.timesecond > 0 {
                                self.timesecond -= 1000
                                if self.timesecond <= 0 {
                                    stopAction()
                                }
                            }
                        }
                } else {
                    TimerText(text: "終了")
                }
            } else {
                TimerText(text: "\(Int(timesecond / 1000))")
            }
            
            
            // 計測開始ボタン
            Button(action: {
                self.sensor.isStarted ? stopAction() : startAction()
            }) {
                self.sensor.isStarted ? Text("計測中断") : Text("計測開始")
            }
            
            // ログ一覧
            FileListView()

        }
    }
    
    private func stopAction() {
        self.sensor.stop()
        self.fileManager.saveFile(data: self.sensor.recordText, fileName: "sensor_record_\(Date().timeIntervalSince1970).csv")
        self.fileManager.updateFileList()
    }
    
    private func startAction() {
        self.sensor.start(updateInterval: timefrequency / 1000)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(timefrequency: 1000, timesecond: 5000)
    }
}
