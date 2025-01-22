//
//  OpenCaseView.swift
//  Case Battle
//
//  Created by Mark Vadimov on 24.04.24.
//

import SwiftUI
import SwiftData
import Foundation

struct OpenCaseView: View {
    @EnvironmentObject var viewModel: InfoList
    @Binding var ccase: Case!
    
    var body: some View {
        ZStack{
            VStack {
                FirstHeader(menuList: $viewModel.headerMenuList)
                ZStack{
                    ScrollView {
                        SecondHeader().environmentObject(InfoList())
                            .padding(.bottom, -15)
                        
                        ZStack {
                            VStack {
                                HStack() {
                                    Spacer()
                                    VStack (spacing: 5){
                                        Text("ФИРМЕННЫЙ КЕЙС")
                                            .font(.system(size: 15))
                                            .foregroundColor(.quantityGray)
                                            .fontWeight(.bold)
                                        Text("\(ccase.name.uppercased())")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                    }
                                    .padding(.leading, 30)
                                    
                                    Spacer()
                                }
                                .padding(.trailing, 10)
                                
                                //MARK: for Opening Scroll
                                ZStack {
                                    ZStack {
                                        Image(viewModel.openingCase ? "" : ccase.photoOfCase)
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                        Image(viewModel.openingCase ? "" : ccase.photoOfWeapon)
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                    }
                                    .padding(.bottom, 20)
                                    .background(viewModel.openingCase ? nil : CaseCircle()
                                        .offset(x: -15))
                                    
                                    
                                    
                                    if viewModel.openingCase {
                                        ZStack{
                                            OpenAnimView(currentCase: Binding($ccase)!)
                                                .padding([.bottom, .trailing], 25)
                                                .animation(Animation.linear(duration: 2))
                                                .opacity(viewModel.showWinnerSkin ? 0.1 : 0.9)
                                            if viewModel.showWinnerSkin && viewModel.openingCase{
                                                WinSkinAnim(currentCase: Binding($ccase)!)
                                                    .padding(.bottom, 20)
                                                    .padding(.trailing, 22)
                                            }
                                            
                                        }
                                    }
                                }
                                .padding(.top, -10)
                                //MARK: Stop Scrolling
                                
                                HStack(spacing: 10) {
                                    Spacer()
                                    
                                    
                                    if !viewModel.showWinnerSkin {
                                        if viewModel.moneyQuantity > Double(ccase.secPrice == 0 ? ccase.price : ccase.secPrice) {
                                            HStack{
                                                
                                                HStack(spacing: 4){
                                                    Image(systemName: "cube.fill")
                                                        .resizable()
                                                        .frame(width: 20, height: 20)
                                                    Text("ОТКРЫТЬ ЗА \(String(ccase.secPrice == 0 ? ccase.price : ccase.secPrice))₽")
                                                        .font(.system(size: 13))
                                                        .fontWeight(.medium)
                                                        .foregroundColor(viewModel.openingCase ? .gray.opacity(0.75) : .white)
                                                    
                                                        .onTapGesture{
                                                            viewModel.moneyQuantity -= Double(ccase.secPrice == 0 ? ccase.price : ccase.secPrice)
                                                            
                                                            viewModel.openingCase.toggle()
                                                            if viewModel.openingCase {
                                                                viewModel.showWinnerSkin = false
                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 7)
                                                                {
                                                                    if viewModel.openingCase {
                                                                        viewModel.showWinnerSkin = true
                                                                    }
                                                                }
                                                            }
                                                        }
                                                }
                                                .padding(0)
                                                .foregroundColor(viewModel.openingCase ? Color.gray : .middlePriceOrange)
                                                .frame(width: 170, height: 35)
                                                .background(LinearGradient(gradient: Gradient(colors: [viewModel.openingCase ? Color.darkButton : Color.firstOpenCaseButton, viewModel.openingCase ? Color.darkButton : Color.lastOpenCaseButton]), startPoint: .leading, endPoint: .trailing))
                                                .padding(2)
                                                .background(viewModel.openingCase ? Color.gray : Color.firstPriceOrange)
                                                
                                                
                                                
                                                HStack(spacing: 4){
                                                    Image(systemName: "bolt.fill")
                                                        .resizable()
                                                        .frame(width: 15, height: 20)
                                                    Text("БЫСТРО ЗА \(String(ccase.secPrice == 0 ? ccase.price : ccase.secPrice))₽")
                                                        .font(.system(size: 13))
                                                        .fontWeight(.medium)
                                                        .foregroundColor(viewModel.openingCase ? .gray.opacity(0.75) : .white)
                                                }
                                                .padding(0)
                                                .foregroundColor(viewModel.openingCase ? Color.gray : .middlePriceOrange)
                                                .frame(width: 170, height: 35)
                                                .background(LinearGradient(gradient: Gradient(colors: [viewModel.openingCase ? Color.darkButton : Color.firstOpenCaseButton, viewModel.openingCase ? Color.darkButton : Color.lastOpenCaseButton]), startPoint: .leading, endPoint: .trailing))
                                                .padding(2)
                                                .background(viewModel.openingCase ? Color.gray : Color.firstPriceOrange)
                                                .onTapGesture{
                                                    viewModel.moneyQuantity -= Double(ccase.secPrice == 0 ? ccase.price : ccase.secPrice)
                                                    viewModel.openingCase.toggle()
                                                    viewModel.openingFastCase.toggle()
                                                    if viewModel.openingCase {
                                                        viewModel.showWinnerSkin = false
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
                                                        {
                                                            if viewModel.openingCase {
                                                                viewModel.showWinnerSkin = true
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                        else {
                                            HStack{
                                                Image("coins")
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                VStack(alignment: .center){
                                                    Text("Чтобы открыть этот кейс, на балансе должно быть не менее \(String(ccase.secPrice == 0 ? ccase.price : ccase.secPrice))₽")
                                                        .font(.system(size: 13))
                                                        .frame(width: 240, height: 40)
                                                        .foregroundColor(Color.white)
                                                    
                                                    Text("Пополнить")
                                                        .padding(0)
                                                        .foregroundColor(viewModel.openingCase ? Color.gray : .middlePriceOrange)
                                                        .frame(width: 140, height: 30)
                                                        .background(LinearGradient(gradient: Gradient(colors: [viewModel.openingCase ? Color.darkButton : Color.firstOpenCaseButton, viewModel.openingCase ? Color.darkButton : Color.lastOpenCaseButton]), startPoint: .leading, endPoint: .trailing))
                                                        .padding(2)
                                                        .background(viewModel.openingCase ? Color.gray : Color.firstPriceOrange)
                                                        .onTapGesture{
                                                            viewModel.topUpMenu = true
                                                        }
                                                }
                                                .padding(.vertical, 5)
                                            }
                                            .frame(width: 330, height: 90)
                                            .background(Color.darkBlue.opacity(0.3))
                                        }
                                    }
                                    else {
                                        HStack{
                                            HStack(spacing: 4){
                                                Image(systemName: "creditcard")
                                                    .resizable()
                                                    .frame(width: 25, height: 20)
                                                Text("ПРОДАТЬ ЗА \(String(viewModel.findWinSkin(viewModel.winnerSkin)!.price))₽")
                                                    .font(.system(size: 13))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.white)
                                                
                                                    .onTapGesture{
                                                        viewModel.openingCase = false
                                                        viewModel.showWinnerSkin = false
                                                        viewModel.moneyQuantity += viewModel.findWinSkin(viewModel.winnerSkin)!.price
                                                        
                                                    }
                                            }
                                            .padding(0)
                                            .foregroundColor(.middlePriceOrange)
                                            .frame(width: 170, height: 35)
                                            .background(LinearGradient(gradient: Gradient(colors: [Color.firstOpenCaseButton, Color.lastOpenCaseButton]), startPoint: .leading, endPoint: .trailing))
                                            .padding(2)
                                            .background(Color.firstPriceOrange)
                                            
                                            
                                            
                                            HStack(spacing: 4){
                                                Image(systemName: "repeat")
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                Text("ЕЩЕ РАЗ")
                                                    .font(.system(size: 13))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.white)
                                                
                                                    .onTapGesture{
                                                        viewModel.openingCase = false
                                                        viewModel.openingFastCase = false
                                                        viewModel.showWinnerSkin = false
                                                        
                                                    }
                                            }
                                            .padding(0)
                                            .foregroundColor(.middlePriceOrange)
                                            .frame(width: 100, height: 35)
                                            .background(LinearGradient(gradient: Gradient(colors: [Color.firstOpenCaseButton, Color.lastOpenCaseButton]), startPoint: .leading, endPoint: .trailing))
                                            .padding(2)
                                            .background(Color.firstPriceOrange)
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    Spacer()
                                }
                            }
                            
                            .padding([.top, .bottom], 10)
                            .background(Image("bg-case")
                                .resizable()
                                .frame(width: 500))
                            
                        }
                        Text("Содержимое кейса".uppercased())
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.bottom, 15)
                        SkinsInCase(currentCase: Binding($ccase)!)
                        
                        
                    }
                    .background(Color.firstDarkBlue)
                    if viewModel.headerMenuList {
                        MenuListView()
                    }
                }
            }
            .background(Color.darkBlue)
            
            if viewModel.topUpMenu {
                TopupMoneyView()
            }
        }
    }
}

struct CaseCircle: View {
    @EnvironmentObject var viewModel: InfoList
    @State private var angle: Double = 0
    var body: some View {
        Image("case-circle")
            .resizable()
            .frame(width: 325, height: 325)
            .rotationEffect(.degrees(angle))
            .opacity(viewModel.showWinnerSkin ? 0.01 : 0.99)
            .animation(Animation.linear(duration: 50).repeatForever(autoreverses: false))
            .onAppear {
                self.angle = 360
            }
    }
}

struct SkinInCaseView: View {
    @State var skinInCase: Skin
    var checkColor: Color {
        switch skinInCase.rarity {
        case "red":
            return Color.red
        case "pink":
            return Color.lightPink
        case "purple":
            return Color.purple
        case "blue":
            return Color.blue
        case "lightBlue":
            return Color.lightBluePromo
        case "gray":
            return Color.gray
        default:
            return Color.clear
        }
    }
    var body: some View {
        
        ZStack(alignment: .top) {
            Image(skinInCase.photoImg)
                .resizable()
                .frame(width: 120, height: 110)
                .padding(.bottom)
            HStack {
                VStack(alignment: .leading){
                    Spacer()
                    
                    Text("\(String((Int(skinInCase.price))))₽")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .frame(width: 50)
                        .foregroundColor(.mainPriceOrange)
                        .padding(5)
                        .background(.mainPriceBlue)
                    Text(skinInCase.weapon)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                    Text(skinInCase.name)
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                }
                Spacer()
            }
            .padding(.bottom, 10)
        }
        .background(Image(skinInCase.rarity)
            .resizable()
            .frame(width: 155, height: 140))
        .frame(width: 155, height: 140)
        .padding([.leading, .top, .trailing], 2)
        .background(Color.mainPriceBlue)
        .padding(.bottom, 4)
        .background(Color(checkColor))
    }
}

struct SkinsInCase: View {
    @EnvironmentObject var viewModel: InfoList
    @Binding var currentCase: Case
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LazyVGrid(columns: columns) {
            let ids = Array(currentCase.skinRanges.keys)
            ForEach(ids, id: \.self) { num in
                let skins = viewModel.skins.filter{ $0.id == num }
                if !skins.isEmpty {
                    ForEach(skins, id: \.id) { skin in
                        SkinInCaseView(skinInCase: skin)
                    }
                }
            }
        }
    }
}




//#Preview {
//    SkinInCaseView(skinInCase: .constant(Skin(id: 1, name: "Азимов", rarity: "red", weapon: "AWP", price: 6950, priceStatTrak: 11404, photoImg: "51_middle-5c5591cd9a059")))
//}

//#Preview {
//    SkinsInCase(currentCase: .constant(Case(id: 1, name: "Терминиды", type: 1, isNew: true, price: 79, secPrice: 0, quantitySkins: 36, photoOfCase: "232_middle-6622657da6672", photoOfWeapon: "231_middle-66226ef71c069", isLiked: true, skinRanges: [
//        1: [SkinRange(minNumber: 1, maxNumber: 10), SkinRange(minNumber: 51, maxNumber: 60)],
//        2: [SkinRange(minNumber: 11, maxNumber: 20), SkinRange(minNumber: 61, maxNumber: 70)]
//    ]))).environmentObject(InfoList())
//}

#Preview {
    OpenCaseView(ccase: .constant(Case(id: 1, name: "Терминиды", type: 1, isNew: true, price: 79, secPrice: 0, quantitySkins: 36, photoOfCase: "232_middle-6622657da6672", photoOfWeapon: "231_middle-66226ef71c069", isLiked: true, skinRanges: [
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
