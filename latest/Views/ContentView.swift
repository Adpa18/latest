//
//  ContentView.swift
//  latest
//
//  Created by Adrien WERY on 7/9/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var manager = PackageManager.shared
        
    var body: some View {
        VStack {
            PackageList(packages: self.$manager.packages)
            if self.manager.editMode {
             NewPackage()
            }
            Toolbar(lastUpdate: self.$manager.lastUpdate)
        }
        .padding(12)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
