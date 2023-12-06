//
//  Day3.swift
//  AdventOfCode
//
//  Created by Danny Draper on 06/12/2023.
//

import Foundation

class Day3 {
    var propertyOne: Int
    var fileLines = [String]()
    var wantedNumbers = [Int]()
    
    init(propertyOne: Int) {
        self.propertyOne = propertyOne
    }
    


    func containsSymbolButNotNumber(_ input: String) -> Bool {
        
        let symbolRegex = #"[*%$+=&/\-#@]"#

        if let _ = input.range(of: symbolRegex, options: .regularExpression) {
            // String contains a specified symbol but not a number
            return true
        } else {
            // String does not contain the specified symbols
            return false
        }
    }

    func getSubstring (of arrayLine: String, of origStart: Int, of origEnd: Int) -> String {
        
        if (arrayLine.count < 10) {
            return "";
        }
        
        var movedOrigStart = 0;
        if (origStart > 0) {
            movedOrigStart = origStart - 1
        }
        
        var movedOrigEnd = arrayLine.count
        if (origEnd < arrayLine.count) {
            movedOrigEnd = origEnd + 1
        }
        
        let startIndexMoved = arrayLine.index(arrayLine.startIndex, offsetBy: movedOrigStart)
        let endIndexMoved = arrayLine.index(arrayLine.startIndex, offsetBy: movedOrigEnd)
        
        let wantedSubString = arrayLine[startIndexMoved..<endIndexMoved]
        
        return String(wantedSubString)
    }
    
    func processGears (of charPos: Int, of linePos: Int) -> Int {
        
        var wantedMultiples = [Int]()
        
        var arrayLine = fileLines[linePos];
        
        var arrayLineAbove = ""
        if (linePos > 0) {
            arrayLineAbove = fileLines[linePos-1];
        }

        var arrayLineMiddle = fileLines[linePos];
        var arrayLineBelow = ""
        
        if (linePos < fileLines.count) {
            arrayLineBelow = fileLines[linePos+1];
        }
        
        let aboveNumberString = getSubstring(of: arrayLineAbove, of: charPos, of: charPos+1)
        let middleNumberString = getSubstring(of: arrayLineMiddle, of: charPos, of: charPos+1)
        let belowNumberString = getSubstring(of: arrayLineBelow, of: charPos, of: charPos+1)
        
        var aboveCharIndex = 0
        //print ("AboveString: \(aboveNumberString)")
        var aboveSameNumber = false
        for aboveChar in aboveNumberString {
            if (aboveChar.isNumber) {
                if (aboveSameNumber == false) {
                    aboveSameNumber = true
                    if let result = Utils.extractWholeNumber(from: arrayLineAbove, atIndex: String.Index (encodedOffset: (charPos-1)+aboveCharIndex)) {
                        //print ("Gear Number Above: \(result)")
                        wantedMultiples.append(result)
                    } else {
                        print("NG")
                    }
                }
                //break
            } else {
                aboveSameNumber = false
            }
            aboveCharIndex += 1
        }
        
        if (charPos > 0) {
            //print ("MiddleString: \(middleNumberString)")
            var middleCharIndex = 0
            for middleChar in middleNumberString {
                if (middleChar.isNumber) {
                    if let result = Utils.extractWholeNumber(from: arrayLineMiddle, atIndex: String.Index (encodedOffset: (charPos-1)+middleCharIndex)) {
                        //print ("Gear Number Middle: \(result)")
                        wantedMultiples.append(result)
                    } else {
                        print("NG")
                    }
                    
                }
                middleCharIndex+=1
            }
        }
        
        var belowNumberIndex = 0
        var sameBelowNumber = false
        for belowChar in belowNumberString {
            if (belowChar.isNumber) {
                if (sameBelowNumber == false) {
                    sameBelowNumber = true
                    if let result = Utils.extractWholeNumber(from: arrayLineBelow, atIndex: String.Index (encodedOffset: (charPos-1)+belowNumberIndex)) {
                        //print ("Gear Number Below: \(result)")
                        wantedMultiples.append(result)
                    } else {
                        print("NG")
                    }
                }
                
                //break;
            } else {
                sameBelowNumber = false
            }
            belowNumberIndex+=1
        }
        
        

        //print ("Multiple Count: \(wantedMultiples.count)")
        
        if (wantedMultiples.count == 2) {
            let result = wantedMultiples[0] * wantedMultiples[1]
            //print ("Gear Ratio: \(result)")
            return result;
        }
        return 0;
    }
    
