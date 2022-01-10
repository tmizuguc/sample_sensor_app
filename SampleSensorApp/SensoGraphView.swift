//
//  SensoGraphView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct SensorGraphView: View {
    var recordString: String
        
    var body: some View {
        VStack {
            Text("\(recordString)")
            Text("Graphes")
        }
    }
}

struct SensorGraphView_Previews: PreviewProvider {
    static var previews: some View {
        SensorGraphView(recordString: "text")
    }
}

