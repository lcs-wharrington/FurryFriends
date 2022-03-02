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
    
    @State var currentAnimal: AnimalImage = AnimalImage (message: "https://dog.ceo/api/breeds/image/random",
                                                        status: "success")
    
    @State var favourites: [AnimalImage] = []
    
    @State var currentImageAddedToFavourites: Bool = false
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            
            // MARK: User Interface
            
            // Shows the main image
            RemoteImageView(fromURL: currentImage)

                //basic UI for the image
            HStack {
              
                //Add Friend to list
                Image(systemName: "heart.circle")
                    .font(.largeTitle)
                    .foregroundColor(currentImageAddedToFavourites == true ? .red : .secondary)
                    .onTapGesture {
                        
                        if currentImageAddedToFavourites == false {
                            
                            favourites.append(currentAnimal)

                            currentImageAddedToFavourites = true
                        }
                    }
                //load a new image
                Button(action: {
                    
                    Task {
                        // Call the function that will get us a new joke!
                        await loadNewImage()
                    }
                    
                }, label: {
                    
                    Text("New Picture")
                })
                    .buttonStyle(.bordered)
            
            }
            
            //List title
            HStack {
                Text("Favourites")
                    .bold()
                
                Spacer()
            }
            
            //Favoruite Friend List
            List(favourites, id: \.self) { currentFavourite in
                Text(currentFavourite.message)
            }
            
            Spacer()
        }
        // Runs once when the app is opened
        .task {
            
            // Example images for each type of pet
            //let remoteCatImage = "https://purr.objects-us-east-1.dream.io/i/JJiYI.jpg"
            let remoteDogImage = "https://dog.ceo/api/breeds/image/random"
            
            // Replaces the transparent pixel image with an actual image of an animal
            // Adjust according to your preference ☺️
            currentImage = URL(string: remoteDogImage)!
            
            await loadNewImage()
                        
        }
        .navigationTitle("Dogs")
        
    }
    
    // MARK: Functions
    
    func loadNewImage() async {
        // Assemble the URL that points to the endpoint
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        // Define the type of data we want from the endpoint
        // Configure the request to the web site
        var request = URLRequest(url: url)
        // Ask for JSON data
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        
        // Start a session to interact (talk with) the endpoint
        let urlSession = URLSession.shared
        
        // Try to fetch a new joke
        // It might not work, so we use a do-catch block
        do {
            
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // Attempt to decode the raw data into a Swift structure
            // Takes what is in "data" and tries to put it into "currentJoke"
            //                                 DATA TYPE TO DECODE TO
            //                                         |
            //                                         V
            currentAnimal = try JSONDecoder().decode(AnimalImage.self, from: data)
            
            // Reset the flag that tracks whether the current joke
            // is a favourite
            currentImageAddedToFavourites = false
            
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")
            // Print the contents of the "error" constant that the do-catch block
            // populates
            print(error)
        }
        
    }
    
}

struct DogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DogView()
        }
    }
}
