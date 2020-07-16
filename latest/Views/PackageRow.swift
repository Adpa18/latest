//
//  PackageRow.swift
//  latest
//
//  Created by Adrien WERY on 7/10/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import SwiftUI

struct PackageRow: View {
    @ObservedObject private var manager = PackageManager.shared
    var package: Package
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(package.name)@\(package.tag)")
                Text(package.version ?? "")
                    .font(.caption)
                    .fontWeight(.thin)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(package.lastUpdate?.timeAgoDisplay() ?? package.status ?? "Updating...")
                    .font(.caption)
                    .opacity(0.625)
                if self.manager.editMode {
                    Button("􀈑", action: self.delete)
                        .foregroundColor(Color.init(red: 0.96, green: 0.26, blue: 0.21))
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: self.package.open)
    }
    
    func delete() -> Void {
        self.manager.delete(package: self.package)
    }
}

struct PackageRow_Previews: PreviewProvider {
    static var previews: some View {
        PackageRow(package: packagesData[0])
    }
}
