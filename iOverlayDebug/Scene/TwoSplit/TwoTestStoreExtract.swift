//
//  TwoTestStoreExtract.swift
//  iOverlayDebug
//
//  Created by Nail Sharipov on 07.11.2023.
//

import Foundation
import iFixFloat
import iShape
import iOverlay

extension FixShape: Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(paths, forKey: .paths)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let paths = try container.decode([FixPath].self, forKey: .paths)
        self.init(paths: paths)
    }
    
    enum CodingKeys: String, CodingKey {
        case paths
    }
}

struct TwoTestData: Encodable {
    let subjPaths: [[Point]]
    let clipPaths: [[Point]]
    let clip: [Shape]
    let subject: [Shape]
    let difference: [Shape]
    let intersect: [Shape]
    let union: [Shape]
    let xor: [Shape]
}


extension TwoTestStore {
    
    func save() {
        let fileManager = FileManager.default
        let documentsDirectory = try! fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        
        var i = 0
        for test in self.data {
            let subjs = test.subjPaths.map({ $0.map({ $0.point }) })
            let clips = test.clipPaths.map({ $0.map({ $0.point }) })

            var overlay = Overlay()
            overlay.add(paths: subjs, type: .subject)
            overlay.add(paths: clips, type: .clip)
            
            let graph = overlay.buildGraph()
            let clip = graph.extractShapes(overlayRule: .clip)
            let subject = graph.extractShapes(overlayRule: .subject)
            let difference = graph.extractShapes(overlayRule: .difference)
            let intersect = graph.extractShapes(overlayRule: .intersect)
            let union = graph.extractShapes(overlayRule: .union)
            let xor = graph.extractShapes(overlayRule: .xor)
            
            let testData = TwoTestData(
                subjPaths: subjs,
                clipPaths: clips,
                clip: clip,
                subject: subject,
                difference: difference,
                intersect: intersect,
                union: union,
                xor: xor
            )

            // TODO save every test to readable json file with name test_\(i).json
            do {
                let encoder = JSONEncoder()
                // Format the JSON for readability, if desired
                encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
                let jsonData = try encoder.encode(testData)
                let fileName = "test_\(i).json"
                let url = documentsDirectory.appendingPathComponent(fileName)
                try jsonData.write(to: url)
                print("Saved test to \(url)")
            } catch {
                print("Failed to save test data: \(error)")
            }
            
            i += 1
        }
    }

}
