//
//  Day5.swift
//  AdventOfCode
//
//  Created by Danny Draper on 06/12/2023.
//

import Foundation

class Day5 {
    
    var seeds = [Int]()
    
    init() {
        
    }
    
    func myMethod() {
        print ("Executing my method")
        Utils.myUtilMethod()
    }
    
    func Part1 (of inputString: String) {
        
        let lines = inputString.components(separatedBy: .newlines)
        
        print ("Linecount: \(lines.count)")
        
        for line in lines {
            
            // Parse seeds
            if (line.contains("seeds:")) {
                let seedComponents = line.split(separator: ":")
                let seedNumbers = String(seedComponents[1])
                
                let individualSeeds = seedNumbers.split(separator: " ")
                                
                for seedNum in individualSeeds {
                    let intSeed = Int(seedNum)!
                    seeds.append(intSeed)
                }
                print ("Seed Numbers loaded")
            }
            
            //
        }
    }
}

