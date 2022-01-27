//
//  ContentView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct Workout: Identifiable {
    var id: Int
    let name: String
    let name_en: String
    let image: Image
}

struct ContentView: View {
    @ObservedObject var fileManager = SensorFileManager()
    var view = FileListView(file_prefix: "")

    let workouts: [Workout] = [
        .init(id: 0, name: "歩行", name_en: "walk", image: Image(systemName: "figure.walk")),
        .init(id: 1, name: "静止", name_en: "stand", image: Image(systemName: "figure.stand")),
    ]

    // BODY
    var body: some View {
        NavigationView {
            List {
                // ワークアウト一覧
                ForEach(workouts) { workout in
                    NavigationLink {
                        WorkoutSettingView(workout_name: workout.name_en)
                    } label: {
                        HStack {
                            workout.image
                            Text(workout.name)
                        }
                    }
                }

                // 記録
                NavigationLink {
                    view
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("記録")
                    }
                }.simultaneousGesture(TapGesture().onEnded {
                    view.fileManager.updateFileList(file_prefix: "")
                })
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
