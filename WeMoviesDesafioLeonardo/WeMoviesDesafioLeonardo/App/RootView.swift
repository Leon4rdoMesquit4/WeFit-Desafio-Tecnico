//
//  ContentView.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 25/04/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var storage: MovieStorageManager = .init()
    @State var selectedTab: CustomTab = .home
    @State var isLoading: Bool = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack {
            background
            VStack(spacing: 0) {
                header
                tabview
                    .overlay {
                        if isLoading {
                            loader
                        }
                    }
                Spacer()
            }
            if !isLoading {
                tabbar
            }
        }.onAppear {
            reloadData()
        }
    }
}

extension RootView {
    var background: some View {
        Color
            .backgroundPrimary
            .ignoresSafeArea()
    }
    var header: some View {
        HeaderView()
    }
    var loader: some View {
        ZStack {
            background
            VStack {
                LoadView()
                    .padding(.top, 34)
                Spacer()
            }
        }
    }
    var tabview: some View {
        TabView(selection: $selectedTab) {
            ForEach(CustomTab.allCases, id: \.rawValue) { tab in
                ZStack {
                    switch tab {
                    case .home:
                        HomeView(
                            viewModel: HomeViewModel(
                                storage: storage
                            ),
                            reloadAction: {
                                reloadData()
                            }
                        )
                    case .cart:
                        CartView(
                            viewModel: CartViewModel(
                                storage: storage
                            ),
                            moveTabAction: {
                                moveTab(.home)
                            }
                        )
                    case .profile:
                        EmptyView()
                    }
                }
                .tag(tab)
            }
        }
    }
    var tabbar: some View {
        CustomTabBarView(selectedTab: $selectedTab, numsOfMovies: storage.totalQuantity)
    }
}

extension RootView {
    func moveTab(_ tab: CustomTab) {
        selectedTab = tab
    }
    func reloadData() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }
}

#Preview {
    RootView()
}
