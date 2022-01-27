//
//  ActivityGraphView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/27.
//

import Charts
import SwiftUI

struct ActivityGraphView: View {
    var recordString: String

    var body: some View {
        TabView {
            ActivityGraphView(recordString: recordString)
                .tabItem {
                    Image(systemName: "pencil.circle.fill")
                    Text("加速度")
                }
        }
    }
}

// 加速度
struct ActivityGraphView: UIViewRepresentable {
    var recordString: String
    let sensorDataManager = SensorDataManager()

    typealias UIViewType = LineChartView

    func makeUIView(context _: Context) -> LineChartView {
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

    func updateUIView(_: LineChartView, context _: Context) {}
}

func buildChartDataSet(xList: [Double], yList: [Double], label: String, color: UIColor) -> LineChartDataSet {
    var chartEntryList: [ChartDataEntry] = []
    for i in 0 ..< (xList.count - 1) {
        let chartEntry = ChartDataEntry(x: xList[i], y: yList[i])
        chartEntryList.append(chartEntry)
    }
    let lineSet = LineChartDataSet(entries: chartEntryList, label: label)
    lineSet.drawCirclesEnabled = false // 各データを丸記号表示を非表示
    lineSet.lineWidth = 1.5 // 線の太さの指定
    lineSet.colors = [color] // 色の指定

    return lineSet
}

struct SensorGraphView_Previews: PreviewProvider {
    static var previews: some View {
        SensorGraphView(recordString: "aa,aa,bb,cc,aa,bb,cc,aa,bb,cc,aa,bb,cc\n0,0.03395538845062256,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4,0.01,1.2,0.4\n1,1.01,2.2,3.4,1.01,2.2,3.4,1.01,2.2,3.4,1.01,2.2,3.4")
    }
}
