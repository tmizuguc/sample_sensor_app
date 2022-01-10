//
//  ContentView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct ContentView: View {
    // PROPERTIES
    @State var txt = ""
    @State var on = false
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 32)!]
    }
    
    // BODY
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    WorkoutSettingView()
                } label: {
                    Text("歩行")
                }
            }
            .navigationBarTitle(Text("ワークアウトを選択"))
        }
    }
}

// PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
