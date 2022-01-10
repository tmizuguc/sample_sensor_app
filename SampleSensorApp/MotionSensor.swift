//
//  MotionSensor.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//


// 参考：https://yukblog.net/core-motion-basics/
import UIKit
import CoreMotion

class MotionSensor: NSObject, ObservableObject {
    
    @Published var isStarted = false
    
    // 加速度(G)
    @Published var accelerationX = "0.0"
    @Published var accelerationY = "0.0"
    @Published var accelerationZ = "0.0"
    // 回転速度(rad/ms)
    @Published var rotationRateX = "0.0"
    @Published var rotationRateY = "0.0"
    @Published var rotationRateZ = "0.0"
    // 重力(G)
    @Published var gravityX = "0.0"
    @Published var gravityY = "0.0"
    @Published var gravityZ = "0.0"
    // 姿勢(rad/s)
    @Published var attitudePitch = "0.0"
    @Published var attitudeRoll = "0.0"
    @Published var attitudeYaw = "0.0"
    
    // ログ
    private let headerText = "timestamp,accelX,accelY,accelZ,gyroX,gyroY,gyroZ,gravityX,gravityY,gravityZ,attitudeP,attitudeR,attitudeY"
    @Published var recordText = ""
    
    // ログの保存場所
    let documentDirectoryUrl = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first!
    
    
    let motionManager = CMMotionManager()
    
    func start(updateInterval: Double) {
        recordText = "\(headerText)\n"
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = updateInterval
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.updateMotionData(deviceMotion: motion!)
            })
        }
        
        isStarted = true
    }
    
    func stop() {
        isStarted = false
        motionManager.stopDeviceMotionUpdates()
    }
    
    private func updateMotionData(deviceMotion:CMDeviceMotion) {
        
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
}
