//
//  MotionSensor.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import CoreMotion
// 参考：https://yukblog.net/core-motion-basics/
import UIKit

class SensorManager: NSObject, ObservableObject {
    let motionManager = CMMotionManager()
    let motionActivityManager = CMMotionActivityManager()

    @Published var isStarted = false

    // 加速度(G)
    var accelerationX = "0.0"
    var accelerationY = "0.0"
    var accelerationZ = "0.0"
    // 回転速度(rad/ms)
    var rotationRateX = "0.0"
    var rotationRateY = "0.0"
    var rotationRateZ = "0.0"
    // 重力(G)
    var gravityX = "0.0"
    var gravityY = "0.0"
    var gravityZ = "0.0"
    // 姿勢(rad/s)
    var attitudePitch = "0.0"
    var attitudeRoll = "0.0"
    var attitudeYaw = "0.0"

    // ログ
    private let headerText = "timestamp,accelX,accelY,accelZ,gyroX,gyroY,gyroZ,gravityX,gravityY,gravityZ,attitudeP,attitudeR,attitudeY"
    @Published var recordText = ""

    // ログの保存場所
    let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    func start(updateInterval: Double) {
        recordText = "\(headerText)\n"

        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = updateInterval
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion: CMDeviceMotion?, _: Error?) in
                self.updateMotionData(deviceMotion: motion!)
            })
        }

        isStarted = true
    }

    func stop() {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
    }

    private func updateMotionData(deviceMotion: CMDeviceMotion) {
        // 加速度(G)
        accelerationX = String(deviceMotion.userAcceleration.x)
        accelerationY = String(deviceMotion.userAcceleration.y)
        accelerationZ = String(deviceMotion.userAcceleration.z)
        // 回転速度(rad/ms)
        rotationRateX = String(deviceMotion.rotationRate.x)
        rotationRateY = String(deviceMotion.rotationRate.y)
        rotationRateZ = String(deviceMotion.rotationRate.z)
        // 重力(G)
        gravityX = String(deviceMotion.gravity.x)
        gravityY = String(deviceMotion.gravity.y)
        gravityZ = String(deviceMotion.gravity.z)
        // 姿勢(rad/s)
        attitudePitch = String(deviceMotion.attitude.pitch)
        attitudeRoll = String(deviceMotion.attitude.roll)
        attitudeYaw = String(deviceMotion.attitude.yaw)

        // ログ
        recordText += "\(Date().timeIntervalSince1970),"
        recordText += "\(accelerationX),\(accelerationY),\(accelerationZ),"
        recordText += "\(rotationRateX),\(rotationRateY),\(rotationRateZ),"
        recordText += "\(gravityX),\(gravityY),\(gravityZ),"
        recordText += "\(attitudePitch),\(attitudeRoll),\(attitudeYaw)\n"
    }

    func clear() {
        recordText = ""
    }
}
