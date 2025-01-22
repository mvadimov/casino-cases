import SwiftUI
import SwiftData

struct TopupMoneyView: View {
    @EnvironmentObject var viewModel: InfoList
    @State private var cryptoList: [CryptoList] = [
        CryptoList(isSelected: true, nameOfCoin: "USDT (TRC20)", shortNameOfCoin: "USDT", nameOfCurrency: "CryptoP", imageOfCoin: "usdt-trc20", exchangeRate: 1, minimalSum: 1),
        CryptoList(isSelected: false, nameOfCoin: "TRON", shortNameOfCoin: "TRX", nameOfCurrency: "CryptoP", imageOfCoin: "tron", exchangeRate: 0.12519, minimalSum: 1),
        CryptoList(isSelected: false, nameOfCoin: "USDT (ERC20)", shortNameOfCoin: "USDT", nameOfCurrency: "CryptoP", imageOfCoin: "usdt-erc20", exchangeRate: 1, minimalSum: 1),
        CryptoList(isSelected: false, nameOfCoin: "Toncoin", shortNameOfCoin: "TON", nameOfCurrency: "CryptoP", imageOfCoin: "ton", exchangeRate: 6.812, minimalSum: 0.06),
        CryptoList(isSelected: false, nameOfCoin: "Bitcoin", shortNameOfCoin: "₿", nameOfCurrency: "CryptoP", imageOfCoin: "btc", exchangeRate: 61350, minimalSum: 0.000001),
        CryptoList(isSelected: false, nameOfCoin: "Ethereum", shortNameOfCoin: "ETH", nameOfCurrency: "CryptoP", imageOfCoin: "eth", exchangeRate: 0.00005, minimalSum: 2888)
    ]
    
    @State private var cardList: [CardList] = [
        CardList(id: 1, isSelected: true, isP2P: true, isNew: false, fstImage: "mir_visa_mc", secImage: "", valueText: "", nameOfCurrency: "Nicepay", symbolOfValue: "₽", text: "П2П оплата для РФ карт. Не создавайте заявки без оплаты иначе метод будет временно заблокирован.", minimalSum: 500, exchangeRate: 1),
        CardList(id: 2, isSelected: false, isP2P: true, isNew: true, fstImage: "mir_visa_mc", secImage: "", valueText: "", nameOfCurrency: "24CardPay", symbolOfValue: "₽", text: "П2П оплата для РФ карт. Не создавайте заявки без оплаты иначе метод будет временно заблокирован.", minimalSum: 1500, exchangeRate: 1),
        CardList(id: 3, isSelected: false, isP2P: false, isNew: false, fstImage: "visa_mc", secImage: "kz", valueText: "KZT", nameOfCurrency: "GM", symbolOfValue: "₸", text: "Этот способ оплаты подходит для всех карт Казахстана, кроме \"Kaspi Bank\".", minimalSum: 1000, exchangeRate: 0.21),
        CardList(id: 4, isSelected: false, isP2P: false, isNew: false, fstImage: "visa_mc", secImage: "kz", valueText: "KZT", nameOfCurrency: "Palych", symbolOfValue: "₽", text: "Этот способ оплаты подходит для всех карт Казахстана.", minimalSum: 200, exchangeRate: 1),
        CardList(id: 5, isSelected: false, isP2P: false, isNew: false, fstImage: "visa_mc", secImage: "kz", valueText: "KZT", nameOfCurrency: "PayServ", symbolOfValue: "₸", text: "Этот способ оплаты подходит для всех карт Казахстана. Не создавайте заявки без оплаты иначе метод будет временно заблокирован.", minimalSum: 2000, exchangeRate: 0.21),
        CardList(id: 6, isSelected: false, isP2P: false, isNew: false, fstImage: "visa_mc", secImage: "kz", valueText: "UAH", nameOfCurrency: "PayServ", symbolOfValue: "₴", text: "Этот способ оплаты подходит только для карт Украины. Не создавайте заявки без оплаты иначе метод будет временно заблокирован.", minimalSum: 3000, exchangeRate: 2.3),
    ]
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var payments = [1 : true, 2 : false, 3 : false, 4 : false]
    @State var selectedCard = CardList?.self
    @State var selectedCrypto = CryptoList?.self
    @State private var quantityOfTopUp = ""
    @State private var promoInput = ""
    
    
    
