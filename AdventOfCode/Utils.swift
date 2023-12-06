//
//  Utils.swift
//  AdventOfCode
//
//  Created by Danny Draper on 06/12/2023.
//

import Foundation

struct Utils {
    static var property1: Int = 0
    static var property2: String = "Default"

    static func myUtilMethod () {
        print("Executing myStaticMethod")
    }
    
    static func extractWholeNumber(from string: String, atIndex index: String.Index) -> Int? {
        var startIndex = index
        var endIndex = index

        // Move left to find the start of the number
        while startIndex > string.startIndex {
            let previousIndex = string.index(before: startIndex)
            let previousCharacter = string[previousIndex]
            if !CharacterSet.decimalDigits.contains(Unicode.Scalar(String(previousCharacter))!) {
                break
            }
            startIndex = previousIndex
        }

        // Move right to find the end of the number
        while endIndex < string.index(before: string.endIndex) {
            let nextIndex = string.index(after: endIndex)
            let nextCharacter = string[nextIndex]
            if !CharacterSet.decimalDigits.contains(Unicode.Scalar(String(nextCharacter))!) {
                break
            }
            endIndex = nextIndex
        }

        // Extract the substring and convert to Int
        let numberSubstring = string[startIndex...endIndex]
        return Int(numberSubstring)
    }
    
    static func readFile(atPath filePath: String) -> String? {
        do {
            // Get the file URL
            let fileURL = URL(fileURLWithPath: filePath)

            // Read the contents of the file into a Data object
            let fileData = try Data(contentsOf: fileURL)

            // Convert the Data object to a String
            if let fileContents = String(data: fileData, encoding: .utf8) {
                return fileContents
            } else {
                print("Unable to convert data to string.")
                return nil
            }
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}
