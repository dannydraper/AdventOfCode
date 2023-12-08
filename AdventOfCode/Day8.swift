//
//  Day8.swift
//  AdventOfCode
//
//  Created by Danny Draper on 08/12/2023.
//

import Foundation

class Day8 {
    
    var Instructions = String()
    
    // Initialize array to store NodeInstructions
    var nodeInstructions = [NodeInstruction]()
    var indexedNodeInstructions = [IndexedNodeInstruction]()
    var matchingZNodes = [IndexedNodeInstruction]()
    var nodeListIndex = [String]()
    
    
    struct NodeInstruction {
        var Node : String
        var Left : String
        var Right: String
    }
    
    struct IndexedNodeInstruction {
        var Node: Int
        var Left: Int
        var Right: Int
    }
    
    init() {
        
    }
    
    func findNodeIndex (of nodeName: String) -> Int {
        var index = 0
        for s in nodeListIndex {
            if (s == nodeName) {
                return index;
            }
            index += 1
        }
        
        return -1
    }
    
    func findNode (of nodeName: String) -> NodeInstruction {
        for s in nodeInstructions {
            if (s.Node == nodeName) {
                return s
            }
        }
    
        return NodeInstruction (Node: "NOTFOUND", Left: "", Right: "")
    }
    
    func findMatchingNodes (of matching: Character) -> [NodeInstruction] {
        
        var matchingNodes = [NodeInstruction]()
        var nodeCount = 0
        for s in nodeInstructions {
            if (s.Node.last == matching) {
                print ("Matching Node: \(s.Node)")
                matchingNodes.append(s)
                nodeCount+=1
            }
        }

        print ("NodeCount: \(nodeCount)")
        return matchingNodes
    }
    
    func findMatchingNodeIndexes (of matching: Character) -> [IndexedNodeInstruction] {
        
        var matchingNodeIndexes = [IndexedNodeInstruction]()
        let nodes = findMatchingNodes(of: matching)
        
        for n in nodes {
            let nIndex = findNodeIndex(of: n.Node)
            matchingNodeIndexes.append(indexedNodeInstructions[nIndex])
        }
        
        return matchingNodeIndexes
    }
    
    func checkIndexedZNodes (of nodes: [IndexedNodeInstruction]) -> Bool {
        
        //var matchingZNodes = findMatchingNodeIndexes(of: "Z")
        var matchCount = 0
        
        for m in matchingZNodes {
            for n in nodes {
                if m.Node == n.Node {
                    matchCount+=1
                }
            }
        }
        
        if (matchCount == nodes.count) {
            return true
        } else {
            return false
        }
    }
    
    func checkSingleZNode (of node: IndexedNodeInstruction) -> Bool {
        for m in matchingZNodes {
            if (node.Node == m.Node) {
                return true
            }
        }
                
        return false
    }
    
    func checkZNodes (of nodes: [NodeInstruction]) -> Bool {
        var nodeCount = 0
        
        for n in nodes {
            if (n.Node.last == "Z") {
                nodeCount+=1
            }
        }
        
        if (nodeCount == nodes.count) {
            return true
        } else {
            return false
        }
    }
    
    func moveToNode (of ins: Character, of ni: NodeInstruction) -> NodeInstruction {
        var currentNode = ni
        
        if (ins == "L") {
            currentNode = findNode(of: currentNode.Left)
        }
        
        if (ins == "R") {
            currentNode = findNode(of: currentNode.Right)
        }
        
        return currentNode
    }
    
    func moveToIndexedNode (of ins: Character, of ni: IndexedNodeInstruction) -> IndexedNodeInstruction {
        
        var currentNode = ni
        
        if (ins == "L") {
            currentNode = indexedNodeInstructions[currentNode.Left]
        }
        
        if (ins == "R") {
            currentNode = indexedNodeInstructions[currentNode.Right]
        }
        
        return currentNode
        
    }
    
    func calculateLCM(of numbers: [Int]) -> Int {
        // Calculate the greatest common divisor (GCD)
        func calculateGCD(_ a: Int, _ b: Int) -> Int {
            var x = a
            var y = b
            while y != 0 {
                let temp = y
                y = x % y
                x = temp
            }
            return abs(x)
        }

        // Calculate LCM using the formula: LCM(a, b) = |a * b| / GCD(a, b)
        var lcm = 1
        for number in numbers {
            let gcd = calculateGCD(lcm, number)
            guard gcd != 0 else {
                // Avoid division by zero
                return 0
            }
            lcm = abs(lcm * number) / gcd
        }
        return lcm
    }
    
