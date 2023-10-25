//
//  ContentView.swift
//  Agent
//
//  Created by Niklas Diet on 29.09.23.
//


import SwiftUI
import CoreData

var itemLists: [[String]] = []
var players: [String] = []
var playerCount = 1
var agentsCount = 1


let spots = ["Spaceshuttle","Library","Beach","Cinema","Mountain Peak","Church","Supermarket","Park","Restaurant","Hospital","Gym","School","Airport","Museum","Theater","Playground","Café","Zoo","Marketplace","Lake","Desert","Farm","Temple","Hair Salon","Subway Station","Office","Mountain Pass","Bookstore","Swimming Pool","Island","Ski Resort","Botanical Garden","Port","Factory","Living Room","Bedroom","Kitchen","Bathroom","Garage","Balcony","Roof Terrace","Mountain Lake","Waterfall","Forest","Desert Oasis","Ancient Theater","Shopping Mall","Travel Agency","Prison","Lighthouse","Circus","Water Cave","Skatepark","Castle","Cemetery","Stratosphere","Planetarium","Carnival","Brewery","Aquarium","Mine","Coral Reef","Mountain Range","River","Beach House","Amusement Park","City Square","Water Park","Campground","Art Gallery","Concert Hall","Botanical Garden","Lighthouse","Shopping Center","Hotel","Spa","Airport Terminal","Subway","Bus Station","Train Station","Beach Resort","Amphitheater","Waterfront","Bridge","National Park","Farmhouse","Observatory","Windmill","Ski Lodge","Jungle","Volcano","Cave","Castle Ruins","Hot Springs","Theme Park","Race Track","Waterfront Restaurant","Skyscraper","Historic Site","Village","Mountain Hut","Wildlife Sanctuary","Science Museum","Fishing Pier","Botanical Park","Cruise Ship","Arcade","Roller Coaster","Waterfront Promenade","Farmers' Market","Underwater Cave","Reservoir"]



struct Screen2View: View {
    @Binding var rootIsActive: Bool
    
    @State private var refreshToggle = false
    @State private var playerName = ""
    @State private var startGameFlag = false // Add @State for navigation flag
    @State private var imageCount = 1

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image and Gradient
                Color(.black)
                    .edgesIgnoringSafeArea(.all)

