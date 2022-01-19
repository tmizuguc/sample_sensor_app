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
    let workout_name: String
    let timefrequency: Int
    @State var timesecond: Int
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @ObservedObject var sensor = MotionSensor()
    @ObservedObject var fileManager = SensorFileManager()
    
    var body: some View {
        VStack {
            Text("ワークアウト")
            
            // タイマー
            if self.sensor.isStarted {
                if timesecond > 0 {
                    TimerText(text: "\(timesecond)")
                        .onReceive(timer) { time in
                            if self.timesecond > 0 {
                                self.timesecond -= 1
                                if self.timesecond <= 0 {
                                    stopAction()
                                }
                            }
                        }
                } else {
                    TimerText(text: "終了")
                }
            } else {
                TimerText(text: "\(timesecond)")
            }
            
            // 計測開始ボタン
            Button(action: {
                self.sensor.isStarted ? stopOnceAction() : startAction()
            }) {
                self.sensor.isStarted ? Text("一時停止") : Text("計測開始")
            }.disabled(self.timesecond <= 0)
            
            // ログ一覧
            FileListView(file_prefix: self.workout_name)
        }
    }
    
    private func stopAction() {
        self.sensor.stop()
        self.fileManager.saveFile(data: self.sensor.recordText, fileName: "\(self.workout_name)_\(self.now_yyyymmdd()).csv")
        self.fileManager.updateFileList(file_prefix: self.workout_name)
    }
    
    private func stopOnceAction() {
        self.sensor.stop()
    }
    
    private func startAction() {
        self.sensor.start(updateInterval: Double(timefrequency) / 1000)
    }
    
    private func now_yyyymmdd() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        return df.string(from: date)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout_name: "walk", timefrequency: 1000, timesecond: 5)
    }
}
