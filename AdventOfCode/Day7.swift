//
//  Day7.swift
//  AdventOfCode
//
//  Created by Danny Draper on 07/12/2023.
//

import Foundation
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class Day7 {
    
    var AllCamelCards = [CamelCard]()
    struct CamelCard {
        var cardHand: String
        var bid: Int
    }
    
    enum CardType: Int {
        case highCard = 1, onePair, twoPair, threeKind, fullHouse, fourKind, fiveKind, invalid
    }
    
    init() {
        
    }
    

    
    func identifyCardTypeWithJoker(cards: String) -> CardType {
        guard cards.count == 5 else {
            return .invalid
        }

        var cardCharacters = Array(cards)

        // Find the position of Jokers in the hand
        let jokerIndices = cardCharacters.indices.filter { cardCharacters[$0] == "J" }

        for jokerIndex in jokerIndices {
            // Try each possible replacement for the Joker and calculate the hand strength
            var possibleHands = [String]()

            for replacementChar in ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2"] {
                var tempHand = cardCharacters
                tempHand.replaceSubrange(jokerIndex...jokerIndex, with: [Character](replacementChar))
                possibleHands.append(String(tempHand))
            }

            // Choose the replacement that results in the strongest hand
            let strongestHand = possibleHands.max { hand1, hand2 in
                return identifyCardType(cards: hand1).rawValue < identifyCardType(cards: hand2).rawValue
            }

            if let strongestHand = strongestHand {
                cardCharacters = Array(strongestHand)
            }
        }

        let cardCounts = Dictionary(grouping: cardCharacters, by: { $0 }).mapValues { $0.count }

        // Determine the hand type based on the counts
        switch cardCounts.values.sorted() {
        case [1, 1, 1, 1, 1]:
            return .highCard
        case [1, 1, 1, 2]:
            return .onePair
        case [1, 2, 2]:
            return .twoPair
        case [1, 1, 3]:
            return .threeKind
        case [1, 4]:
            return .fourKind
        case [2, 3]:
            return .fullHouse
        case [5]:
            return .fiveKind
        default:
            return .invalid
        }
    }

    
    func identifyCardType(cards: String) -> CardType {
        guard cards.count == 5 else {
            return .invalid
        }

        let cardCharacters = Array(cards)
        let cardCounts = Dictionary(grouping: cardCharacters, by: { $0 }).mapValues { $0.count }

        switch cardCounts.values.sorted() {
        case [1, 1, 1, 1, 1]:
            return .highCard
        case [1, 1, 1, 2]:
            return .onePair
        case [1, 2, 2]:
            return .twoPair
        case [1, 1, 3]:
            return .threeKind
        case [1, 4]:
            return .fourKind
        case [2, 3]:
            return .fullHouse
        case [5]:
            return .fiveKind
        default:
            return .invalid
        }
    }
    
    func cardStrengthJoker(_ card: Character) -> Int {
        switch card {
        case "A": return 14
        case "K": return 13
        case "Q": return 12
        //case "J": return 11
        case "T": return 11
        case "9": return 10
        case "8": return 9
        case "7": return 8
        case "6": return 7
        case "5": return 6
        case "4": return 5
        case "3": return 4
        case "2": return 3
        case "J": return 2
        default: return 0 // Invalid card, consider it as the weakest
        }
    }
    
    func cardStrength (_ card: Character) -> Int {
        switch card {
        case "A": return 14
        case "K": return 13
        case "Q": return 12
        case "J": return 11
        case "T": return 10
        case "9": return 9
        case "8": return 8
        case "7": return 7
        case "6": return 6
        case "5": return 5
        case "4": return 4
        case "3": return 3
        case "2": return 2
        
        default: return 0 // Invalid card, consider it as the weakest
        }
    }
    
    /*
    func compareHands(_ hand1: CamelCard, _ hand2: CamelCard) -> Bool {
        let hand1Type = identifyCardType(cards: hand1.cardHand)
        let hand2Type = identifyCardType(cards: hand2.cardHand)

        if hand1Type.rawValue < hand2Type.rawValue {
            return true
        } else if hand1Type.rawValue > hand2Type.rawValue {
            return false
        }

        // If the hands have the same type, use the second ordering rule
        let cards1 = Array(hand1.cardHand)
        let cards2 = Array(hand2.cardHand)

        for i in 0..<cards1.count {
            if cards1[i] != cards2[i] {
                return cards1[i] > cards2[i]
            }
        }

        // If all cards are the same, consider the hands as equal
        return true
    }
    */
    
    func compareHands(_ hand1: CamelCard, _ hand2: CamelCard) -> Bool {
        let hand1Type = identifyCardTypeWithJoker(cards: hand1.cardHand)
        let hand2Type = identifyCardTypeWithJoker(cards: hand2.cardHand)

        if hand1Type.rawValue < hand2Type.rawValue {
            return true
        } else if hand1Type.rawValue > hand2Type.rawValue {
            return false
        }

        // If the hands have the same type, use the second ordering rule
        let cards1 = Array(hand1.cardHand)
        let cards2 = Array(hand2.cardHand)

        for i in 0..<cards1.count {
            let cardValue1 = cardStrengthJoker(cards1[i])
            let cardValue2 = cardStrengthJoker(cards2[i])

            if cardValue1 != cardValue2 {
                return cardValue1 < cardValue2
            }
        }

        // If all cards are the same, consider the hands as equal
        return true
    }
    
    /*
    func orderHandsByRank(_ hands: [String]) -> [String] {
        return hands.sorted(by: { (hand1, hand2) -> Bool in
            return compareHands(hand1, hand2)
        })
    }
    */
    
    func orderHandsByRank(_ hands: [CamelCard]) -> [CamelCard] {
        return hands.sorted(by: { compareHands($0, $1) })
    }
    
    func testMethod() {
        // Example usage:
        let hand1 = CamelCard(cardHand: "32T3K", bid: 765)
        let hand2 = CamelCard(cardHand: "T55J5", bid: 684)
        let hand3 = CamelCard(cardHand: "KK677", bid: 28)
        let hand4 = CamelCard(cardHand: "KTJJT", bid: 220)
        let hand5 = CamelCard(cardHand: "QQQJA", bid: 483)
        //let hand6 = CamelCard(cardHand: "98763", bid: 0)

        print("Hand 1: \(hand1.cardHand) \(identifyCardTypeWithJoker(cards: hand1.cardHand))") // Output: FiveKind
        print("Hand 2: \(hand2.cardHand) \(identifyCardTypeWithJoker(cards: hand2.cardHand))") // Output: FourKind
        print("Hand 3: \(hand3.cardHand) \(identifyCardTypeWithJoker(cards: hand3.cardHand))") // Output: FullHouse
        print("Hand 4: \(hand4.cardHand) \(identifyCardTypeWithJoker(cards: hand4.cardHand))") // Output: ThreeKind
        print("Hand 5: \(hand5.cardHand) \(identifyCardTypeWithJoker(cards: hand5.cardHand))") // Output: TwoPair
        //print("Hand 6: \(identifyCardType(cards: hand6.cardHand))")

        let handsToOrder = [
            CamelCard(cardHand: "32T3K", bid: 765),
            CamelCard(cardHand: "T55J5", bid: 684),
            CamelCard(cardHand: "KK677", bid: 28),
            CamelCard(cardHand: "KTJJT", bid: 220),
            CamelCard(cardHand: "QQQJA", bid: 483),
            //CamelCard(cardHand: "12345", bid: 555)
        ]

        let orderedHands = orderHandsByRank(handsToOrder)
        var total = 0;
        
        for (index, hand) in orderedHands.enumerated() {
            print("Rank \(index + 1): Hand = \(hand.cardHand), Bid = \(hand.bid)")
            total += ((index + 1) * hand.bid)
        }
        
        print ("Total: \(total)")
    }
    
    func parseCamelCards(from lines: [String]) -> [CamelCard] {
        var camelCards: [CamelCard] = []

        for line in lines {
            let components = line.components(separatedBy: " ")

            guard components.count == 2, let bid = Int(components[1]) else {
                // Skip lines with incorrect format
                continue
            }

            let camelCard = CamelCard(cardHand: components[0], bid: bid)
            camelCards.append(camelCard)
        }

        return camelCards
    }
    
    func Part1 (of inputString: String) {
        
        //testMethod()
        //return
        let lines = inputString.components(separatedBy: .newlines)
        
        AllCamelCards = parseCamelCards(from: lines)
        
        //for (index, card) in AllCamelCards.enumerated() {
        //    print("Card \(index + 1): Hand = \(card.cardHand), Bid = \(card.bid)")
        //}
        
        let orderedHands = orderHandsByRank(AllCamelCards)
        var total = 0;
        
        for (index, hand) in orderedHands.enumerated() {
            print("Rank \(index + 1): Hand = \(hand.cardHand), Bid = \(hand.bid), Type: \(identifyCardTypeWithJoker(cards: hand.cardHand))")
            total += ((index + 1) * hand.bid)
        }
        
        print ("Total: \(total)")
        
    }
}
