//
//  SensorData.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import CoreMotion

struct SensorData {
    var timestamp: Double
    var accelerationX: Double
    var accelerationY: Double
    var accelerationZ: Double
    // 回転速度(rad/ms)
    var rotationRateX: Double
    var rotationRateY: Double
    var rotationRateZ: Double
    // 重力(G)
    var gravityX: Double
    var gravityY: Double
    var gravityZ: Double
    // 姿勢(rad/s)
    var attitudePitch: Double
    var attitudeRoll: Double
    var attitudeYaw: Double
}

class SensorDataManager: NSObject, ObservableObject {
    func csvStringToSensor(csvString: String) -> [SensorData] {
        var csvArray: [[Double]] = []
        let rows = csvString.components(separatedBy: "\n")
        // row[0]はカラム名なので使用しない
        for row in rows.suffix(from: 1) {
            let columnStrings = row.components(separatedBy: ",")
            let columns = columnStrings.map { ($0 as NSString).doubleValue }
            csvArray.append(columns)
        }

        var sensorList: [SensorData] = []
        if csvArray.count > 0 {
            for i in 0 ..< (csvArray.count - 1) {
                let sensor = SensorData(timestamp: csvArray[i][0], accelerationX: csvArray[i][1], accelerationY: csvArray[i][2], accelerationZ: csvArray[i][3], rotationRateX: csvArray[i][4], rotationRateY: csvArray[i][5], rotationRateZ: csvArray[i][6], gravityX: csvArray[i][7], gravityY: csvArray[i][8], gravityZ: csvArray[i][9], attitudePitch: csvArray[i][10], attitudeRoll: csvArray[i][11], attitudeYaw: csvArray[i][12])
                sensorList.append(sensor)
            }
        }
        return sensorList
    }
}
