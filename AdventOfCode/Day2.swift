//
//  Day2.swift
//  AdventOfCode
//
//  Created by Danny Draper on 06/12/2023.
//

import Foundation

class Day2 {
    var propertyOne: Int
    
    init(propertyOne: Int) {
        self.propertyOne = propertyOne
    }
    
    
    func Part2 (of inputString: String) {
        let lines = inputString.components(separatedBy: .newlines)
        var lineCount = 0
        let maxRed = 12
        let maxGreen = 13
        let maxBlue = 14
        var gameIdSum = 0
        
        for line in lines {
            
            //print(line)
                    
            let gameArray = line.split(separator: ":")
                    
            //let caseInsensitiveReplacedString = originalString.replacingOccurrences(of: "hello", with: "Hi", options: .caseInsensitive)
            if (gameArray.count > 0) {
                let gameId = gameArray[0].replacingOccurrences(of: "Game", with: "", options: .caseInsensitive)
                let gameIdInt = (gameId as NSString) .integerValue
                
                let cubePicks = gameArray[1];
                let cubePicksArray = cubePicks.split(separator: ";")
                
                var minRed = 0;
                var minGreen = 0;
                var minBlue = 0;
                
                var cubePickAllowed = true
                
                for cubePick in cubePicksArray {
                    //print ("ID: \(gameIdInt) - CubePick: \(cubePick)")
                    let singleCubes = cubePick.split(separator: ",");
                    
                    for singleCube in singleCubes {
                        //print ("ID: \(gameIdInt) - SingleCube: \(singleCube)")
                        
                        let cubeDetails = singleCube.split(separator: " ")
                        let cubeCount = cubeDetails[0]
                        let cubeCountInt = (cubeCount as NSString) .integerValue
                        
                        let cubeColour = cubeDetails[1]
                        
                        if (cubeColour == "red") {
                            //print ("ID: \(gameIdInt) Count: \(cubeCountInt) Colour: \(cubeColour)")
                            
                            if (cubeCountInt > maxRed) {
                                cubePickAllowed = false
                            }
                            
                            if (cubeCountInt >= minRed) {
                                minRed = cubeCountInt
                            }
                        }
                        
                        if (cubeColour == "green") {
                            //print ("ID: \(gameIdInt) Count: \(cubeCountInt) Colour: \(cubeColour)")
                            
                            if (cubeCountInt > maxGreen) {
                                cubePickAllowed = false
                            }
                            
                            if (cubeCountInt >= minGreen) {
                                minGreen = cubeCountInt
                            }
                        }
                        
                        if (cubeColour == "blue") {
                            //print ("ID: \(gameIdInt) Count: \(cubeCountInt) Colour: \(cubeColour)")
                            
                            if (cubeCountInt > maxBlue) {
                                cubePickAllowed = false
                            }
                            
                            if (cubeCountInt >= minBlue) {
                                minBlue = cubeCountInt
                            }
                        }
                        
                        
                    }
                            
                }
                
                let gamePower = (minRed * minGreen) * minBlue
                
                //print ("Game ID: \(gameIdInt) - Game Power: \(gamePower)")
                print (line);
                print ("MinRed: \(minRed) MinGreen: \(minGreen) MinBlue: \(minBlue)")
                
                //if (cubePickAllowed == true) {
                //    print (line)
                    
                    gameIdSum+=gamePower
                //}
                // Cube picks
                
                
                //print ("IDInt: \(gameIdInt)")
            
            }
            
            lineCount+=1
        }
        
        print ("Line count: \(lineCount)")
        print ("Game ID Sum: \(gameIdSum)")
    }
}
