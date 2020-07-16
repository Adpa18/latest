//
//  PackageManager.swift
//  latest
//
//  Created by Adrien WERY on 7/11/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import SwiftUI
import UserNotifications

class PackageManager: ObservableObject {
    static let shared = PackageManager()
    
    @Published var packages: [Package] {
        didSet {
            if let encoded = try? JSONEncoder().encode(self.packages) {
                UserDefaults.standard.set(encoded, forKey: "packages")
            }
        }
    }
    @Published var lastUpdate = Date()
    var editMode: Bool = false
    
    init() {
        guard
            let data = UserDefaults.standard.object(forKey: "packages") as? Data,
            let pkgs = try? JSONDecoder().decode([Package].self, from: data) else {
            self.packages = []
            return
        }
        self.packages = pkgs
    }
    
    func addPackage(package: Package) -> Void {
        if self.packages.contains(where: {
            $0.name == package.name && $0.tag == package.tag
        }) {
            return
        }
        self.packages.insert(package, at: self.packages.endIndex)
    }
    
    func delete(package: Package) -> Void {
        self.packages.remove(at: self.packages.firstIndex(of: package)!)
    }
    
    func updatePackages() -> Void {
        for package in self.packages {
            package.update()
        }
        self.lastUpdate = Date()
    }
    
    func quit() -> Void {
        exit(0)
    }
}
