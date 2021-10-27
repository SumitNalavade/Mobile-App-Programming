//
//  ContentView.swift
//  RGBMatcher
//
//  Created by Nalavade, Sumit S on 10/27/21.
//  Copyright © 2021 Nalavade, Sumit S. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var rValue: Double = 0
    @State var gValue: Double = 0
    @State var bValue: Double = 0
    
    var body: some View {
        
          ZStack {
           Color.gray
                   .edgesIgnoringSafeArea(.all)
            
        
            VStack {
                HStack{
                              VStack{
                                  Rectangle()
                                  .frame(maxHeight: 300)
                                      .overlay(
                                      Rectangle()
                                          .stroke(Color.green, lineWidth: 3))
                                  
                                  Text("My Color")
                              }
                             
                              VStack {
                                  Rectangle()
                                  .frame(maxHeight: 300)
                                  .overlay(
                                  Rectangle()
                                      .stroke(Color.green, lineWidth: 3))
                                  
                                  Text("Match this color")
                              }
                              
                          }
                
                VStack {
                    HStack {
                        Text("R")
                        Slider(value: $rValue, in: -100...100)
                    }
                    
                    HStack {
                        Text("G")
                        Slider(value: $gValue, in: -100...100)
                    }
                    
                    HStack {
                        Text("B")
                        Slider(value: $bValue, in: -100...100)
                    }
                }
                
            }
          .padding()
           
                
            }
            
            
        }
    }


func generateRandomColor() -> Double {
    return Double.random(in: 0...1)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
