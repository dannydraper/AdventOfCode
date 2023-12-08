//
//  Day6.swift
//  AdventOfCode
//
//  Created by Danny Draper on 07/12/2023.
//

import Foundation

class Day6 {
    
    
    init() {
        
    }
    
    func getMaxDistance (of chargeTime: Int, of raceLength: Int) -> Int {
        
        let correctedLength = raceLength - chargeTime
        
        let maxDistance = chargeTime * correctedLength
        
        if (maxDistance > 0) {
            return maxDistance
        } else {
            return 0
        }
    }
    
    func getWinPossibilities (of raceLength: Int, currentWintime: Int) -> Int {
        
        var numPossibilities = 0
        
        for i in 1...raceLength {
            let maxDistance = getMaxDistance(of: i, of: raceLength)
            if (maxDistance > currentWintime) {
                //print ("Winning Charge Time: \(i)")
                numPossibilities+=1
            }
        }
        
        return numPossibilities
    }
    
    func Part1 () {
        print ("Day 6 Part 1")
        
        //let maxDist = getMaxDistance(of: 8, of: 7)
        
        let one = getWinPossibilities(of: 48989083, currentWintime: 390110311121360);
        
        //let two = getWinPossibilities(of: 98, currentWintime: 1103);
        //let three = getWinPossibilities(of: 90, currentWintime: 1112);
        //let four = getWinPossibilities(of: 83, currentWintime: 1360);
        
        print ("numPossibilities: \(one)")
        //print ("numPossibilities: \(two)")
        //print ("numPossibilities: \(three)")
        //print ("numPossibilities: \(four)")
        
        
        //let total = one * two * three * four
        //print ("Total: \(total)")
    }
    
}
