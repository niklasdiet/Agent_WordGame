//
//  Main Menu.swift
//  Agent
//
//  Created by Niklas Diet on 20.10.23.
//

import SwiftUI

struct StartScreenView: View {
    
    @State private var isActive: Bool = false
    @State private var isPulsating = false
    
    let pulseDuration: TimeInterval = 2.0 // Set the pulse duration (2 seconds in this case)
    
    // Define the URLs for the imprint and data protection
    let imprintURL = URL(string: "https://agent-word-game.webflow.io#impressum")!
    let dataProtectionURL = URL(string: "https://agent-word-game.webflow.io#entwickler")!

    let randomImageNumber = Int.random(in: 1...13)

    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("Background\(randomImageNumber)") // Replace "YourBackgroundImageName" with the name of your background image asset
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1.0),Color.black.opacity(0.35)]), startPoint: .bottom, endPoint: .center)
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        // Info button in the upper left corner
                        Button(action: {
                            // Add your action for the info button here
                            // For example, you can show a modal with information
                            // when this button is tapped.
                        }) {
                            Image(systemName: "info.circle")
                                .font(.system(size: 28))
                                .foregroundColor(Color("Accent")) // Adjust the color as needed
                        }
                        Spacer()
                        
                        // Start button with pulse animation and navigation link
                        NavigationLink(destination: Screen2View(rootIsActive: self.$isActive), isActive: self.$isActive) {
                            Text("Start")
                                .frame(width: 140)
                                .font(.headline)
                                .foregroundColor(Color("BackgroundColor"))
                                .padding()
                                .background(Color("Accent")) // Change the background color as needed
                                .cornerRadius(7)


                        }
                        Spacer()
                        
                        // Imprint button with external link
                        Button(action: {
                            UIApplication.shared.open(imprintURL)
                        }) {
                            Text("Imprint")
                                .font(.system(size: 14)) // Smaller font size
                                .foregroundColor(Color.gray) // Grey text
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 50)
                }
            }
            .navigationBarHidden(true)
        }
        .accentColor(Color("Accent")) // Set the desired button color

    }

}
