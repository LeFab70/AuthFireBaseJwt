//
//  InputView.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecure: Bool=false
    var body: some View {
        //Creer le standard de nos inputs
        VStack(alignment: .leading,spacing:12) {
            Text(title)
                .foregroundStyle(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "input user", placeholder: "Input user")
}
