//
//  WinSkinAnim.swift
//  Case Battle
//
//  Created by Mark Vadimov on 8.05.24.
//

import SwiftUI
import SwiftData

struct WinSkinAnim: View {
    @EnvironmentObject var viewModel: InfoList
    @Binding var currentCase: Case
    var body: some View {
        HStack {
            WinnerSkinView(skinInCase: viewModel.findWinSkin(viewModel.winnerSkin)!)
        }
        .background(CaseCircleView())
    }
}

struct WinnerSkinView: View {
    @State var skinInCase: Skin
    var body: some View {

        ZStack(alignment: .top) {
            Image(skinInCase.photoImg)
                .resizable()
                .frame(width: 250, height: 230)
                .padding(.bottom)
            HStack{
                Spacer()
                VStack(alignment: .center){
                    Spacer()
                    Text(skinInCase.weapon)
                        .foregroundColor(.middlePriceOrange)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.leading, 10)
                    Text(skinInCase.name)
                        .foregroundColor(.middlePriceOrange)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
                .padding(.bottom, 10)
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .frame(width: 300, height: 250)

    }
}


struct CaseCircleView: View {
    @State private var angle: Double = 0
    var body: some View {
        ZStack {
            Image("case-circle")
                .resizable()
                .frame(width: 325, height: 325)
                .rotationEffect(.degrees(angle))
                .animation(Animation.easeOut(duration: 50))
                .onAppear {
                    self.angle = 360
                }
            
            
            Image("csgo-man-circle")
                .resizable()
                .frame(width: 175, height: 175)
        }
    }
}

#Preview{
    WinnerSkinView(skinInCase: Skin(id: 1, name: "Азимов", rarity: "red", weapon: "AWP", price: 6950, priceStatTrak: 11404, photoImg: "51_middle-5c5591cd9a059"))
}

#Preview {
    WinSkinAnim(currentCase: .constant(Case(id: 1, name: "Терминиды", type: 1, isNew: true, price: 79, secPrice: 0, quantitySkins: 36, photoOfCase: "232_middle-6622657da6672", photoOfWeapon: "231_middle-66226ef71c069", isLiked: true, skinRanges: [
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
    ]))).environmentObject(InfoList())
}
