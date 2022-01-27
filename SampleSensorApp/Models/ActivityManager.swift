//
//  ActivityManager.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/27.
//

import CoreMotion
import UIKit

class ActivityManager: NSObject, ObservableObject {
    let motionActivityManager = CMMotionActivityManager()

    @Published var isStarted = false

    // 行動
    var stationaly = false
    var warking = false
    var running = false
    var automotive = false
    var cycling = false
    var confidencial = "Low"

    // ログ
    private let headerText = "timestamp,stationaly,warking,running,automotive,cycling,confidencial"
    @Published var recordText = ""

    // ログの保存場所
    let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func start() {
        recordText = "\(headerText)\n"


        if CMMotionActivityManager.isActivityAvailable() {
            motionActivityManager.startActivityUpdates(to: OperationQueue.current!) { (activity: CMMotionActivity?) in
                self.updateActivityData(activity: activity!)
            }
        }

        isStarted = true
    }

    func stop() {
        isStarted = false
        motionActivityManager.stopActivityUpdates()
    }

    private func updateActivityData(activity: CMMotionActivity) {
        self.stationaly = activity.stationary
        self.warking = activity.walking
        self.running = activity.running
        self.automotive = activity.automotive
        self.cycling = activity.cycling
        
        if activity.confidence == CMMotionActivityConfidence.low {
            self.confidencial = "Low"
        } else if activity.confidence == CMMotionActivityConfidence.medium {
            self.confidencial = "Medium"
        } else if activity.confidence == CMMotionActivityConfidence.high {
            self.confidencial = "High"
        } else {
            self.confidencial = "Unknown"
        }

        // ログ
        recordText += "\(Date().timeIntervalSince1970),"
        recordText += "\(stationaly),\(warking),\(running),\(automotive),\(cycling),\(confidencial)\n"
    }

    func clear() {
        recordText = ""
    }
}
