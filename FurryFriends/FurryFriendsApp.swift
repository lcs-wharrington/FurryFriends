//
//  FurryFriendsApp.swift
//  FurryFriends
//
//  Created by William Robert Harrington on 2022-03-01.
//

import SwiftUI

@main
struct FurryFriendsApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView {
                    DogView()
                        .tabItem {
                            Image(systemName: "pawprint.circle")
                            Text("Dogs")
                        }
                    
                    CatView()
                        .tabItem {
                            Image(systemName: "pawprint.circle")
                            Text("Cats")
                        }
                }
            }
        }
    }
}
