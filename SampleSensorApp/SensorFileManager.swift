//
//  SensorFileManager.swift
//  SampleSensorApp
//
//  Created by Tatsuya Mizuguchi on 2022/01/10.
//

import CoreMotion

class SensorFileManager: NSObject, ObservableObject {
    let documentDirectoryUrl = FileManager.default.urls( for: .documentDirectory, in: .userDomainMask ).first!
    let fileExtension = "csv"
    @Published var fileList: [String] = []

    
    func updateFileList() {
        do {
            let files = try FileManager.default.contentsOfDirectory(at: self.documentDirectoryUrl, includingPropertiesForKeys: nil)
            let csvFiles = files.filter{ $0.pathExtension == fileExtension }
            var csvFileNames = csvFiles.map{ $0.deletingPathExtension().lastPathComponent }
            csvFileNames.sort(by: >)
            fileList = csvFileNames
        } catch {
            print(error)
        }
    }
    
    func deleteFile(fileName: String) {
        do {
            let filePath = documentDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
            if FileManager.default.fileExists(atPath: filePath.path) {
                try FileManager.default.removeItem(atPath: filePath.path)
            }
        } catch {
            print(error)
        }
    }
    
    func saveFile(data: String, fileName: String) {
        let fileUrl = self.documentDirectoryUrl.appendingPathComponent(fileName)
        try! data.data(using: .utf8)!.write(to: fileUrl, options: .atomic)
    }
    
    func readFile(fileName: String) -> String {
        do {
            let filePath = documentDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
            if FileManager.default.fileExists(atPath: filePath.path) {
                let data = try String(contentsOf: filePath, encoding: .utf8)
                return data
            }
            return ""
        } catch {
            print(error)
            return ""
        }
    }
}
