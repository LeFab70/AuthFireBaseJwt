//
//  SettingsRowView.swift
//  AuthFireBaseJwt
//
//  Created by Fabrice Kouonang on 2025-07-06.
//

import SwiftUI

struct SettingsRowView: View {
    let text: String
    let image: Image
    let version: String
    let tintColor: Color
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                image
                    .imageScale(.small)
                    .foregroundColor(tintColor)
                    .font(.title)
                Text(text)
                    .font(.caption)
                Spacer()
                if(!version.isEmpty)
                {
                    Text("\(version)")
                }
            }.padding(.horizontal)
        }
    }
}

#Preview {
    SettingsRowView(text: "text", image: (Image(systemName: "folder")),version: "1.0.0", tintColor: .blue)
}
