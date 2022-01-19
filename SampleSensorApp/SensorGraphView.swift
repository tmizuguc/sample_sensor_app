//
//  SensorGraphView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI
import Charts

struct SensorGraphView: View {
    var recordString: String
    
    var body: some View {
        TabView{
            AccerationGraphView(recordString: recordString)
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                    Text("加速度")
                }
            GyroGraphView(recordString: recordString)
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                    Text("ジャイロ")
                }
            GravityGraphView(recordString: recordString)
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                    Text("重力")
                }
            AttitudeGraphView(recordString: recordString)
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                    Text("姿勢")
                }
        }
    }
}

// 加速度
struct AccerationGraphView: UIViewRepresentable {

    var recordString: String
    let sensorDataManager = SensorDataManager()
    
    typealias UIViewType = LineChartView
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChartView = LineChartView()
        
        let sensorList = sensorDataManager.csvStringToSensor(csvString: recordString)
        if sensorList.count > 0 {
            let timestamp = sensorList.map { $0.timestamp }
            let accelerationX = sensorList.map { $0.accelerationX }
            let accelerationY = sensorList.map { $0.accelerationY }
            let accelerationZ = sensorList.map { $0.accelerationZ }
            
            let chartDataSet1 = buildChartDataSet(xList: timestamp, yList: accelerationX, label: "Acceleration X", color: .orange)
            let chartDataSet2 = buildChartDataSet(xList: timestamp, yList: accelerationY, label: "Acceleration Y", color: .blue)
            let chartDataSet3 = buildChartDataSet(xList: timestamp, yList: accelerationZ, label: "Acceleration Z", color: .purple)
            let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2, chartDataSet3])
            lineChartView.data = chartData
            
            // 表示修正
            lineChartView.rightAxis.enabled = false
            lineChartView.xAxis.enabled = false
        }

        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {

    }
}

// ジャイロ
struct GyroGraphView: UIViewRepresentable {

    var recordString: String
    let sensorDataManager = SensorDataManager()
    
    typealias UIViewType = LineChartView
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChartView = LineChartView()
        
        let sensorList = sensorDataManager.csvStringToSensor(csvString: recordString)
        if sensorList.count > 0 {
            let timestamp = sensorList.map { $0.timestamp }
            let accelerationX = sensorList.map { $0.rotationRateX }
            let accelerationY = sensorList.map { $0.rotationRateY }
            let accelerationZ = sensorList.map { $0.rotationRateZ }
            
            let chartDataSet1 = buildChartDataSet(xList: timestamp, yList: accelerationX, label: "gyro X", color: .orange)
            let chartDataSet2 = buildChartDataSet(xList: timestamp, yList: accelerationY, label: "gyro Y", color: .blue)
            let chartDataSet3 = buildChartDataSet(xList: timestamp, yList: accelerationZ, label: "gyro Z", color: .purple)
            let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2, chartDataSet3])
            lineChartView.data = chartData
            
            // 表示修正
            lineChartView.rightAxis.enabled = false
            lineChartView.xAxis.enabled = false
        }

        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {

    }
}

// 重力
struct GravityGraphView: UIViewRepresentable {

    var recordString: String
    let sensorDataManager = SensorDataManager()
    
    typealias UIViewType = LineChartView
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChartView = LineChartView()
        
        let sensorList = sensorDataManager.csvStringToSensor(csvString: recordString)
        if sensorList.count > 0 {
            let timestamp = sensorList.map { $0.timestamp }
            let accelerationX = sensorList.map { $0.gravityX }
            let accelerationY = sensorList.map { $0.gravityY }
            let accelerationZ = sensorList.map { $0.gravityZ }
            
            let chartDataSet1 = buildChartDataSet(xList: timestamp, yList: accelerationX, label: "gravity X", color: .orange)
            let chartDataSet2 = buildChartDataSet(xList: timestamp, yList: accelerationY, label: "gravity Y", color: .blue)
            let chartDataSet3 = buildChartDataSet(xList: timestamp, yList: accelerationZ, label: "gravity Z", color: .purple)
            let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2, chartDataSet3])
            lineChartView.data = chartData
            
            // 表示修正
            lineChartView.rightAxis.enabled = false
            lineChartView.xAxis.enabled = false
        }

        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {

    }
}

// 姿勢
struct AttitudeGraphView: UIViewRepresentable {

    var recordString: String
    let sensorDataManager = SensorDataManager()
    
    typealias UIViewType = LineChartView
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChartView = LineChartView()
        
        let sensorList = sensorDataManager.csvStringToSensor(csvString: recordString)
        if sensorList.count > 0 {
            let timestamp = sensorList.map { $0.timestamp }
            let accelerationX = sensorList.map { $0.attitudePitch }
            let accelerationY = sensorList.map { $0.attitudeRoll }
            let accelerationZ = sensorList.map { $0.attitudeYaw }
            
            let chartDataSet1 = buildChartDataSet(xList: timestamp, yList: accelerationX, label: "attitude Pitch", color: .orange)
            let chartDataSet2 = buildChartDataSet(xList: timestamp, yList: accelerationY, label: "attitude Roll", color: .blue)
            let chartDataSet3 = buildChartDataSet(xList: timestamp, yList: accelerationZ, label: "attitude Yaw", color: .purple)
            let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2, chartDataSet3])
            lineChartView.data = chartData
            
            // 表示修正
            lineChartView.rightAxis.enabled = false
            lineChartView.xAxis.enabled = false
        }

        return lineChartView
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {

    }
}



func buildChartDataSet(xList: [Double], yList:[Double], label: String, color: UIColor) -> LineChartDataSet {
    
    var chartEntryList: [ChartDataEntry] = []
    for i in (0 ..< (xList.count - 1)) {
        let chartEntry = ChartDataEntry(x: xList[i], y: yList[i])
        chartEntryList.append(chartEntry)
    }
    let lineSet = LineChartDataSet(entries: chartEntryList, label: label)
    lineSet.drawCirclesEnabled = false //各データを丸記号表示を非表示
    lineSet.lineWidth = 1.5 //線の太さの指定
    lineSet.colors = [color] // 色の指定
    
    return lineSet
}


struct SensorGraphView_Previews: PreviewProvider {
    static var previews: some View {
        SensorGraphView(recordString: "aa,aa,bb,cc,aa,bb,cc,aa,bb,cc,aa,bb,cc\n0,0.03395538845062256,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4\n1,1.01,2.2,3.4,1.01,2.2,3.4,1.01,2.2,3.4,1.01,2.2,3.4")
//        SensorGraphView(recordString: "0,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4\n1,1.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4")
    }
}
