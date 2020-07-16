//
//  PackageList.swift
//  latest
//
//  Created by Adrien WERY on 7/10/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import SwiftUI

struct PackageList: View {
    @Binding var packages: [Package]
    
    var body: some View {
        VStack {
            ForEach(self.packages.sorted(by:
                {($0.lastUpdate ?? .distantPast) > ($1.lastUpdate ?? .distantPast)}
            ), id: \.id) { package in
                VStack {
                    PackageRow(package: package)
                    Divider()
                }
            }
        }
    }
}

struct PackageList_Previews: PreviewProvider {
    static var previews: some View {
        PackageList(packages: .constant(packagesData))
    }
}
