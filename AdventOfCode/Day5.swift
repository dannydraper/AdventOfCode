//
//  Day5.swift
//  AdventOfCode
//
//  Created by Danny Draper on 06/12/2023.
//

import Foundation

class Day5 {
    
    var seeds = [Int]()
    var SeedSoilMappings = [Mapping]()
    var AllMappings = [Mapping]()
    var AllSeedRanges = [SeedRange]()
    
    enum MappingType {
        case SeedSoil
        case SoilFertilizer
        case FertilizerWater
        case WaterLight
        case LightTemperature
        case TemperatureHumidity
        case HumidityLocation
        case None
    }
    
    struct Mapping {
        var destRangeStart: Int
        var sourceRangeStart: Int
        var rangeLength: Int
        var type: MappingType
    }
    
    struct SeedRange {
        var start: Int
        var length: Int
    }
    
    init() {
        
    }
    
    func myMethod() {
        print ("Executing my method")
        Utils.myUtilMethod()
    }
    
    func findMappings () {
        
        var lowestLocation = Int.max
        
        for seed in seeds {
            let soilMapping = getMapping(of: seed, of: MappingType.SeedSoil)
            print ("Seed: \(seed) SoilMapping: \(soilMapping)")
            
            let fertilizerMapping = getMapping(of: soilMapping, of: MappingType.SoilFertilizer)
            print ("Fertilizer Mapping: \(fertilizerMapping)")
            
            let waterMapping = getMapping(of: fertilizerMapping, of: MappingType.FertilizerWater)
            print ("Water Mapping: \(waterMapping)")
            
            let lightMapping = getMapping(of: waterMapping, of: MappingType.WaterLight)
            print ("Light Mapping: \(lightMapping)")
            
            let tempMapping = getMapping(of: lightMapping, of: MappingType.LightTemperature)
            print ("Temp Mapping: \(tempMapping)")
            
            let humidMapping = getMapping(of: tempMapping, of: MappingType.TemperatureHumidity)
            print ("Humid Mapping: \(humidMapping)")
            
            let locationMapping = getMapping(of: humidMapping, of: MappingType.HumidityLocation)
            print ("Location Mapping: \(locationMapping)")
            
            if (locationMapping < lowestLocation) {
                lowestLocation = locationMapping
            }
        }
        
        print ("Lowest Location: \(lowestLocation)")
    }
    
    func findMappingsUsingRanges () {
        
        // This is going to take a WHILE!!!!
        var lowestLocation = Int.max
        
        for seedRange in AllSeedRanges {
            print ("Processing Range: \(seedRange)")
            var seedStart = seedRange.start
            
            for _ in 0..<seedRange.length {
                var seed = seedStart
                
                let soilMapping = getMapping(of: seed, of: MappingType.SeedSoil)
                //print ("Seed: \(seed) SoilMapping: \(soilMapping)")
                
                let fertilizerMapping = getMapping(of: soilMapping, of: MappingType.SoilFertilizer)
                //print ("Fertilizer Mapping: \(fertilizerMapping)")
                
                let waterMapping = getMapping(of: fertilizerMapping, of: MappingType.FertilizerWater)
                //print ("Water Mapping: \(waterMapping)")
                
                let lightMapping = getMapping(of: waterMapping, of: MappingType.WaterLight)
                //print ("Light Mapping: \(lightMapping)")
                
                let tempMapping = getMapping(of: lightMapping, of: MappingType.LightTemperature)
                //print ("Temp Mapping: \(tempMapping)")
                
                let humidMapping = getMapping(of: tempMapping, of: MappingType.TemperatureHumidity)
                //print ("Humid Mapping: \(humidMapping)")
                
                let locationMapping = getMapping(of: humidMapping, of: MappingType.HumidityLocation)
                //print ("Location Mapping: \(locationMapping)")
                
                if (locationMapping < lowestLocation) {
                    lowestLocation = locationMapping
                }
                
                seedStart+=1
            }
                    
        }
        
        print ("Lowest Location: \(lowestLocation)")
    }
    
    func getMapping (of sourceNumber: Int, of type: MappingType) -> Int {
        
        var foundMappings = 0
        var mappingResult = 0
        
        for singleMapping in AllMappings {
            if (singleMapping.type == type) {
                // Does the source Number fall within the current Mapping source range
                let maxSource = Int(singleMapping.sourceRangeStart + singleMapping.rangeLength)
                
                if (sourceNumber >= singleMapping.sourceRangeStart && sourceNumber <= maxSource) {
                    
                    //print ("Source: \(sourceNumber) Greater than \(singleMapping.sourceRangeStart) and less then \(maxSource)")
                    // Get the distance away from the source
                    let sourceDistance = sourceNumber - singleMapping.sourceRangeStart // Assuming source number is greater than source range start
                    let destMapping = singleMapping.destRangeStart + sourceDistance
                    
                    if (foundMappings == 0) {
                        mappingResult = destMapping
                    }
                    
                    foundMappings += 1
                } else {
                    // Source number doesn't match this mapping
                }
            }
        }
        
        if (foundMappings == 0) {
            mappingResult = sourceNumber
        }
        
        //print ("Num Mappings Found: \(foundMappings)")
        
        return mappingResult
    }
    
