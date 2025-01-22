//
//  Cases.swift
//  Case Battle
//
//  Created by Mark Vadimov on 23.04.24.
//

import Foundation
import SwiftData

struct Skin: Identifiable {
    var id: Int
    var name: String
    var rarity: String
    let weapon: String
    let price: Double
    let priceStatTrak: Double
    let photoImg: String
}

struct SkinRange{
    var minNumber: Int
    var maxNumber: Int
}

struct Case: Identifiable {
    var id: Int
    var name: String
    let type: Int
    var isNew: Bool
    var price: Int
    var secPrice: Int
    let quantitySkins: Int
    var photoOfCase: String
    var photoOfWeapon: String
    var isLiked: Bool
    var skinRanges: [Int: [SkinRange]]
}

struct Promocode: Identifiable {
    let id: Int
    let promo: String
    let percent: Int
    let startTime: Date
    let endTime: Date
}

struct CryptoList: Identifiable {
    var isSelected: Bool
    let nameOfCoin: String
    let shortNameOfCoin: String
    let nameOfCurrency: String
    let imageOfCoin: String
    let exchangeRate: Double
    let minimalSum: Double
    var id: String {nameOfCoin}
}

struct CardList: Identifiable {
    let id: Int
    var isSelected: Bool
    let isP2P: Bool
    let isNew: Bool
    let fstImage: String
    let secImage: String
    let valueText: String
    let nameOfCurrency: String
    let symbolOfValue: String
    let text: String
    let minimalSum: Double
    let exchangeRate: Double
}

func createDate(hour: Int, minute: Int) -> Date {
    let calendar = Calendar.current
    let currentDate = Date()
    let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
    return calendar.date(from: components)!
        .addingTimeInterval(TimeInterval(hour * 3600 + minute * 60))
}

@Model
final class Group {
    var nameOfGroup: Int
    
    init(nameOfGroup: Int) {
        self.nameOfGroup = nameOfGroup
    }
}
