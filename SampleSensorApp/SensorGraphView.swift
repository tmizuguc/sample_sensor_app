//
//  SensorGraphView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI


struct SensorGraphView: View {
    var recordString: String
    let sensorDataManager = SensorDataManager()
        
    var body: some View {
        VStack {
//            Text("\(recordString)")
            let sensorList = sensorDataManager.csvStringToSensor(csvString: recordString)
            if sensorList.count > 0 {
                let timestamp = sensorList.map { $0.timestamp }
                let accelerationX = sensorList.map { $0.accelerationX }
                let accelerationY = sensorList.map { $0.accelerationY }
                let accelerationZ = sensorList.map { $0.accelerationZ }
                
                Text("\(sensorList[0].accelerationX)")
                Text("\(sensorList[0].accelerationY)")
            }
        }
    }
    
}

struct SensorGraphView_Previews: PreviewProvider {
    static var previews: some View {
        SensorGraphView(recordString: "aa,aa,bb,cc,aa,bb,cc,aa,bb,cc,aa,bb,cc\n0,0.03395538845062256,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4\n1,1.01,2.2,3.4,1.01,2.2,3.4,1.01,2.2,3.4,1.01,2.2,3.4")
//        SensorGraphView(recordString: "0,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4\n1,1.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4")
    }
}
