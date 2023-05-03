//
//  DrawerView.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value ?? nextValue()
    }
}

struct DrawerView: View {
    
    let cells:[String] = ["Edit Name", "Edit Bio", "Change Profile Image", "Close Friend", "Emoji Skin Tone", "Status Settings", "Account"]
    
    var body: some View {
        
        VStack {
            RoundedRectangle(cornerRadius: 6)
                .frame(width: 32, height: 3.5)
                .foregroundColor(.gray.opacity(0.3))
                .padding(.top, 15)
                .padding(.bottom, 10)
            
            ForEach(cells, id: \.self) { text in
                DrawerCell(text: text) {
                    print("tapped")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.5), radius: 8)
                    .padding(.bottom, -20)
                    .preference(key: ViewHeightKey.self, value: proxy.size.height)
            }
        )
        .padding(.bottom)
        .padding(.horizontal, 10)
        
    }
}

struct DrawerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerView()
    }
}