    var body: some View {
        var minSum: Double = minSumPayment()
        var symbolOf = symbolInPayment()
        VStack{
            ScrollView{
                VStack(spacing: -2){
                    HStack{
                        HStack{
                            Image("wallet")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("ПОПОЛНЕНИЕ БАЛАНСА")
                                .font(.system(size: 18))
                                .foregroundStyle(Color.white)
                                .fontWeight(.medium)
                        }
                        .padding(.leading, 20)
                        Spacer()
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.quantityGray)
                            .padding(.trailing, 15)
                            .onTapGesture{
                                viewModel.topUpMenu = false
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .background(Color.firstDarkBlue)
                    .padding(.bottom, 1)
                    .background(Color.secMainBlue)
                    .padding(.bottom, 20)
                    
                    HStack(spacing: -2){
                        
                        //MARK: first
                        HStack{
                            Image("visa_mc")
                                .resizable()
                                .frame(width: 67.5, height: 20)
                            
                            Image("mir")
                                .resizable()
                                .frame(width: 62, height: 20)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 25)
                        .background(find() == 1 ? Color.darkBlue : Color.mainPaymentBlue)
                        .padding(find() == 1 ? 0 : 1)
                        .padding(.bottom, find() == 1 ? 5 : 0)
                        .background(find() == 1 ? Color.middlePriceOrange : Color.secMainBlue)
                        .onTapGesture {
                            delete()
                            payments[1] = true
                        }
                        
                        //MARK: second
                        HStack{
                            Image("sbp_p2p_ymoney_fk")
                                .resizable()
                                .frame(width: 132.5, height: 50)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(find() == 2 ? Color.darkBlue : Color.mainPaymentBlue)
                                .padding(find() == 2 ? 0 : 1)
                                .padding(.bottom, find() == 2 ? 5 : 0)
                                .background(find() == 2 ? Color.middlePriceOrange : Color.secMainBlue)
                        }
                        .onTapGesture {
                            delete()
                            payments[2] = true
                        }
                    }
                    
                    HStack(spacing: -2){
                        
                        //MARK: third
                        HStack{
                            Text("КРИПТА")
                                .foregroundStyle(Color.quantityGray)
                                .font(.system(size: 20))
                                .padding(.horizontal, 50)
                                .padding(.vertical, 25)
                                .background(find() == 3 ? Color.darkBlue : Color.mainPaymentBlue)
                                .padding(find() == 3 ? 0 : 1)
                                .padding(.bottom, find() == 3 ? 5 : 0)
                                .background(find() == 3 ? Color.middlePriceOrange : Color.secMainBlue)
                        }
                        .onTapGesture {
                            delete()
                            payments[3] = true
                        }
                        //MARK: fourth
                        HStack{
                            Text("СКИНЫ")
                                .foregroundStyle(Color.quantityGray)
                                .font(.system(size: 20))
                                .padding(.horizontal, 50)
                                .padding(.vertical, 25)
                                .background(find() == 4 ? Color.darkBlue : Color.mainPaymentBlue)
                                .padding(find() == 4 ? 0 : 1)
                                .padding(.bottom, find() == 4 ? 5 : 0)
                                .background(find() == 4 ? Color.middlePriceOrange : Color.secMainBlue)
                        }
                        .onTapGesture {
                            delete()
                            payments[4] = true
                        }
                    }
                }
                
                Text("Выберите способ оплаты: ")
                    .padding(.trailing, 100)
                    .font(.system(size: 20))
                    .foregroundStyle(Color.white)
                    .fontWeight(.medium)
                    .padding(.top, 20)
                
                VStack{
                    switch find(){
                    case 1:
                        LazyVGrid(columns: columns){
                            ForEach($cardList){ card in
                                CardPayment(cardp: card, selectCard: { selectedCard in
                                    selectCard(selectedCard: selectedCard)
                                })
                            }
                            
                        }
                        .padding(.horizontal, 20)
                        
                    case 2:
                        SpbPayment()
                            .frame(width: UIScreen.main.bounds.width)
                            .padding(.bottom, 20)
                            .background(Color.firstDarkBlue)
                            .padding(.bottom, 1)
                            .background(Color.secMainBlue)
                    case 3:
                        LazyVGrid(columns: columns){
                            ForEach($cryptoList){ coin in
                                CryptoPayment(cryptop: coin, selectCrypto: { selectedCrypto in
                                    selectCrypto(selectedCrypto: selectedCrypto)
                                })
                                
                            }
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        .background(Color.firstDarkBlue)
                        .padding(.bottom, 1)
                        .background(Color.secMainBlue)
                    case 4:
                        SkinifyPayment()
                            .frame(width: UIScreen.main.bounds.width)
                            .padding(.bottom, 20)
                            .background(Color.firstDarkBlue)
                            .padding(.bottom, 1)
                            .background(Color.secMainBlue)
                    default: EmptyView()
                    }
                }
                //MARK: TOP UP
                
                VStack(spacing: 20){
                    HStack(spacing: 10){
                        VStack(alignment: .leading){
                            Text("Сумма: ")
                                .font(.system(size: 17))
                                .foregroundStyle(Color.white)
                            Text("Мин. \(String(minSum)) \(symbolOf)")
                                .font(.system(size: 15))
                                .foregroundStyle(Color.quantityGray)
                        }
                        .frame(width: 120)
                        ZStack{
                            TextField("", text: $quantityOfTopUp)
                                .frame(width: 200, height: 40)
                                .padding(.horizontal, 10)
                                .background(Color.mainPaymentBlue)
                                .foregroundStyle(Color.white)
                            Text("\(symbolOf)")
                                .font(.system(size: 20))
                                .foregroundStyle(Color.paymentGray)
                                .offset(x: 80)
                        }
                    }
                    
                    HStack(spacing: 10){
                        VStack(alignment: .leading){
                            Text("Промокод: ")
                                .font(.system(size: 17))
                                .foregroundStyle(Color.white)
                            Text("(если есть)")
                                .font(.system(size: 15))
                                .foregroundStyle(Color.white)
                        }
                        .frame(width: 120)
                        ZStack{
                            TextField("", text: $promoInput)
                                .frame(width: 200, height: 40)
                                .padding(.horizontal, 10)
                                .background(Color.mainPaymentBlue)
                                .foregroundStyle(Color.white)
                            
                            Image("percentPayment")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .offset(x: 80)
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                
                VStack(spacing: 15){
                    Text("ПОПОЛНИТЬ СЧЕТ")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 100)
                        .background(Color.firstPromoOrange)
                        .onTapGesture{
                            switch find(){
                            case 1:
                                if let selectedCard = cardList.first(where: { $0.isSelected }) {
                                    viewModel.moneyQuantity += selectedCard.exchangeRate * Double(quantityOfTopUp)!
                                }

                            case 3:
                                if let selectedCrypto = cryptoList.first(where: { $0.isSelected }) {
                                    viewModel.moneyQuantity += selectedCrypto.exchangeRate * viewModel.usdToRub * Double(quantityOfTopUp)!
                                }
                                
                            default:
                                viewModel.moneyQuantity += Double(quantityOfTopUp)!
                            }
                            print(viewModel.moneyQuantity)
                            quantityOfTopUp = ""
                            promoInput = ""
                            viewModel.mainScreen = true
                            viewModel.openCasingScreen = false
                            viewModel.openingCase = false
                            viewModel.openingFastCase = false
                            viewModel.showWinnerSkin = false
                            viewModel.headerMenuList = false
                            viewModel.topUpMenu = false
                        }
                    Text("Если после оплаты прошло более 30 минут, а баланс на сайте не пополнился, то напишите нам в техподдержку.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.quantityGray)
                        .fontWeight(.medium)
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.firstDarkBlue)
        }
    }
    
    func delete(){
        for key in payments.keys {
            payments[key] = false
        }
    }
    
    func find() -> Int{
        if let key = payments.first(where: {$0.value == true})?.key{
            return key
        }
        else {
            return 1
        }
    }
    
    func selectCrypto(selectedCrypto: CryptoList) {
        for index in cryptoList.indices {cryptoList[index].isSelected = (cryptoList[index].id == selectedCrypto.id)}
    }
    
    func selectCard(selectedCard: CardList) {
        for index in cardList.indices {cardList[index].isSelected = (cardList[index].id == selectedCard.id)}
    }
    
    func minSumPayment() -> Double {
        var mip: Double = 0
        switch find(){
        case 1:
            if let selectedCard = cardList.first(where: { $0.isSelected }) {
                 mip = selectedCard.minimalSum
            }
            
        case 3:
            if let selectedCrypto = cryptoList.first(where: { $0.isSelected }) {
                 mip = selectedCrypto.minimalSum
            }
        default:
            mip = 50
        }
        return mip
    }
    
    func symbolInPayment() -> String {
        var sip = ""
        switch find(){
        case 1:
            if let selectedCard = cardList.first(where: { $0.isSelected }) {
                 sip = selectedCard.symbolOfValue
            }
            
        case 3:
            if let selectedCrypto = cryptoList.first(where: { $0.isSelected }) {
                 sip = selectedCrypto.shortNameOfCoin
            }
        default:
            sip = "₽"
        }
        return sip
    }
}
struct CryptoPayment: View {
    @Binding var cryptop: CryptoList
    var selectCrypto: (CryptoList) -> Void
    var body: some View {
        VStack(spacing: 3) {
            Image(cryptop.imageOfCoin)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.bottom, 3)
            Text(cryptop.nameOfCoin)
                .font(.system(size: 15))
                .foregroundStyle(Color.white)
                .fontWeight(.medium)
            Text(cryptop.nameOfCurrency)
                .font(.system(size: 14))
                .foregroundStyle(Color.gray)
                .fontWeight(.medium)
        }
        .frame(width: 130, height: 100)
        .onTapGesture {
            selectCrypto(cryptop)
        }
        .background(cryptop.isSelected ? Color.darkBlue : Color.mainPaymentBlue)
        .padding(1)
        .background(cryptop.isSelected ? Color.middlePriceOrange : Color.secMainBlue)
    }
}

struct SpbPayment: View {
    var body: some View {
        VStack(spacing: 3) {
            Image("fkwallet")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.bottom, 3)
            Text("FKwallet")
                .font(.system(size: 15))
                .foregroundStyle(Color.white)
                .fontWeight(.medium)
            Text("FK2")
                .font(.system(size: 14))
                .foregroundStyle(Color.gray)
                .fontWeight(.medium)
        }
        .frame(width: 130, height: 100)
        .background(Color.darkBlue)
        .padding(1)
        .background(Color.middlePriceOrange)
    }
}

struct SkinifyPayment: View {
    var body: some View {
        VStack(spacing: 3) {
            Image("skinify")
                .resizable()
                .frame(width: 75, height: 30)
                .padding(.top, 30)
            Spacer()
            Text("Skinify")
                .font(.system(size: 14))
                .foregroundStyle(Color.gray)
                .fontWeight(.medium)
                .padding(.bottom, 10)
        }
        .frame(width: 130, height: 100)
        .background(Color.darkBlue)
        .padding(1)
        .background(Color.middlePriceOrange)
    }
}

struct CardPayment: View {
    @Binding var cardp: CardList
    var selectCard: (CardList) -> Void
    var body: some View {
        ZStack {
            VStack(spacing: 3) {
                Image(cardp.fstImage)
                    .resizable()
                    .frame(width: cardp.secImage != "" ? 90 : 90, height: cardp.secImage != "" ? 20 : 50)
                    .padding(.bottom, 3)
                HStack {
                    if cardp.secImage != "" {
                        Image(cardp.secImage)
                            .resizable()
                            .frame(width: 25, height: 17)
                    }
                    
                    if cardp.valueText != "" {
                        Text(cardp.valueText)
                            .font(.system(size: 17))
                            .foregroundStyle(Color.white)
                            .fontWeight(.medium)
                    }
                }
                
                Text(cardp.nameOfCurrency)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray)
                    .fontWeight(.medium)
            }
            .frame(width: 130, height: 100)
            .background(cardp.isSelected ? Color.darkBlue : Color.mainPaymentBlue)
            .padding(1)
            .background(cardp.isSelected ? Color.middlePriceOrange : Color.secMainBlue)
            
            if cardp.isP2P {
                Text("п2п")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.white)
                    .padding(4)
                    .background(Color.thirdMainBlue)
                    .cornerRadius(4)
                    .offset(x: -57, y: -47)
            }
            
            if cardp.isNew {
                Text("NEW")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.white)
                    .padding(4)
                    .background(Color.red)
                    .offset(x: 57, y: -47)
            }
        }
        .onTapGesture {
            selectCard(cardp)
        }
    }
}


#Preview {
    TopupMoneyView().environmentObject(InfoList())
}
