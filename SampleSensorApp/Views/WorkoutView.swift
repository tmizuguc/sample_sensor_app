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

import CoreMotion
import SwiftUI

struct WorkoutView: View {
    let workout_name: String
    let timefrequency: Int
    @State var timesecond: Int

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @ObservedObject var sensor = SensorManager()
    @ObservedObject var fileManager = SensorFileManager()

    var body: some View {
        VStack {
            Text("ワークアウト")

            // タイマー
            if self.sensor.isStarted {
                if timesecond > 0 {
                    TimerTextView(text: "\(timesecond)")
                        .onReceive(timer) { _ in
                            if self.timesecond > 0 {
                                self.timesecond -= 1
                                if self.timesecond <= 0 {
                                    stopAction()
                                }
                            }
                        }
                } else {
                    TimerTextView(text: "終了")
                }
            } else {
                TimerTextView(text: "\(timesecond)")
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

    // センサー取得の停止・ファイルの書き出しと更新
    private func stopAction() {
        sensor.stop()
        fileManager.saveFile(data: sensor.recordText, fileName: "\(workout_name)_\(now_yyyymmdd()).csv")
        fileManager.updateFileList(file_prefix: workout_name)
        sensor.clearMotionData()
    }

    // センサー取得の停止
    private func stopOnceAction() {
        sensor.stop()
    }

    // センサー取得の開始
    private func startAction() {
        sensor.start(updateInterval: Double(timefrequency) / 1000)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout_name: "walk", timefrequency: 1000, timesecond: 5)
    }
}