    func processPartNumber (of charPos: Int, of linePos: Int) -> Bool {
        
        
        //print ("CharPos: \(charPos) LinePos: \(linePos)")
        var arrayLine = fileLines[linePos];
        //print ("ArrayProc: \(arrayLine)")
        
        var endIndexPos = charPos;
            
        var endIndexSet = false
        // Find the end index where numbers stop
        for i in charPos..<(charPos+3) {
            let firstIndex = arrayLine.index(arrayLine.startIndex, offsetBy: i)
            let firstCharacter = arrayLine[firstIndex]
            
            if (arrayLine[firstIndex].isNumber == false) {
                
                endIndexPos = i
                endIndexSet = true
                
                //print ("Char: \(firstCharacter) Not a Number: endIndexPos: \(endIndexPos)")
                break;
            }
            //print ("Index: \(i) firstCharacter: \(firstCharacter)")
        }
        
        if (endIndexSet == false) {
            endIndexPos = charPos+3
        }
        
        
        let startIndex = arrayLine.index(arrayLine.startIndex, offsetBy: charPos)
        let endIndex = arrayLine.index(arrayLine.startIndex, offsetBy: endIndexPos)
        
        let numberString = arrayLine[startIndex..<endIndex]
        
        
        //print ("Number: \(numberString) Start: \(charPos) End: \(endIndexPos)")

        var arrayLineAbove = ""
        if (linePos > 0) {
            arrayLineAbove = fileLines[linePos-1];
        }

        var arrayLineMiddle = fileLines[linePos];
        var arrayLineBelow = ""
        
        if (linePos < fileLines.count) {
            arrayLineBelow = fileLines[linePos+1];
        }
        
        let aboveNumberString = getSubstring(of: arrayLineAbove, of: charPos, of: endIndexPos)
        let middleNumberString = getSubstring(of: arrayLineMiddle, of: charPos, of: endIndexPos)
        let belowNumberString = getSubstring(of: arrayLineBelow, of: charPos, of: endIndexPos)
        
        //print ("AbvNum: \(aboveNumberString) MidNum: \(middleNumberString) blwNum: \(belowNumberString)")
        
        let aboveContainsSymbol = containsSymbolButNotNumber (aboveNumberString)
        let middleContainsSymbol = containsSymbolButNotNumber (middleNumberString)
        let belowContainsSymbol = containsSymbolButNotNumber(belowNumberString)
        
        //print ("AbvSym: \(aboveContainsSymbol) MidSym: \(middleContainsSymbol) blwSym: \(belowContainsSymbol)")
        
        if (aboveContainsSymbol || middleContainsSymbol || belowContainsSymbol) {
            wantedNumbers.append(Int(numberString)!)
            return true
        }
        
        return false
        
        // Now get the box around the number
        
    }
    
    func Part1 (of inputString: String) {
        let lines = inputString.components(separatedBy: .newlines)
        var lineCount = 0
        
        struct numberLocations {
            var lineNumber: Int
            var lineIndex: Int
            var size: Int
        }
        
        for line in lines {
            //print ("Day3Line: \(line)")
            fileLines.append(line);
            //print ("Line Length: \(line.count)")
            lineCount+=1
        }
        
        print ("Line count: \(lineCount)")
        print ("Array count: \(fileLines.count)")
        
        var arrayLinePos = 0
        
        var uniqueSet = Set<String>()
        
        for arrayLine in fileLines {
            
            //print ("ArrayLine: \(arrayLine)")
            
            var dLine = "";
            var cLine = "";
            // Loop through chars
            var lineCNCount = 1
            var arrayCharPos = 0
            var InANumber = false
            
            for lineChar in arrayLine {
                
                if (lineChar != "." && lineChar.isNumber == false) {
                    print (lineChar)
                    uniqueSet.insert (String(lineChar))
                }
                
                if lineChar.isNumber {
                    if (InANumber == false) {
                        InANumber = true
                        
                        if (processPartNumber(of: arrayCharPos, of: arrayLinePos) == true) {
                            dLine += "Y"
                        } else {
                            dLine += "N"
                        }
                        
                    } else {
                        dLine += "."
                    }
                    
                    cLine += String(lineCNCount)
                    lineCNCount+=1
                } else {
                    InANumber = false
                    //cLine += String (lineCNCount)
                    
                    dLine.append(lineChar)
                    cLine.append(lineChar)
                    
                    lineCNCount=1
                    
                }
                
                arrayCharPos+=1
            }
            //print ("ArrayLine: \(dLine)")
            //print ("ArrayLine: \(cLine)")
            arrayLinePos+=1
        }
        
        // Convert the set back to an array if needed
        let uniqueArray = Array(uniqueSet)

        print(uniqueArray)
        
        var total = 0
        
        for wantedNumber in wantedNumbers {
            total += wantedNumber
            print ("Wanted Number: \(wantedNumber)")
        }
        print ("Part Number Total: \(total)")
    }
    
    func Part2 (of inputString: String) {
        let lines = inputString.components(separatedBy: .newlines)
        var lineCount = 0
        
        for line in lines {
            //print ("Day3Line: \(line)")
            fileLines.append(line);
            //print ("Line Length: \(line.count)")
            lineCount+=1
        }
        
        print ("Line count: \(lineCount)")
        print ("Array count: \(fileLines.count)")
        
        var arrayLinePos = 0
        
        for arrayLine in fileLines {
            
            // Loop through chars
            
            var arrayCharPos = 0
            for lineChar in arrayLine {
                
                if lineChar == "*" {
                    print ("Star Found at Line: \(arrayLinePos) Position: \(arrayCharPos)")
                    let result = processGears(of: arrayCharPos, of: arrayLinePos)
                    
                    if (result > 0) {
                        wantedNumbers.append(result)
                    }
                }
                            
                arrayCharPos+=1
            }
            //print ("ArrayLine: \(dLine)")
            //print ("ArrayLine: \(cLine)")
            arrayLinePos+=1
        }
            
        var total = 0
        
        for wantedNumber in wantedNumbers {
            total += wantedNumber
            print ("Wanted Number: \(wantedNumber)")
        }
        print ("Part Number Total: \(total)")
    }
}
