//
//  ErrorView.swift
//  LoginApp
//
//  Created by Ahmet Bostancıklıoğlu on 20.01.2025.
//

import SwiftUI

struct ErrorView: View {
    @State var color = Color.black.opacity(0.7)
    @Binding var alert: Bool
    @Binding var error: String
    
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                HStack {
                    Text(self.error == "RESET" ? "Message" : "")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundStyle(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                Button {
                    self.alert.toggle()
                } label: {
                    Text(self.error == "RESET" ? "Ok" : "Cancel")
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(.yellow)
                .cornerRadius(10)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(.white)
            .cornerRadius(15)
        }
        .padding(.top, 250)
        .padding(.horizontal, 35)
        .background(Color.black.opacity(0.35).ignoresSafeArea(.all))
        
    }
}


