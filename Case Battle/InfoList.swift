import Foundation
import SwiftData

class InfoList: ObservableObject {
    @Published var headerMenuList = false
    @Published var openCasingScreen = false
    @Published var mainScreen = true
    @Published var selectedCase: Case?
    @Published var openingCase = false
    @Published var openingFastCase = false
    @Published var winnerSkin: Int = 0
    @Published var showWinnerSkin = false
    @Published var stopScrolling = false
    @Published var topUpMenu = false
    @Published var usdToRub = 91.73
    
    
    
    
    @Published var skins: [Skin] = [
        //AK-47
        Skin(id: 1, name: "Затерянная земля", rarity: "blue", weapon: "AK-47", price: 22, priceStatTrak: 136, photoImg: "middle-5c94b9a231c95"),
        Skin(id: 2, name: "Красный глянец", rarity: "pink", weapon: "AK-47", price: 3890, priceStatTrak: 0, photoImg: "middle-5c793a7068ad1"),
        Skin(id: 3, name: "Синий глянец", rarity: "purple", weapon: "AK-47", price: 939, priceStatTrak: 2098, photoImg: "middle-5c793a52196f1"),
        Skin(id: 4, name: "Поверхностная закалка", rarity: "pink", weapon: "AK-47", price: 17822, priceStatTrak: 32541, photoImg: "middle-5c793a9627511"),
        Skin(id: 5, name: "Хищник", rarity: "blue", weapon: "AK-47", price: 1329, priceStatTrak: 2412, photoImg: "middle-5c793ac37a66a"),
        Skin(id: 6, name: "Черный глянец", rarity: "blue", weapon: "AK-47", price: 2429, priceStatTrak: 3333, photoImg: "middle-5c793ad1b0eda"),
        Skin(id: 7, name: "Африканская сетка", rarity: "gray", weapon: "AK-47", price: 4, priceStatTrak: 0, photoImg: "middle-5c793aecc0a36"),
        Skin(id: 8, name: "Цвет джунглей", rarity: "blue", weapon: "AK-47", price: 350, priceStatTrak: 1000, photoImg: "middle-5c793af476cbf"),
        Skin(id: 9, name: "Огненный змей", rarity: "red", weapon: "AK-47", price: 51550, priceStatTrak: 124000, photoImg: "middle-5c793b1f036fd"),
        Skin(id: 10, name: "Красная линия", rarity: "pink", weapon: "AK-47", price: 1075, priceStatTrak: 2312, photoImg: "middle-5c793baab066d"),
        Skin(id: 11, name: "Изумрудные завитки", rarity: "purple", weapon: "AK-47", price: 158, priceStatTrak: 0, photoImg: "middle-5c793be618199"),
        Skin(id: 12, name: "Вулкан", rarity: "red", weapon: "AK-47", price: 8124, priceStatTrak: 12916, photoImg: "middle-5c793bec2c2bf")
    ]
    
    @Published var profileImage = "image1"
    @Published var profileName = "Bob"
    @Published var moneyQuantity = 1466.2
    
