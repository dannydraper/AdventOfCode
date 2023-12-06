//
//  Day4.swift
//  AdventOfCode
//
//  Created by Danny Draper on 06/12/2023.
//

import Foundation

class Day4 {
    var propertyOne: Int
    var allCards = [Card]()
    
    struct Card {
        var cardNumber: Int
        var winningNumbers = [Int]()
        var userNumbers = [Int]()
    }
    
    init(propertyOne: Int) {
        self.propertyOne = propertyOne
    }
    

    func getCardPoints (of inputCard: Card) -> Int {
        
        var points = 0
        var scored = false
        
        for winningNumber in inputCard.winningNumbers {
            if (inputCard.userNumbers.contains(winningNumber)) {
                print ("Card: \(inputCard.cardNumber) Contains: \(winningNumber)")
                
                if (scored == false) {
                    scored = true
                    points = 1
                } else {
                    points = points * 2
                }
                
            }
        }
        
        print ("Card: \(inputCard.cardNumber) Points: \(points)")
        
        return points;
    }

    func getCardCopies (of inputCard: Card) -> [Int] {
        var cardCopies = [Int]()
        var winCount = 0
        
        for winningNumber in inputCard.winningNumbers {
            if (inputCard.userNumbers.contains(winningNumber)) {
                winCount += 1
            }
        }
        
        var startingCard = inputCard.cardNumber
        for i in 0..<winCount {
            startingCard+=1
            cardCopies.append(startingCard)
        }
        
        return cardCopies
    }

    func getCardWithNumber (of cardNumber: Int) -> Card {
        for singleCard in allCards {
            if (singleCard.cardNumber == cardNumber) {
                return singleCard
            }
        }
        
        return Card(cardNumber: -1)
    }
    
    func processCardCopy (of startingCard: Int) -> Int {
        
        var totalCards = 0
        
        // Get card copies
        var cardObject = getCardWithNumber(of: startingCard)
        var cardCopies = getCardCopies(of: cardObject)
        
        //print ("Card Copies: \(cardCopies)")
        
        if (cardCopies.count > 0) {
            
            totalCards = totalCards + cardCopies.count
            
            for copiedCard in cardCopies {
                totalCards = totalCards + processCardCopy(of: copiedCard)
            }
        }
        
        return totalCards
    }
    
    func convertToCardObject (of cardString: String) -> Card {
        
        //print ("cardString: \(cardString)")
        
        if (cardString.count > 1) {
            var cardObject = Card(cardNumber: 0, winningNumbers: [Int](), userNumbers: [Int]())
            //var person1 = Person(name: "John", age: 25)
            //card split
            let a = cardString.split(separator: ":")
            
            let cardnumstring = a[0]
            var cardnum = cardnumstring.replacingOccurrences(of: "Card ", with: "")
            cardnum = cardnum.replacingOccurrences(of: " ", with: "")
            
            let cardnumint = Int(cardnum)!
                
            //print ("Card Num: \(cardnumint)")
            
            cardObject.cardNumber = cardnumint

            // Numbers
            let cn = a[1];
            let pipesplit = cn.split(separator: "|");
            
            let winstring = pipesplit[0]
            let userstring = pipesplit[1]
            
            //print ("Winning Numbers: \(winstring)")
            //print ("   User Numbers: \(userstring)")
            
            let winsplit = winstring.split (separator: " ")
            
            for wnum in winsplit {
                let cleanwin = wnum.replacingOccurrences(of: " ", with: "")
                let winint = Int(cleanwin)!
                cardObject.winningNumbers.append(winint)
                //print ("Int Winning Number: \(winint)")
            }
            
            let usersplit = userstring.split (separator: " ")
            
            for unum in usersplit {
                let cleanuser = unum.replacingOccurrences(of: " ", with: "")
                let userint = Int(cleanuser)!
                cardObject.userNumbers.append(userint)
                //print ("Int User Number: \(userint)")
            }
            
            return cardObject
        }
        
        
        return Card(cardNumber: -1)
    }
    
    func Part1 (of inputString: String) {
        
        
        let lines = inputString.components(separatedBy: .newlines)
        
        for singleLine in lines {
            //print ("Line: \(singleLine)")
            let cardObject = convertToCardObject(of: singleLine);
            if (cardObject.cardNumber > -1) {
                allCards.append(cardObject)
            }
            //print ("CardObject: \(cardObject)")
        }
        
        var totalPoints = 0
        for singleCard in allCards {
            let cardPoints = getCardPoints(of: singleCard)
            print ("Card Number: \(singleCard.cardNumber), Points: \(cardPoints)")
            totalPoints += cardPoints
        }
        
        print ("Card Object Count: \(allCards.count) Total Points: \(totalPoints)")
    }
    
    func Part2 (of inputString: String) {
        
        
        let lines = inputString.components(separatedBy: .newlines)
        
        for singleLine in lines {
            //print ("Line: \(singleLine)")
            let cardObject = convertToCardObject(of: singleLine);
            if (cardObject.cardNumber > -1) {
                allCards.append(cardObject)
            }
            //print ("CardObject: \(cardObject)")
        }
        
        //var cardCopies = getCardCopies(of: allCards[0])
        var totalrecursiveResult = 0;
        
        
        for singleCard in allCards {
            let recursiveResult = processCardCopy(of: singleCard.cardNumber)
            print ("Recursive Result for Card: \(singleCard.cardNumber) Result: \(recursiveResult)")
            
            totalrecursiveResult += recursiveResult
        }
        
        
        // Then finally add the number of scratchcards you originally had
        totalrecursiveResult += allCards.count
        
        print ("Total number of ScratchCards: \(totalrecursiveResult)")
        

        
        //print ("Card Copies: \(cardCopies)")
    }
}
