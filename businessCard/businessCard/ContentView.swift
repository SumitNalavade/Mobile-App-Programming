//
//  ContentView.swift
//  businessCard
//
//  Created by Sumit Nalavade on 10/24/21.
//  Copyright © 2021 Sumit Nalavade. All rights reserved.
//

import SwiftUI

//1. ScreenSize variable to get the width and height of the screen
let screenSize: CGRect = UIScreen.main.bounds

//2. ContactShown boolean to specify weather the contact info is shown
var contactShown : Bool = false

struct ContentView: View {
    //3. State variables to style the contact info text
    @State var contactButtonText : String = "Tap to show contact info"
    @State var infoTextBackground : Color = .blue
    
    var body: some View {
        //4. Zstack to hold all the elements on screen
       ZStack {
        Color.blue
                .edgesIgnoringSafeArea(.all)
        //5. Vstack allows all the elements to be aligned vertically
        VStack {
            //6. Self image
            Image("sumit")
            .resizable()
            .frame(width: 200.0, height: 200.0)
            .cornerRadius(100)
            .overlay(
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.white, lineWidth: 5))
                .padding(.bottom, 50)
            
            
            //7. Vstack hold the descriptions vertically
            VStack {
                Text("Sumit Nalavade")
                    .foregroundColor(.white)
                    .bold()
                    .font(.title)
                    .padding(.bottom, 15)
                
                Text("Heritage High School Senior")
                    .foregroundColor(.white)
                .bold()
            }
            .padding(.bottom, 50)
    
            //8. Button to toggle weather  the contact info is shown
            Button(action: {
                contactShown.toggle()
                if(contactShown) {
                    self.contactButtonText = "Hide contact info"
                    self.infoTextBackground = .white
                } else {
                    self.contactButtonText = "Tap to show contact info"
                    self.infoTextBackground  = .blue
                }
                
                }) {
                Text(contactButtonText)
                    .foregroundColor(.blue)
                    .bold()
            }
                .frame(width: 250, height: 50, alignment: .center)
            .background(Color.white)
            .padding(.bottom, 50)
            
            //9. Hold the contact info
                // The backround color of the text is changed to white so the text is readable when the button is pressed
            VStack {
                Text("Phone: 469-450-6323")
                .bold()
                    .frame(width: screenSize.width - 20, height: 50, alignment: .center)
                    .foregroundColor(.blue)
                    .background(infoTextBackground)
                    .padding(10)
                
                Text("Email: Vs.nalavade2003@gmail.com")
                .bold()
                    .frame(width: screenSize.width - 20, height: 50, alignment: .center)
                .foregroundColor(.blue)
                .background(infoTextBackground)
                .padding(10)
            }
            
            Spacer()
            
        }
        .padding(50)
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
