//
//  CaseView.swift
//  Case Battle
//
//  Created by Mark Vadimov on 23.04.24.
//

import SwiftUI
import SwiftData

struct CasesView: View {
    @EnvironmentObject var viewModel: InfoList
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns){
                    ForEach($viewModel.cases, id: \.id){ $ccases in
                        CaseView(currCase: $ccases)
                            .onTapGesture {
                                viewModel.selectedCase = ccases
                                viewModel.openCasingScreen = true
                                viewModel.mainScreen = false
                        }
                    }
                }
            }
            .padding(.leading)
            .frame(width: 400)
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Image("bg-main"))
        .background(Color.secondDarkBlue)
    }
}


struct CaseView: View {
    @EnvironmentObject var viewModel: InfoList
    @Binding var currCase: Case
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(currCase.name.uppercased())
                .font(.system(size: 15))
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.9))
            
            HStack {
                Text("\(currCase.quantitySkins) предметов")
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.quantityGray)
                if currCase.isNew{
                    Image("case_new")
                        .resizable()
                        .frame(width: 30, height: 18)
                        
                        
                }
            }
            ZStack {
                Image(currCase.photoOfCase)
                    .resizable()
                    .frame(width: 150, height: 150)
                Image(currCase.photoOfWeapon)
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            
            HStack(alignment: .center) {
                Text(String(currCase.price)+" ₽")
                    .padding()
                    .foregroundColor(.middlePriceOrange)
                    .frame(width: 100, height: 30)
                    .background(Color.darkBlue)
                    .padding(2)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.firstPriceOrange, Color.secondPriceOrange]), startPoint: .leading, endPoint: .trailing))
                    .padding([.leading,.trailing],20)
                Spacer()
            }
                
        }
        .frame(width: 160, height: 250)
    }
}

#Preview {
    CasesView().environmentObject(InfoList())
}
