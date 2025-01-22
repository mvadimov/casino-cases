//
//  StartView.swift
//  Case Battle
//
//  Created by Mark Vadimov on 24.04.24.
//

import SwiftUI
import SwiftData

struct StartView: View {
    @EnvironmentObject var viewModel: InfoList

    var body: some View {
        if viewModel.mainScreen {
            MainScreenView()
        }
        else if viewModel.openCasingScreen {
            OpenCaseView(ccase: $viewModel.selectedCase)
        }
        else {
            MainScreenView()
        }
    }
}

#Preview {
    StartView().environmentObject(InfoList())
}
