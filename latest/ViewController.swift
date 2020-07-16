//
//  ViewController.swift
//  latest
//
//  Created by Adrien WERY on 7/14/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import SwiftUI

let VIEW_NIB_NAME = "View"
class ViewController: NSViewController {
    let packages = [
        Package(name: "@angular/core", tag: "latest"),
        Package(name: "@angular/material", tag: "latest"),
        Package(name: "express-profiler-middleware", tag: "latest")
    ]
    var updateViewTimer: Timer = Timer()

    convenience init() {
        self.init(nibName: VIEW_NIB_NAME, bundle: nil)
        self.view = NSHostingView(rootView: ContentView())
        
        PackageManager.shared.updatePackages()
        Timer.scheduledTimer(withTimeInterval: TimeInterval.Hour, repeats: true) { timer in
            PackageManager.shared.updatePackages()
        }
    }
    
    override func viewWillAppear() {
        print("viewWillAppear")
        PackageManager.shared.editMode = false
        PackageManager.shared.updatePackages()
        self.updateViewTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval.Second, repeats: true) { timer in
            PackageManager.shared.lastUpdate = PackageManager.shared.lastUpdate
        }
    }
    
    override func viewDidAppear() {
        print("viewDidAppear")
    }
    
    override func viewWillDisappear() {
        print("viewWillDisappear")
        self.updateViewTimer.invalidate()
    }
}
