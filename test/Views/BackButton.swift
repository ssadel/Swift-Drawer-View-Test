//
//  CancelButton.swift
//  test
//
//  Created by Sidney Sadel on 5/4/23.
//

import SwiftUI

struct BackButton: View {

    var action:(()->())? = nil
    
    var body: some View {
        
        Button {
            if let action = action {
                action()
            }
        } label: {
            Text("Back")
                .font(.subheadline.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(10)
                .background(Capsule(style: .continuous).foregroundColor(.gray.opacity(0.14)))
                .padding(.horizontal)
        }
        .buttonStyle(InteractiveButtonStyle())
        
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
