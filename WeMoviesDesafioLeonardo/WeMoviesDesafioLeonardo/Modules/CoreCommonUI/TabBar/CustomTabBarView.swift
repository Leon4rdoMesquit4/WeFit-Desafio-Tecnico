//
//  CustomTab.swift
//  WeMoviesDesafioLeonardo
//
//  Created by Leonardo Mesquita Alves on 26/04/25.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: CustomTab
    var numsOfMovies: Int
    @State private var animatingTab: CustomTab? = nil
    @Namespace private var animation
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(CustomTab.allCases, id: \.rawValue) { tab in
                    customTabBarItem(tab: tab)
                }
            }
            .frame(maxWidth: .infinity)
            .background {
                Color.backgroundTertiary.ignoresSafeArea()
            }
        }
    }
}

extension CustomTabBarView {
    @ViewBuilder
    func customTabBarItem(tab: CustomTab) -> some View {
        label(tab: tab)
        .padding(16)
        .onTapGesture {
            if tab.isEnabled && tab != .profile {
                selectedTab = tab
                animate(tab: tab)
            }
        }
        .overlay {
            if selectedTab == tab {
                selectedGradient
                .matchedGeometryEffect(id: "upperline", in: animation)
            }
        }
        .opacity(opacity(for: tab))
        .animation(.easeInOut(duration: 0.3), value: animatingTab)
        if tab != .profile {
            Spacer()
        }
    }
    
    @ViewBuilder
    func label(tab: CustomTab) -> some View {
        HStack {
            Image(tab.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
            Text(formmattedText(tab))
                .font(.openSansRegular(size: 14))
                .lineLimit(1)
        }
        .foregroundStyle(.white)
    }
    
    var selectedGradient: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundStyle(.white)
                .frame(height: 2)
            LinearGradient(
                colors: [.white.opacity(0.12), .white.opacity(0)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

extension CustomTabBarView {
    private func opacity(for tab: CustomTab) -> Double {
        if tab.isEnabled == false {
            return 0.5
        } else if animatingTab == tab {
            return 0.0
        } else {
            return 1.0
        }
    }
    
    private func animate(tab: CustomTab) {
        animatingTab = tab
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            animatingTab = nil
        }
    }
    
    private func formmattedText(_ tab: CustomTab) -> String {
        if tab == .cart && numsOfMovies != 0 {
            return "\(tab.title) (\(numsOfMovies))"
        } else {
            return tab.title
        }
    }
}
