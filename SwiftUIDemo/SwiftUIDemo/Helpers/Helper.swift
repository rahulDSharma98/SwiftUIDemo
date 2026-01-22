//
//  Helper.swift
//  SwiftUIDemo
//
//  Created by MACM62 on 07/01/26.
//

import Foundation
import UIKit
import SwiftUI

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from fileName: String) -> T {
        guard let fileURL = self.url(forResource: fileName, withExtension: nil) else {
//            return nil
            fatalError("Failed to locate \(fileName) from bundle.")
        }
        
        guard let fileData = try? Data(contentsOf: fileURL) else {
//            return nil
            fatalError("Failed to load \(fileName) from bundle.")
        }
        
        let decoder: JSONDecoder = JSONDecoder()
        
        guard let decoded = try? decoder.decode(T.self, from: fileData) else {
            fatalError("Failed to decode \(fileName) from bundle.")
        }
        
        return decoded
    }
}