    func Part1 (of inputString: String) {
        
        var currentMap: MappingType = MappingType.None
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
            
            // Parse current mapping line
            if (currentMap != MappingType.None) {
                if (line.count > 0) {
                    let mappingComponents = line.split(separator: " ")
                    if (mappingComponents.count == 3) {
                        let destRangeStart = Int(mappingComponents[0])!
                        let sourceRangeStart = Int(mappingComponents[1])!
                        let rangeLength = Int(mappingComponents[2])!
                        
                        let newMapping = Mapping(destRangeStart: destRangeStart, sourceRangeStart: sourceRangeStart, rangeLength: rangeLength, type: currentMap)
                        AllMappings.append(newMapping)
                        
                        print ("New Mapping: \(newMapping)")
                    }
                }
            }
            
            
            // Parse seed soil mappings
            if (line.contains ("seed-to-soil map:")) {currentMap = MappingType.SeedSoil}
            if (line.contains ("soil-to-fertilizer map:")) {currentMap = MappingType.SoilFertilizer}
            if (line.contains ("fertilizer-to-water map:")) {currentMap = MappingType.FertilizerWater}
            if (line.contains ("water-to-light map:")) {currentMap = MappingType.WaterLight}
            if (line.contains ("light-to-temperature map:")) {currentMap = MappingType.LightTemperature}
            if (line.contains ("temperature-to-humidity map:")) {currentMap = MappingType.TemperatureHumidity}
            if (line.contains ("humidity-to-location map:")) {currentMap = MappingType.HumidityLocation}
                                
        }
        
        
        // Find mappings
        findMappings()
    }
    
    func Part2 (of inputString: String) {
        var currentMap: MappingType = MappingType.None
        let lines = inputString.components(separatedBy: .newlines)
        
        print ("Linecount: \(lines.count)")
        
        for line in lines {
            
            // Parse seeds
            if (line.contains("seeds:")) {
                let seedComponents = line.split(separator: ":")
                let seedNumbers = String(seedComponents[1])
                
                let individualSeeds = seedNumbers.split(separator: " ")
                
                var treatAsRange = false
                
                var seedStart = 0;
                var seedLength = 0;
                
                for seedNum in individualSeeds {
                                        
                    let intSeed = Int(seedNum)!
                    
                    if (treatAsRange == false) {
                        seedStart = intSeed
                        treatAsRange = true
                    } else {
                        treatAsRange = false
                        seedLength = intSeed
                        AllSeedRanges.append (SeedRange(start: seedStart, length: seedLength))
                    }
                                        
                    //seeds.append(intSeed)
                }
                
                print ("Seed Ranges: \(AllSeedRanges)")
            }
            
            // Parse current mapping line
            if (currentMap != MappingType.None) {
                if (line.count > 0) {
                    let mappingComponents = line.split(separator: " ")
                    if (mappingComponents.count == 3) {
                        let destRangeStart = Int(mappingComponents[0])!
                        let sourceRangeStart = Int(mappingComponents[1])!
                        let rangeLength = Int(mappingComponents[2])!
                        
                        let newMapping = Mapping(destRangeStart: destRangeStart, sourceRangeStart: sourceRangeStart, rangeLength: rangeLength, type: currentMap)
                        AllMappings.append(newMapping)
                        
                        print ("New Mapping: \(newMapping)")
                    }
                }
            }
            
            
            // Parse seed soil mappings
            if (line.contains ("seed-to-soil map:")) {currentMap = MappingType.SeedSoil}
            if (line.contains ("soil-to-fertilizer map:")) {currentMap = MappingType.SoilFertilizer}
            if (line.contains ("fertilizer-to-water map:")) {currentMap = MappingType.FertilizerWater}
            if (line.contains ("water-to-light map:")) {currentMap = MappingType.WaterLight}
            if (line.contains ("light-to-temperature map:")) {currentMap = MappingType.LightTemperature}
            if (line.contains ("temperature-to-humidity map:")) {currentMap = MappingType.TemperatureHumidity}
            if (line.contains ("humidity-to-location map:")) {currentMap = MappingType.HumidityLocation}
                                
        }
        
        
        // Find mappings
        findMappingsUsingRanges()
    }
}

