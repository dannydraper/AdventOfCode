//
//  Day1.swift
//  AdventOfCode
//
//  Created by Danny Draper on 06/12/2023.
//

import Foundation

class Day1 {
    var propertyOne: Int
    
    init(propertyOne: Int) {
        self.propertyOne = propertyOne
    }
    
    
func translateNumberword (wordNumber inputString: String) -> String {
    var resultString = inputString.lowercased() // Convert to lowercase for case-insensitive comparison
    
    let numberWordsMapping: [String: String] = [
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
        // Add more mappings as needed
    ]
    
    for (word, digit) in numberWordsMapping {
        if (resultString == word) {
            return digit
        }
    }
    
    return inputString
}

func replaceNumberWords(withDigits inputString: String) -> String {
    var resultString = inputString.lowercased() // Convert to lowercase for case-insensitive comparison

    let numberWordsMapping: [String: String] = [
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
        // Add more mappings as needed
    ]

    for (word, digit) in numberWordsMapping {
        resultString = resultString.replacingOccurrences(of: word, with: digit)
    }

    return resultString
}

func indexOfLastOccurrence(of word: String, in inputString: String) -> Int? {
    let options: NSString.CompareOptions = [.caseInsensitive, .backwards]
    let range = inputString.range(of: word, options: options)

    if let range = range {
        return inputString.distance(from: inputString.startIndex, to: range.lowerBound)
    } else {
        return -1
    }
}

func indexOfFirstOccurrence(of substring: String, in inputString: String) -> Int? {
    if let range = inputString.range(of: substring) {
        return inputString.distance(from: inputString.startIndex, to: range.lowerBound)
    } else {
        return 20000
    }
}

    
    func findLastNumber (in inputString: String) -> String? {
        var highestIndex = -1
        var highestString = ""
        
        let numberList: [String] = [
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
        ]
        
        for numberWord in numberList {
            let c = indexOfLastOccurrence(of: numberWord, in: inputString)
            
            if (c! > highestIndex) {
                highestIndex = c!
                highestString = numberWord
            }
        }
        
        var highestNumber = translateNumberword(wordNumber: highestString)
        return highestNumber
    }
    
    func findFirstNumber (in inputString: String) -> String? {

        var lowestIndex = 20000
        var lowestString = ""
        
        let numberList: [String] = [
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
        ]
        
        for numberWord in numberList {
            let c = indexOfFirstOccurrence(of: numberWord, in: inputString)
            //if (c != nil) {
                if (c! < lowestIndex) {
                    lowestIndex = c!
                    lowestString = numberWord
                }
            //}
        }
        
        var lowestNumber = translateNumberword(wordNumber: lowestString)
        return lowestNumber
    }
    
    func processLine (of inputLine: String) -> Int {
        
        
        
        print ("Input Line: \(inputLine)")
        
        //let digitisedInputLine = replaceNumberWords(withDigits: inputLine)
        //let digitisedInputLine = inputLine
        
        //print ("Digitised Line: \(digitisedInputLine)")
        
        var calibrationString = ""
        
        // Get first digit
        calibrationString+=findFirstNumber(in: inputLine)!
        
        // Get last digit
        calibrationString+=findLastNumber(in: inputLine)!
        /*
        // Get first digit
        for char in digitisedInputLine {
            if (char.isNumber) {
                //print(char)
                calibrationString+=String(char)
                break;
            }
        }
        
        // Get last digit
        for char in digitisedInputLine.reversed() {
            if (char.isNumber) {
                //print(char)
                calibrationString+=String(char)
                break;
            }
        }
         */
        
        print ("Calibration String:  \(calibrationString)")
        
        if (!calibrationString.isEmpty) {
            return Int(calibrationString)!
        } else {
            return 0
        }
        
    }
    
    func Part2(of inputString: String) {
        let lines = inputString.components(separatedBy: .newlines)
        var lineCount = 0
        var calibrationTotal = 0;
        var concatCalibrationString = ""
        
        for line in lines {
            //print(line)
            let calbrationValue = processLine(of: line)
            calibrationTotal += calbrationValue
            lineCount+=1
            
            print ("CalibrationValue: \(calbrationValue)")
            concatCalibrationString += String(calbrationValue)
            //if (lineCount > 0) {
            //    break;
            //}
        }
        
        print ("Line count: \(lineCount)")
        print ("Calibration Total: \(calibrationTotal)")
        //print (concatCalibrationString)
    }
}
