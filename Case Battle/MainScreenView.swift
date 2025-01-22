import SwiftUI
import SwiftData

struct MainScreenView: View {
    @EnvironmentObject var viewModel: InfoList
    var body: some View {
        ZStack{
            
            VStack {
                FirstHeader(menuList: $viewModel.headerMenuList)
                ZStack{
                    
                    ScrollView {
                        SecondHeader()
                            .padding(.bottom, -10)
                        CasesView()
                    }
                    
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

#Preview {
    MainScreenView().environmentObject(InfoList())
}

