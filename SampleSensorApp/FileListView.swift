//
//  FileListView.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import SwiftUI

struct FileListView: View {
    var file_prefix: String
    @ObservedObject var fileManager = SensorFileManager()
    
    init(file_prefix: String) {
        self.file_prefix = file_prefix
        self.fileManager.updateFileList(file_prefix: self.file_prefix)
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
                            self.fileManager.updateFileList(file_prefix: self.file_prefix)
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
        FileListView(file_prefix: "walk")
    }
}