                Image("Person\(imageCount)")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.height,  height: UIScreen.main.bounds.height)
                    .position(x: UIScreen.main.bounds.height/UIScreen.main.bounds.height-UIScreen.main.bounds.height/8, y: UIScreen.main.bounds.height / 2)
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity) // Apply opacity transition

                
               /* Image("Ink")
                    .frame(width: UIScreen.main.bounds.height,  height: UIScreen.main.bounds.height)
                    .position(x: UIScreen.main.bounds.height/3, y: UIScreen.main.bounds.height / 1.5)
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                */
                
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.65), Color.black.opacity(0.45), Color.black.opacity(0.9), Color.black.opacity(1.0),Color.black.opacity(1.0), Color.gray.opacity(0.05), Color.gray.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                    .edgesIgnoringSafeArea(.all)

                
                HStack{
                    Spacer()

                    Rectangle()
                        .fill(Color.black.opacity(0.0))
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height)
                        .overlay(
                            VStack {
                                
                                Spacer()
                                Text("Add Player \(playerCount)")
                                    .font(.largeTitle).bold()
                                    .foregroundColor(Color("Accent"))
                                
                                Spacer()

                                HStack(spacing: 25) {
                                    // Player Name Input
                                    TextField("Name", text: $playerName)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)) // Add padding to create space for the line
                                        .overlay(Rectangle().frame(height: 1).foregroundColor(Color("Accent")).padding(.top, 8), alignment: .bottom) // Add a bottom border
                                        .frame(width: 220)
                                        .foregroundColor(Color("Accent")) // Text color
                                    
                                    if playerCount < 15 {
                                        // Add Person button
                                        Button(action: {
                                            if playerName != "" {
                                                withAnimation {
                                                    players.append(playerName)
                                                    playerCount = playerCount + 1
                                                    playerName = ""
                                                    if imageCount == 8 {
                                                        imageCount = 1
                                                    } else {
                                                        imageCount+=1
                                                    }
                                                }
                                            }
                                        }) {
                                            Image(systemName: "person.fill.badge.plus")
                                                .foregroundColor(Color.black) // Set the text color to gray
                                                .frame(width: 40, height: 40) // 40% of the screen width
                                                .background(Color("Accent"))
                                                .cornerRadius(7) // Round the corners
                                        }
                                        .disabled(false) // Enable the button
                                    } else {
                                        Button(action: {}) { // Empty action for the disabled button
                                            Image(systemName: "person.fill.badge.plus")
                                                .foregroundColor(Color.black) // Set the text color to gray
                                                .padding()
                                                .frame(width: 40, height: 40) // 40% of the screen width
                                                .background(Color.gray) // Set the button background to gray
                                                .cornerRadius(7) // Round the corners
                                        }
                                        .disabled(true) // Disable the button
                                    }
                                }
                                    
                                Spacer()

                                // Buttons and text fields container
                                HStack(spacing: 25) {
                                    // Clear all button
                                    Button(action: {
                                        players = []
                                        playerCount = 1
                                        playerName = ""
                                        agentsCount = 1
                                        imageCount = 1
                                        refreshToggle.toggle()

                                    }) {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(Color.black) // Set the text color to gray
                                            .frame(width: 130, height: 40) // 40% of the screen width
                                            .background(Color.red)
                                            .cornerRadius(7) // Round the corners
                                    }
                                    
                                   
                                    if playerCount > 3 {
                                        Button(action: {
                                            // Handle starting the game
                                            if !playerName.isEmpty {
                                                players.append(playerName)
                                                playerCount = playerCount + 1
                                                playerName = ""
                                            }
                                            addNewWords(allInputWords: spots)
                                            startGameFlag = true // Activate the navigation flag
                                            
                                        }) {
                                            Image(systemName: "play.fill")
                                                .foregroundColor(Color.black) // Set the text color to gray
                                                .frame(width: 130, height: 40) // 40% of the screen width
                                                .background(Color.green)
                                                .cornerRadius(7) // Round the corners
                                        }
                                        .disabled(false) // Enable the button
                                    } else {
                                        Button(action: {}) { // Empty action for the disabled button
                                            Image(systemName: "play.fill")
                                                .foregroundColor(Color.black) // Set the text color to gray
                                                .frame(width: 130, height: 40) // 40% of the screen width
                                                .background(Color.gray) // Set the button background to gray
                                                .cornerRadius(7) // Round the corners
                                        }
                                        .disabled(true) // Disable the button
                                    }
                                }
                                .padding(.horizontal) // Add horizontal padding

                                Spacer()

                                // Use NavigationLink to transition to Screen 3
                                NavigationLink("", destination: Screen3View(shouldPopToRootView: self.$rootIsActive), isActive: $startGameFlag).hidden()
                            }
                            .navigationBarHidden(true) // Hide the navigation bar
                        )
                }

            }
        }
        .id(refreshToggle) // Use .id to trigger a refresh when refreshToggle changes
    }

    // collect all the words and prepare the lists
    func addNewWords(allInputWords: [String]) {
        for word in allInputWords {
            var fullList: [String] = []
            if players.count >= 7 {
                fullList.append("Agent")
                agentsCount = 2
            }
            for _ in 1...players.count - agentsCount {
                fullList.append(word)
            }
            fullList.append("Agent")
            fullList.shuffle()
            itemLists.append(fullList)
        }
        itemLists.shuffle()
    }
}


struct Screen3View: View {
    
    @State private var scale: CGFloat = 1.0
    @Binding var shouldPopToRootView: Bool
    
    
    @State private var backgroundCount = 1
    @State private var currentRound = -1
    @State private var reveal = false
    @State private var playerIndex = 0
    @State private var roundAgent: [String] = []
    @State private var revealEnd = false
    @State private var flipCount = 0 // Track flip count for interactions
    
    let pulseDuration: TimeInterval = 2.0 // Set the pulse duration (2 seconds in this case)

