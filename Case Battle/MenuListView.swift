//
//  SwiftUIView.swift
//  Case Battle
//
//  Created by Mark Vadimov on 14.05.24.
//

import SwiftUI
import SwiftData

struct MenuListView: View {
    @EnvironmentObject var viewModel: InfoList
    var body: some View {
        VStack{
            VStack{
                HStack(spacing: 20){
                    Image(viewModel.profileImage)
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                    //MARK: orange border
                    VStack(alignment: .leading) {
                        Text("Привет, \(viewModel.profileName)")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        Text("На счете: \(String(viewModel.moneyQuantity)) ₽")
                            .fontWeight(.semibold)
                            .font(.system(size: 15))
                    }
                    .foregroundColor(.middlePriceOrange)
                    Spacer()
                    Image("wallet")
                        .resizable()
                        .frame(width: 40, height: 35)
                        .foregroundColor(.middlePriceOrange)
                        .onTapGesture {
                            viewModel.topUpMenu = true
                        }
                }
                .padding([.top, .bottom], 15)
                .padding(.horizontal, 30)
                
                VStack(alignment: .center, spacing: -1){
                    
                    
                    HStack(alignment: .center){
                        Image("giveaway-icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("РОЗЫГРЫШИ")
                            .foregroundColor(.quantityGray)
                            .font(.system(size: 20))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .padding(.horizontal, 20)
                    .border(Color.quantityGray.opacity(0.25))
                    
                    
                    HStack{
                        Image("contract-icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("КОНТРАКТЫ")
                            .foregroundColor(.quantityGray)
                            .font(.system(size: 20))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .padding(.horizontal, 20)
                    .border(Color.quantityGray.opacity(0.25))
                    
                    
                    HStack{
                        Image("upgrade-icon")
                            .resizable()
                            .frame(width: 20, height: 25)
                            .padding(.leading, -25)
                        Text("АПГРЕЙД")
                            .foregroundColor(.quantityGray)
                            .font(.system(size: 20))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .padding(.horizontal, 20)
                    .border(Color.quantityGray.opacity(0.25))
                    
                    
                    HStack{
                        Image("battlepass-icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("BATTLE PASS")
                            .foregroundColor(.quantityGray)
                            .font(.system(size: 20))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .padding(.horizontal, 20)
                    .border(Color.quantityGray.opacity(0.25))
                    
                    
                    HStack(spacing: 30){
                        Image("telegram")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Image("youtube")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Image("vk")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .padding(.horizontal, 20)
                    .border(Color.quantityGray.opacity(0.25))
                }
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.black.opacity(0.98))
    }
}

#Preview {
    MenuListView().environmentObject(InfoList())
}