    func performSimultaneousInstructions () {
        
       
        
        var aiNodes = findMatchingNodeIndexes(of: "A")
        var zSteps = [Int]()
        
        var resetCount = 0
        
        var ainIndex = 0
        for ain in aiNodes {
            var steps = 1;
            var ended = false
            
            while ended == false {
                for i in Instructions {
                    
                    //for index in stride(from: 0, to: aiNodes.count, by: 1) {
                    //for index in stride(from: 0, to: aiNodes.count, by: 1) {
                        //aiNodes[index] = moveToIndexedNode(of: i, of: aiNodes[index])
                    //}
                    
                    
                    aiNodes[ainIndex] = moveToIndexedNode(of: i, of: aiNodes[ainIndex])
                                        
                    /*
                    if (checkIndexedZNodes(of: aiNodes) == true) {
                        print ("Landed on all Z nodes in: \(steps)")
                        ended = true
                        break;
                    }
                    */
                    
                    if (checkSingleZNode(of: aiNodes[ainIndex]) == true) {
                        print ("\(steps)")
                        zSteps.append(steps)
                        ended = true
                        break;
                    }
                    
                    steps += 1;
                    resetCount+=1;
                }
                //print ("Repeated instructions...")
                
                if (resetCount > 1000000) {
                    resetCount = 0
                    print ("Number of steps executed: \(steps)")
                }
            }
            ainIndex+=1
        }
        
        // Calculate LCM
        let lcm = calculateLCM(of: zSteps)
        print("LCM of \(zSteps) is: \(lcm)")
        //print ("Ended. Steps: \(steps)")
    }
    
    func performInstructions () {
        
        var currentNode = findNode(of: "AAA")
        var currentNodeIndex = indexedNodeInstructions [findNodeIndex(of: "AAA")]
        let endNodeIndex = indexedNodeInstructions [findNodeIndex(of: "ZZZ")]
        var steps = 1;
        var ended = false
        //var aNodes = findMatchingNodes(of: <#T##Character#>)
        
        
        while ended == false {
            for i in Instructions {
    
                currentNode = moveToNode(of: i, of: currentNode)
                currentNodeIndex = moveToIndexedNode(of: i, of: currentNodeIndex)
                
                if (currentNodeIndex.Node == endNodeIndex.Node) {
                    print ("Found Node In: \(steps)")
                    ended = true
                    break;
                }
                
                steps += 1;
            }
        }

        
        print ("Ended. Steps: \(steps)")
    }
    
    func Part1 (of inputString: String) {
        
        let lines = inputString.components(separatedBy: .newlines)
        
        
        var index = 0
        
        // Iterate through each line
        for line in lines {
            
            if (index == 0) {
                Instructions = line
            }
        
            
            // Skip empty lines
            if line.isEmpty {
                continue
            }
            
            // Check if the line contains an equals sign (=)
            if line.contains("=") {
                // Split the line into parts around the equals sign
                let parts = line.components(separatedBy: "=")
                                
                // Extract the node instruction and create a NodeInstruction object
                let leftRight = parts[1];
                let leftRightComponents = leftRight.components(separatedBy: ",")
                var leftnode = leftRightComponents[0]
                var rightnode = leftRightComponents[1]
                
                leftnode = leftnode.replacingOccurrences(of: "(", with: "")
                leftnode = leftnode.replacingOccurrences(of: " ", with: "")
                rightnode = rightnode.replacingOccurrences(of: ")", with: "")
                rightnode = rightnode.replacingOccurrences(of: " ", with: "")
                
                let nodeInstruction = NodeInstruction(
                    
                    Node: parts[0].trimmingCharacters(in: .whitespaces),
                    Left: leftnode,
                    Right: rightnode
                )
                
                // Add the NodeInstruction to the nodeInstructions array
                nodeInstructions.append(nodeInstruction)
            }
            
            index+=1
        }
        
        print ("Instructions: \(Instructions)")
        
        
        //print ("Node Instructions: \(nodeInstructions)")
        
        var nodeCount = 0
        for ins in nodeInstructions {
            print ("Node: \(ins.Node), Left: \(ins.Left), Right: \(ins.Right)")
            nodeCount+=1
        }
        
        print ("Total node count: \(nodeCount)")
        
        for int in nodeInstructions {
            nodeListIndex.append(int.Node)
        }
        
        // Now create the indexedMap
        for ins in nodeInstructions {
            let NodeIndex = findNodeIndex(of: ins.Node)
            let LeftIndex = findNodeIndex(of: ins.Left)
            let RightIndex = findNodeIndex(of: ins.Right)
            
            let indexedInstruction = IndexedNodeInstruction(Node: NodeIndex, Left: LeftIndex, Right: RightIndex)
            indexedNodeInstructions.append(indexedInstruction)
        }
        
        // Show the map
        for ins in indexedNodeInstructions {
            print ("Current indexed ins: \(ins)")
        }
        
        matchingZNodes = findMatchingNodeIndexes(of: "Z")
        
        let testZNodes = findMatchingNodeIndexes(of: "A")
        
        if (checkIndexedZNodes(of: testZNodes) == true) {
            print ("Index Z nodes: true")
        } else {
            print ("Index Z nodes: false")
        }
        
        //let orderedList = NSOrderedSet(array: nodeList)
        
        //let uniqueListWithOrder = orderedList.array as! [String]
        
        //print ("Unique count: \(uniqueListWithOrder.count)")
        //performInstructions()
        performSimultaneousInstructions()
        
    }
    
}
