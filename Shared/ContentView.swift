//
//  ContentView.swift
//  Shared
//
//  Created by Masayuki Hiraoka on 2020/08/14.
//

import SwiftUI

struct ContentView: View {
    let adaptiveColums = [ GridItem(.adaptive(minimum: 100)) ]
    let flexibleColums = [ GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()), ]
    
    let fixedColums = [ GridItem(.fixed(60)),
                        GridItem(.fixed(60)),
                        GridItem(.fixed(60)), ]
    

    
    @State var colums: [GridItem] = []
    @State var rows: [GridItem] = []
    
    var body: some View {
        TabView {
            VStack {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: $colums.wrappedValue,
                              alignment: .center,
                              spacing: nil,
                              pinnedViews: [],
                              content: {
                                ForEach(emojis, id: \.self) { (emoji: String) in
                                    Text(emoji)
                                        .font(.largeTitle)
                                }
                              })
                }
                
                
                ButtonsView(items: $colums)
            }
            .tabItem {
                Text("Vertical")
            }
            
            VStack {
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHGrid(rows: $rows.wrappedValue,
                              alignment: .center,
                              spacing: nil,
                              pinnedViews: [],
                              content: {
                                ForEach(emojis, id: \.self) { (emoji: String) in
                                    Text(emoji)
                                        .font(.largeTitle)
                                }
                              })
                }
                
                
                ButtonsView(items: $rows)
            }
            .tabItem {
                Text("Horizontal")
            }
            
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .frame(width: 100, height: 40)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct ButtonsView: View {
    @Binding var items: [GridItem]
    
    let adaptiveItems = [ GridItem(.adaptive(minimum: 60)) ]
    let flexibleItems = [ GridItem(.flexible(minimum: 60)),
                         GridItem(.flexible()),
                         GridItem(.flexible()), ]
    
    let fixedItems = [ GridItem(.fixed(60)),
                      GridItem(.fixed(60)),
                      GridItem(.fixed(60)), ]
    
    var body: some View {
        HStack(spacing: 24) {
            Button(action: {
                items = fixedItems
            }, label: {
                ButtonText(text: ".fixed")
                
            })
            
            
            Button(action: {
                items = flexibleItems
            }, label: {
                ButtonText(text: ".flexible")
            })
            
            
            Button(action: {
                items = adaptiveItems
            }, label: {
                ButtonText(text: ".adaptive")
            })
            
        }
        .frame(height: 60)
        .onAppear {
            items = fixedItems
        }
    }
}
