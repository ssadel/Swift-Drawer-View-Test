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
    
    var body: some View {
        
        Button {
            if let action = action {
                action()
            }
        } label: {
            Text(text)
                .font(.headline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 18, style: .continuous).foregroundColor(.gray.opacity(0.1)))
                .padding(.horizontal)
        }
        .buttonStyle(InteractiveButtonStyle())
        .disabled(true)
    }
}

struct DrawerCell_Previews: PreviewProvider {
    static var previews: some View {
        DrawerCell(text: "Edit Name")
    }
}

struct InteractiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .contentShape(RoundedRectangle(cornerRadius: 10))
            .animation(.easeIn(duration: 0.12), value: configuration.isPressed)
    }
}