    @Published var cases: [Case] = [
        Case(id: 1, name: "CHROMA", type: 1, isNew: true, price: 79, secPrice: 0, quantitySkins: 36, photoOfCase: "1", photoOfWeapon: "1.1", isLiked: true, skinRanges: [
            1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
            2: [SkinRange(minNumber: 11, maxNumber: 50), SkinRange(minNumber: 201, maxNumber: 300)],
            3: [SkinRange(minNumber: 61, maxNumber: 70), SkinRange(minNumber: 801, maxNumber: 820)],
            4: [SkinRange(minNumber: 101, maxNumber: 150), SkinRange(minNumber: 351, maxNumber: 400)],
            5: [SkinRange(minNumber: 151, maxNumber: 200), SkinRange(minNumber: 401, maxNumber: 450)],
            6: [SkinRange(minNumber: 71, maxNumber: 100), SkinRange(minNumber: 821, maxNumber: 900)],
            7: [SkinRange(minNumber: 301, maxNumber: 350), SkinRange(minNumber: 451, maxNumber: 500)],
            8: [SkinRange(minNumber: 501, maxNumber: 550), SkinRange(minNumber: 701, maxNumber: 800)],
            9: [SkinRange(minNumber: 901, maxNumber: 940)],
            10: [SkinRange(minNumber: 941, maxNumber: 1000)],
            11: [SkinRange(minNumber: 551, maxNumber: 670)],
            12: [SkinRange(minNumber: 671, maxNumber: 700)]
        ]),
        
        Case(id: 2, name: "CHROMA 2", type: 1, isNew: true, price: 555, secPrice: 0, quantitySkins: 45, photoOfCase: "2", photoOfWeapon: "2.1", isLiked: false, skinRanges: [
            1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
            2: [SkinRange(minNumber: 11, maxNumber: 50), SkinRange(minNumber: 201, maxNumber: 300)],
            3: [SkinRange(minNumber: 61, maxNumber: 70), SkinRange(minNumber: 801, maxNumber: 820)],
            4: [SkinRange(minNumber: 101, maxNumber: 150), SkinRange(minNumber: 351, maxNumber: 400)],
            5: [SkinRange(minNumber: 151, maxNumber: 200), SkinRange(minNumber: 401, maxNumber: 450)],
            6: [SkinRange(minNumber: 71, maxNumber: 100), SkinRange(minNumber: 821, maxNumber: 900)],
            7: [SkinRange(minNumber: 301, maxNumber: 350), SkinRange(minNumber: 451, maxNumber: 500)],
            8: [SkinRange(minNumber: 501, maxNumber: 550), SkinRange(minNumber: 701, maxNumber: 800)],
            9: [SkinRange(minNumber: 901, maxNumber: 940)],
            10: [SkinRange(minNumber: 941, maxNumber: 1000)],
            11: [SkinRange(minNumber: 551, maxNumber: 670)],
            12: [SkinRange(minNumber: 671, maxNumber: 700)]
        ]),
        Case(id: 3, name: "OPERATION BREAKOUT", type: 1, isNew: false, price: 89, secPrice: 0, quantitySkins: 38, photoOfCase: "3", photoOfWeapon: "3.1", isLiked: false, skinRanges: [
            1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
            2: [SkinRange(minNumber: 11, maxNumber: 50), SkinRange(minNumber: 201, maxNumber: 300)],
            3: [SkinRange(minNumber: 61, maxNumber: 70), SkinRange(minNumber: 801, maxNumber: 820)],
            4: [SkinRange(minNumber: 101, maxNumber: 150), SkinRange(minNumber: 351, maxNumber: 400)],
            5: [SkinRange(minNumber: 151, maxNumber: 200), SkinRange(minNumber: 401, maxNumber: 450)],
            6: [SkinRange(minNumber: 71, maxNumber: 100), SkinRange(minNumber: 821, maxNumber: 900)],
            7: [SkinRange(minNumber: 301, maxNumber: 350), SkinRange(minNumber: 451, maxNumber: 500)],
            8: [SkinRange(minNumber: 501, maxNumber: 550), SkinRange(minNumber: 701, maxNumber: 800)],
            9: [SkinRange(minNumber: 901, maxNumber: 940)],
            10: [SkinRange(minNumber: 941, maxNumber: 1000)],
            11: [SkinRange(minNumber: 551, maxNumber: 670)],
            12: [SkinRange(minNumber: 671, maxNumber: 700)]
        ]),
        Case(id: 4, name: "OPERATION WILDFIRE", type: 1, isNew: false, price: 19, secPrice: 0, quantitySkins: 40, photoOfCase: "4", photoOfWeapon: "4.1", isLiked: false, skinRanges: [
            1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
            2: [SkinRange(minNumber: 11, maxNumber: 50), SkinRange(minNumber: 201, maxNumber: 300)],
            3: [SkinRange(minNumber: 61, maxNumber: 70), SkinRange(minNumber: 801, maxNumber: 820)],
            4: [SkinRange(minNumber: 101, maxNumber: 150), SkinRange(minNumber: 351, maxNumber: 400)],
            5: [SkinRange(minNumber: 151, maxNumber: 200), SkinRange(minNumber: 401, maxNumber: 450)],
            6: [SkinRange(minNumber: 71, maxNumber: 100), SkinRange(minNumber: 821, maxNumber: 900)],
            7: [SkinRange(minNumber: 301, maxNumber: 350), SkinRange(minNumber: 451, maxNumber: 500)],
            8: [SkinRange(minNumber: 501, maxNumber: 550), SkinRange(minNumber: 701, maxNumber: 800)],
            9: [SkinRange(minNumber: 901, maxNumber: 940)],
            10: [SkinRange(minNumber: 941, maxNumber: 1000)],
            11: [SkinRange(minNumber: 551, maxNumber: 670)],
            12: [SkinRange(minNumber: 671, maxNumber: 700)]
        ]),
        Case(id: 5, name: "WINTER OFFENSIVE", type: 1, isNew: true, price: 69, secPrice: 52, quantitySkins: 38, photoOfCase: "5", photoOfWeapon: "5.1", isLiked: true, skinRanges: [
            1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
            2: [SkinRange(minNumber: 11, maxNumber: 50), SkinRange(minNumber: 201, maxNumber: 300)],
            3: [SkinRange(minNumber: 61, maxNumber: 70), SkinRange(minNumber: 801, maxNumber: 820)],
            4: [SkinRange(minNumber: 101, maxNumber: 150), SkinRange(minNumber: 351, maxNumber: 400)],
            5: [SkinRange(minNumber: 151, maxNumber: 200), SkinRange(minNumber: 401, maxNumber: 450)],
            6: [SkinRange(minNumber: 71, maxNumber: 100), SkinRange(minNumber: 821, maxNumber: 900)],
            7: [SkinRange(minNumber: 301, maxNumber: 350), SkinRange(minNumber: 451, maxNumber: 500)],
            8: [SkinRange(minNumber: 501, maxNumber: 550), SkinRange(minNumber: 701, maxNumber: 800)],
            9: [SkinRange(minNumber: 901, maxNumber: 940)],
            10: [SkinRange(minNumber: 941, maxNumber: 1000)],
            11: [SkinRange(minNumber: 551, maxNumber: 670)],
            12: [SkinRange(minNumber: 671, maxNumber: 700)]
                ]),
        Case(id: 6, name: "OPERATION BRAVO", type: 1, isNew: true, price: 140, secPrice: 0, quantitySkins: 35, photoOfCase: "6", photoOfWeapon: "6.1", isLiked: false, skinRanges: [
            1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
            2: [SkinRange(minNumber: 11, maxNumber: 50), SkinRange(minNumber: 201, maxNumber: 300)],
            3: [SkinRange(minNumber: 61, maxNumber: 70), SkinRange(minNumber: 801, maxNumber: 820)],
            4: [SkinRange(minNumber: 101, maxNumber: 150), SkinRange(minNumber: 351, maxNumber: 400)],
            5: [SkinRange(minNumber: 151, maxNumber: 200), SkinRange(minNumber: 401, maxNumber: 450)],
            6: [SkinRange(minNumber: 71, maxNumber: 100), SkinRange(minNumber: 821, maxNumber: 900)],
            7: [SkinRange(minNumber: 301, maxNumber: 350), SkinRange(minNumber: 451, maxNumber: 500)],
            8: [SkinRange(minNumber: 501, maxNumber: 550), SkinRange(minNumber: 701, maxNumber: 800)],
            9: [SkinRange(minNumber: 901, maxNumber: 940)],
            10: [SkinRange(minNumber: 941, maxNumber: 1000)],
            11: [SkinRange(minNumber: 551, maxNumber: 670)],
            12: [SkinRange(minNumber: 671, maxNumber: 700)]
                ]),
        Case(id: 7, name: "BRAVO CASE", type: 1, isNew: false, price: 400, secPrice: 379, quantitySkins: 44, photoOfCase: "7", photoOfWeapon: "7.1", isLiked: false, skinRanges: [
            1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
            2: [SkinRange(minNumber: 11, maxNumber: 50), SkinRange(minNumber: 201, maxNumber: 300)],
            3: [SkinRange(minNumber: 61, maxNumber: 70), SkinRange(minNumber: 801, maxNumber: 820)],
            4: [SkinRange(minNumber: 101, maxNumber: 150), SkinRange(minNumber: 351, maxNumber: 400)],
            5: [SkinRange(minNumber: 151, maxNumber: 200), SkinRange(minNumber: 401, maxNumber: 450)],
            6: [SkinRange(minNumber: 71, maxNumber: 100), SkinRange(minNumber: 821, maxNumber: 900)],
            7: [SkinRange(minNumber: 301, maxNumber: 350), SkinRange(minNumber: 451, maxNumber: 500)],
            8: [SkinRange(minNumber: 501, maxNumber: 550), SkinRange(minNumber: 701, maxNumber: 800)],
            9: [SkinRange(minNumber: 901, maxNumber: 940)],
            10: [SkinRange(minNumber: 941, maxNumber: 1000)],
            11: [SkinRange(minNumber: 551, maxNumber: 670)],
            12: [SkinRange(minNumber: 671, maxNumber: 700)]
                ])
    ]
    
    @Published var promocodes = [
        Promocode(id: 1, promo: "Carrot", percent: 10, startTime: createDate(hour: 0, minute: 0), endTime: createDate(hour: 4, minute: 0)),
        Promocode(id: 2, promo: "Unicorn", percent: 11, startTime: createDate(hour: 4, minute: 0), endTime: createDate(hour: 8, minute: 0)),
        Promocode(id: 3, promo: "Bumblebee", percent: 12, startTime: createDate(hour: 8, minute: 0), endTime: createDate(hour: 12, minute: 0)),
        Promocode(id: 4, promo: "Modern", percent: 13, startTime: createDate(hour: 12, minute: 0), endTime: createDate(hour: 18, minute: 0)),
        Promocode(id: 5, promo: "Star", percent: 14, startTime: createDate(hour: 18, minute: 0), endTime: createDate(hour: 24, minute: 0)),
    ]
    
    func findWinSkin(_ numOfSkin: Int) -> Skin? {
        if let selectedCase = selectedCase,
           let key = selectedCase.skinRanges.first(where: { (_, ranges) in
            ranges.contains { range in
                numOfSkin >= range.minNumber && numOfSkin <= range.maxNumber
            }
        })?.key {
            return skins[key - 1]
        }
        return nil
    }
}
