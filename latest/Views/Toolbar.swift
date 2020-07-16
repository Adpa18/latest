//
//  Toolbar.swift
//  latest
//
//  Created by Adrien WERY on 7/12/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import SwiftUI

struct Toolbar: View {
    @ObservedObject private var manager = PackageManager.shared
    @Binding var lastUpdate: Date
        
    var body: some View {
        HStack {
            Button("􀣋", action: openSettings)
            Spacer()
            Text(lastUpdate.timeAgoDisplay())
            Spacer()
            Button("􀆨", action: quit)
        }
        .padding(4)
    }
    
    func openSettings() {
        self.manager.editMode.toggle()
    }
    
    func quit() {
        self.manager.quit()
    }
}

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        Toolbar(lastUpdate: .constant(Date()))
    }
}
