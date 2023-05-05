//
//  DrawerCell.swift
//  test
//
//  Created by Sidney Sadel on 5/3/23.
//

import SwiftUI

struct DrawerCell: View {
    
    var text:String
    var action:(()->())? = nil
    var foregroundColor:Color = .primary
    
    var body: some View {
        
        Button {
            if let action = action {
                action()
            }
        } label: {
            Text(text)
                .foregroundColor(foregroundColor)
                .font(.subheadline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 18, style: .continuous).foregroundColor(.gray.opacity(0.075)))
                .padding(.horizontal)
        }
        .buttonStyle(InteractiveButtonStyle())
        
    }
}

struct DrawerCell_Previews: PreviewProvider {
    static var previews: some View {
        DrawerCell(text: "Edit Name")
    }
}


struct InteractiveButtonStyle: ButtonStyle {
    @State private var isPressed: Bool = false
    @State private var isLongPress: Bool = false
    @State private var timer: Timer?

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.12), value: isPressed)
            .onChange(of: configuration.isPressed) { newValue in
                if newValue {
                    withAnimation {
                        isPressed = true
                    }
                    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                        isLongPress = true
                    }
                } else {
                    timer?.invalidate()
                    if !isLongPress {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                            withAnimation {
                                isPressed = false
                            }
                        }
                    } else {
                        withAnimation {
                            isPressed = false
                        }
                    }
                    isLongPress = false
                }
            }
    }
}
