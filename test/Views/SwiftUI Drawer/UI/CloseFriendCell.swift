//
//  CloseFriendCell.swift
//  test
//
//  Created by Sidney Sadel on 5/7/23.
//

import SwiftUI

struct CloseFriendCell: View {
    var body: some View {
        
        Button {
            //
        } label: {
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray.opacity(0.4))
                VStack(alignment: .leading) {
                    Text("Sid")
                    Text("@drake")
                        .foregroundColor(.gray.opacity(0.9))
                }
                .font(.footnote.weight(.medium))
                Spacer()
                Button {
                    //
                } label: {
                    Text("Add")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 5)
                        .background(Capsule(style: .continuous).foregroundColor(.purple))
                }
                .buttonStyle(InteractiveButtonStyle())
            }
            .padding(.horizontal)
            .contentShape(Rectangle())
        }
        .buttonStyle(InteractiveButtonStyle())
    }
}

struct CloseFriendCell_Previews: PreviewProvider {
    static var previews: some View {
        CloseFriendCell()
    }
}
