//
//  FileListView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct FileListView: View {
    @ObservedObject var fileManager = SensorFileManager()
    
    init() {
        self.fileManager.updateFileList()
    }
    
    var body: some View {
        List {
            ForEach(self.fileManager.fileList, id: \.self) { fileName in
                NavigationLink {
                    let recordString = self.fileManager.readFile(fileName: fileName)
                    SensorGraphView(recordString: recordString)
                } label: {
                    HStack {
                        Button(action: {
                            self.fileManager.deleteFile(fileName: fileName)
                            self.fileManager.updateFileList()
                        }) {
                            Text("削除")
                        }.buttonStyle(BorderlessButtonStyle())
                        
                        Text("\(fileName)")
                    }
                }
            }
        }
    }
}

struct FileList_Previews: PreviewProvider {
    static var previews: some View {
        FileListView()
    }
}