    var body: some View {
        ZStack {
            // Background Image and Gradient
            Color(.black)
                .edgesIgnoringSafeArea(.all)

            Image("Background\(backgroundCount)")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity) // Apply opacity transition

            
           /* Image("Ink")
                .frame(width: UIScreen.main.bounds.height,  height: UIScreen.main.bounds.height)
                .position(x: UIScreen.main.bounds.height/3, y: UIScreen.main.bounds.height / 1.5)
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
            */
            
            
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.4), Color.black.opacity(0.8), Color.black.opacity(0.92), Color.black.opacity(0.92), Color.black.opacity(0.92)]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all)
            if currentRound == -1 {
                HStack{
                    Spacer()
                    Rectangle()
                        .fill(Color.black.opacity(0.0))
                        .frame(width: UIScreen.main.bounds.width * 0.50, height: UIScreen.main.bounds.height)
                        .overlay(
                            VStack {
                                
                                if agentsCount == 1 {
                                    Text("You are \(players.count) players, \(agentsCount) agent is among you.")
                                        .font(.system(size: 32)) // 2 times bigger and bold
                                        .foregroundColor(Color("Text"))
                                        .padding()
                                } else {
                                    Text("You are \(players.count) players, \(agentsCount) agents are among you.")
                                        .font(.system(size: 32)) // 2 times bigger and bold
                                        .foregroundColor(Color("Text"))
                                        .padding()
                                }
                                Text("Click to continue")
                                    .font(.system(size: 13)) // 2 times bigger and bold
                                    .foregroundColor(Color("Text"))
                                    .padding()
                                    
                            }
                        )
                        .onTapGesture {
                            currentRound = 0
                        }
                }

            } else if currentRound < 15 {
                if playerIndex < playerCount - 1 {
                    let itemList = itemLists[currentRound]
                    let role = itemList[playerIndex]
                    let playerName = players[playerIndex]
                    
                    HStack{
                        Spacer()
                        // Create a card with rounded corners
                        Rectangle()
                            .fill(Color.black.opacity(0.0))
                            .frame(width: UIScreen.main.bounds.width * 0.55, height: UIScreen.main.bounds.height)
                            .overlay(
                                VStack {
                                    if flipCount % 2 == 0 {
                                        Image(systemName: "eye.slash.fill")
                                            .font(.system(size: 36))
                                            .foregroundColor(Color.white) // Set the text color to gray
                                            .padding()
                                        Text("\(playerName), reveal your role.")
                                            .font(.system(size: 32)) // 2 times bigger and bold
                                            .foregroundColor(Color("Text"))
                                            .padding()
                                        Text("Click to continue")
                                            .font(.system(size: 13)) // 2 times bigger and bold
                                            .foregroundColor(Color("Text"))
                                            .padding()
                                    } else {
                                        Image(systemName: "eye.fill")
                                            .font(.system(size: 36))
                                            .foregroundColor(Color.white) // Set the text color to gray
                                            .padding()
                                        Text(LocalizedStringKey(role))
                                            .font(.system(size: 32).bold()) // 2 times bigger and bold
                                            .foregroundColor(Color("Text"))
                                            .padding()
                                        Text("Click to continue")
                                            .font(.system(size: 13)) // 2 times bigger and bold
                                            .foregroundColor(Color("Text"))
                                            .padding()
                                    }
                                }
                            )
                            .onTapGesture {
                                if reveal == true {
                                    playerIndex = playerIndex + 1
                                    reveal = false
                                } else {
                                    if role == "Agent" {
                                        roundAgent.append(playerName)
                                    }
                                    reveal = true
                                }
                                self.flipCount += 1
                            }
                    }
                    
                } else {
                    HStack{
                        Spacer()
                        Rectangle()
                            .fill(Color.black.opacity(0.0))
                            .frame(width: UIScreen.main.bounds.width * 0.55, height: UIScreen.main.bounds.height)
                            .overlay(
                                VStack {
                                    if revealEnd == true {
                                        if roundAgent.count < 2 {
                                            Text("\(roundAgent[0]) was Agent!")
                                                .foregroundColor(Color("Text"))
                                                .font(.system(size: 32).bold())
                                                .padding()
                                        } else {
                                            Text("\(roundAgent[0]) and \(roundAgent[1]) were Agent!")
                                                .foregroundColor(Color("Text"))
                                                .font(.system(size: 32).bold())
                                                .padding()
                                        }
                                        
                                        Button(action: {
                                            withAnimation {
                                                playerIndex = 0
                                                currentRound += 1
                                                revealEnd = false
                                                flipCount = 0
                                                if backgroundCount >= 13 {
                                                    backgroundCount = 1
                                                } else {
                                                    backgroundCount+=1
                                                }
                                            }
                                        }) {
                                            Text("Next Round")
                                                .font(.headline)
                                        }
                                        .padding()
                                    } else {
                                        Text("Game is on!")
                                            .font(.system(size: 40).bold())
                                            .foregroundColor(Color("Text"))
                                            .padding()
                                        Button(action: {
                                            revealEnd = true
                                            flipCount = 0
                                        }) {
                                            Text("Reveal Agent")
                                                .font(.headline)
                                        }
                                    }
                                }
                                .padding()
                            )
                    }
                }
            } else {
                HStack{
                    Spacer()
                    Rectangle()
                        .fill(Color.black.opacity(0.0))
                        .frame(width: UIScreen.main.bounds.width * 0.55, height: UIScreen.main.bounds.height)
                        .overlay(
                            VStack {
                                Text("Game ended")
                                    .font(.system(size: 32).bold())
                                    .foregroundColor(Color("Text"))
                                    .padding()
                                
                                // Click start a new round to go back to screen two
                                Button(action: {
                                    players = []
                                    itemLists = []
                                    playerCount = 1
                                    currentRound = -1
                                    reveal = false
                                    playerIndex = 0
                                    roundAgent = []
                                    revealEnd = false
                                    self.shouldPopToRootView = false
                                    flipCount = 0
                                }) {
                                    Text("Play new round")
                                        .font(.headline)
                                }
                            }
                            .padding()
                        )
                }
            }
            
        }
        .navigationBarHidden(true) // Hide the navigation bar

    }
    
}
