import SwiftUI
import SwiftData

struct FirstHeader: View {
    @EnvironmentObject var viewModel: InfoList
    @Binding var menuList: Bool
    @State var onlineQuantity = Int.random(in: 25..<1000)
    var body: some View {
        VStack{
            HStack {
                ZStack {
                    Image("logo-bg")
                        .frame(width: 180, height: 20)
                        .padding(.bottom, 25)
                    VStack(spacing: -2) {
                        
                        HStack(spacing: 1) {
                            Text("CASE")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Image("logo-gran")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("BATTLE")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Text("У НАС ВЫИГРЫВАЮТ")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                }
                .onTapGesture {
                    if viewModel.mainScreen != true {
                        viewModel.mainScreen = true
                        viewModel.openCasingScreen = false
                        viewModel.openingCase = false
                        viewModel.openingFastCase = false
                        viewModel.showWinnerSkin = false
                        viewModel.headerMenuList = false
                        viewModel.topUpMenu = false
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "person.3.fill")
                        .foregroundColor(.green)
                    Text(String(onlineQuantity))
                        .padding(.trailing, 10)
                        .foregroundColor(.green)
                    Image(systemName: menuList ? "xmark" : "list.bullet" )
                        .resizable()
                        .frame(width: menuList ? 20 : 25, height: 20)
                        .fontWeight(.bold)
                        .padding(.trailing, 10)
                        .foregroundColor(.middlePriceOrange)
                        .onTapGesture {
                            menuList = menuList ?  false : true
                        }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 50)
            .background(Color.firstDarkBlue)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .padding(.bottom, -20)
        }
    }
}

struct SecondHeader: View {
    @EnvironmentObject var viewModel: InfoList
    @State private var currentPromo: Promocode?
    
    var body: some View {
        HStack{
            HStack(alignment: .center, spacing: 80) {
                VStack {
                    Text("+\(currentPromo?.percent ?? 0)%")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text("НА СЧЕТ")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                }
                .background(CircleBG())
                
                VStack {
                    Text("ИСПОЛЬЗУЙ ПРОМОКОД:")
                        .frame(width: 200)
                        .font(.system(size: 15))
                        .foregroundColor(.lightBluePromo)
                        .fontWeight(.bold)
                        .rotationEffect(.degrees(-3.0))
                        .padding(.bottom, -10)
                    
                    ZStack {
                        Image("promo_trapezoid")
                            .resizable()
                            .frame(width: 200, height: 45)
                        
                        Text("\(currentPromo?.promo.uppercased() ?? "")-\(currentPromo?.percent ?? 0)")
                            .foregroundColor(.white)
                            .padding(.top, 4)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .underline()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 105)
            .background(DotsBG())
            .background(LinearGradient(gradient: Gradient(colors: [Color.firstDarkBlue, Color.darkBlue, Color.firstDarkBlue]), startPoint: .leading, endPoint: .trailing))
        }
        .background(Color.firstDarkBlue)
        .onAppear {
            updateCurrentPromo()
        }
        .onReceive(Timer.publish(every: 60, on: .main, in: .common).autoconnect()) { _ in
            updateCurrentPromo()
        }
    }
    
    private func updateCurrentPromo() {
        let now = Date()
        currentPromo = viewModel.promocodes.first { promo in
            promo.startTime <= now && promo.endTime >= now
        }
    }
}

struct CircleBG: View {
    var body: some View {
        VStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.firstPromoOrange, Color.lastPromoOrange]), startPoint: .leading, endPoint: .trailing))
                .frame(width: 65, height: 65, alignment: .center)
        }
    }
}

struct DotsBG: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                ForEach(0..<13) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<100) { column in
                            Image("promo-dots")
                        }
                    }
                }
            }
        }
    }
}

