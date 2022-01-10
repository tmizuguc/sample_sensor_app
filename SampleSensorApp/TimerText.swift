//
//  TimerText.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct TimerText: View {
    var text: String
    
    var body: some View {
        Text("\(text)")
            .font(.title)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
                Capsule()
                    .fill(Color.black)
                    .opacity(0.75)
            )
    }
}
