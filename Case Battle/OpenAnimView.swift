//
//  OpenAnimView.swift
//  Case Battle
//
//  Created by Mark Vadimov on 30.04.24.
//

import SwiftUI
import SwiftData

struct OpenAnimView: View {
    @EnvironmentObject var viewModel: InfoList
    @Binding var currentCase: Case
    @State private var skinValues: [Int] = []
    @State private var contentOffset: CGPoint = .zero
    
    var body: some View {
        VStack {
            VStack {
                HorizontalScrollableView(self.$contentOffset, animationDuration: viewModel.openingFastCase ? 0 : 7) {
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(skinValues, id: \.self) { number in
                                    if let key = self.currentCase.skinRanges.first(where: { (_, ranges) in
                                        ranges.contains { range in
                                            number >= range.minNumber && number <= range.maxNumber
                                        }
                                    })?.key {
                                        let skin = self.viewModel.skins[key - 1]
                                        
                                        if skin != nil {
                                            SkinsInOpeningAnimView(skinInCase: skin)
                                                .id(number)
                                        }
                                    }
                                }
                            }
                            .onAppear {
                                generateSkinValues()
                            }
                        }
                        .scrollDisabled(true)
                        .onAppear(){
                            self.contentOffset = CGPoint(x: 5930, y: 0)
                        }
                    }
                    
                }
                .padding(.top, 50)
            }
            .background(OpenCaseCircle())
        }
        .frame(width: UIScreen.main.bounds.width, height: 230)
    }
    func generateSkinValues() {
        skinValues = []
        for _ in 0..<40 {
            let randomValue = Int.random(in: 1...1000)
            skinValues.append(randomValue)
        }
        viewModel.winnerSkin = skinValues[skinValues.count - 2]
        if viewModel.openingCase  && viewModel.showWinnerSkin{
            skinValues = []
            viewModel.winnerSkin = 0
        }
    }
}


struct OpenCaseCircle: View {
    @EnvironmentObject var viewModel: InfoList
    @State private var angle: Double = 0
    var body: some View {
        ZStack {
            Image("case-circle")
                .resizable()
                .frame(width: 325, height: 325)
                .rotationEffect(.degrees(angle))
                .opacity(viewModel.showWinnerSkin ? 0.01 : 0.99)
                .animation(Animation.easeOut(duration: viewModel.openingFastCase ? 0 : 7))
                .onAppear {
                    self.angle = 360
                }
            
            
            Image("csgo-man-circle")
                .resizable()
                .frame(width: 175, height: 175)
        }
    }
}

struct SkinsInOpeningAnimView: View {
    @State var skinInCase: Skin
    var body: some View {
        
        ZStack(alignment: .top) {
            Image(skinInCase.photoImg)
                .resizable()
                .frame(width: 180, height: 150)
                .padding(.bottom)
            HStack{
                Spacer()
                VStack(alignment: .center){
                    Spacer()
                    Text(skinInCase.weapon)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .padding(.leading, 10)
                    Text(skinInCase.name)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                }
                .padding(.bottom, 10)
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .frame(width: 140, height: 140)
        
    }
}

#Preview {
    OpenAnimView(currentCase: .constant(Case(id: 1, name: "Терминиды", type: 1, isNew: true, price: 79, secPrice: 0, quantitySkins: 36, photoOfCase: "232_middle-6622657da6672", photoOfWeapon: "231_middle-66226ef71c069", isLiked: true, skinRanges: [
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
