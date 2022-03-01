//
//  DogView.swift
//  FurryFriends
//
//  Created by William Robert Harrington on 2022-03-01.
//

import SwiftUI

struct DogView: View {
    
    // MARK: Stored properties
    
    // Address for main image
    // Starts as a transparent pixel – until an address for an animal's image is set
    @State var currentImage = URL(string: "https://www.russellgordon.ca/lcs/miscellaneous/transparent-pixel.png")!
    
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            // Shows the main image
            RemoteImageView(fromURL: currentImage)

                
            HStack {
              
                //Add Friend to list
                Image(systemName: "heart.circle")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                
                //load a new image
                Button(action: {
                    
                    print("Button was pressed")
                    
                }, label: {
                    
                    Text("New Picture")
                })
                    .buttonStyle(.bordered)
            
            }
            
            HStack {
              
                //Add Friend to list
                Image(systemName: "square.and.arrow.down")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                //Add a title to the friend
                TextField("Picture Title",
                          text: .constant(""),
                          prompt: Text("Name Your Friend..."))
                
            }
            
            //List title
            HStack {
                Text("Favourites")
                    .bold()
                
                Spacer()
            }
            
            
            List{
                
            }
            
            Spacer()
        }
        // Runs once when the app is opened
        .task {
            
            // Example images for each type of pet
            //let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
            let remoteDogImage = "https://images.dog.ceo/breeds/labrador/lab_young.JPG"
            
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
            currentImage = URL(string: remoteDogImage)!
            
                        
        }
        .navigationTitle("Dogs")
        
    }
    
    // MARK: Functions
    
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DogView()
        }
    }
}
