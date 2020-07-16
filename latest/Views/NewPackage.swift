//
//  NewPackage.swift
//  latest
//
//  Created by Adrien WERY on 7/16/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import SwiftUI

struct NewPackage: View {
    @ObservedObject private var manager = PackageManager.shared
    @State var pkg: String = ""
    
    var body: some View {
        HStack {
            TextField("package@latest", text: $pkg, onCommit: add)
            Button("􀅼", action: add)
        }
    }
    
    func add() {
        let (name, tag) = Package.parsePackage(pkg: self.pkg)
        self.pkg = ""
        let package = Package(name: name, tag: tag)
        self.manager.addPackage(package: package)
        package.update()
    }
}

struct NewPackage_Previews: PreviewProvider {
    static var previews: some View {
        NewPackage()
    }
}
