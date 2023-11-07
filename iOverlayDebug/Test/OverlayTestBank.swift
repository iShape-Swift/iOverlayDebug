//
//  OverlayTestBank.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 07.11.2023.
//

import iShape
import iFixFloat
import Foundation

struct OverlayTest: Decodable {
    let subjPaths: [[FixVec]]
    let clipPaths: [[FixVec]]
    let clip: [FixShape]
    let subject: [FixShape]
    let difference: [FixShape]
    let intersect: [FixShape]
    let union: [FixShape]
    let xor: [FixShape]

    enum CodingKeys: String, CodingKey {
        case subjPaths
        case clipPaths
        case clip
        case subject
        case difference
        case intersect
        case union
        case xor
    }
}

struct OverlayTestBank {

    private var folderUrl: URL {
        guard let folderUrl = Bundle.main.resourceURL?.appending(path: "Tests", directoryHint: .isDirectory).appending(path: "Overlay", directoryHint: .isDirectory) else {
            fatalError("Folder not found.")
        }
        
        return folderUrl
    }
    
    
    func count() -> Int {
        let fileManager = FileManager.default
        do {
            let contents = try fileManager.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: [])
            
            // Filter the contents to get only 'json' files
            let jsonFiles = contents.filter { $0.pathExtension == "json" }
            
            // Count the 'json' files
            let jsonFilesCount = jsonFiles.count
            
            return jsonFilesCount
        } catch {
            fatalError("Could not retrieve contents of the folder: \(error)")
        }
    }
    
    func load(index: Int) -> OverlayTest {
        let folder = self.folderUrl

        let fileName = "test_\(index).json"
        
        let fileURL = folder.appending(component: fileName, directoryHint: .notDirectory)
        do {
            let data = try Data(contentsOf: fileURL)

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(OverlayTest.self, from: data)
            
            return decodedData
        } catch {
            fatalError("Error loading \(fileName): \(error)")
        }
    }
    
    func loadAll() -> [OverlayTest] {
        var result = [OverlayTest]()
        let count = self.count()
        result.reserveCapacity(count)
        for i in 0..<count {
            result.append(self.load(index: i))
        }
        
        return result
    }
    
}
