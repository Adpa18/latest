//
//  Package.swift
//  latest
//
//  Created by Adrien WERY on 7/10/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import AppKit
import UserNotifications

class Package: NSObject, NSUserNotificationCenterDelegate, Codable {
    let id = UUID()
    var name: String
    var tag: String
    var version: String?
    var lastUpdate: Date?
    var registry: NPMRegistry?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case tag
        case version
        case lastUpdate
    }
    
    init(name: String, tag: String) {
        self.name = name
        self.tag = tag
    }
    
    func open() -> Void {
        NSWorkspace.shared.open(self.registry!.homepage)
    }
    
    func update() -> Void {
        guard let url = URL(string: "https://registry.npmjs.org/" + self.name) else {
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                
                if let registry = try? decoder.decode(NPMRegistry.self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.registry = registry
                        if let version = registry.distTags[self.tag], let lastUpdate = registry.time[version] {
                            let oldVersion = self.version
                            self.version = version
                            self.lastUpdate = lastUpdate
                            if oldVersion != nil && oldVersion != self.version {
                                self.notify()
                            }
                        } else {
                            self.status = "not found"
                            print("Cannot find \(self.name)@\(self.tag)")
                        }
                    }
                    return
                }
            }
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                self.status = "not found"
            }
            print("Cannot find \(self.name)@\(self.tag)")
        }.resume()
    }
    
    func notify() -> Void {
        let notification = NSUserNotification()
        notification.title = "\(self.name)@\(self.tag)"
        notification.subtitle = self.version
        notification.soundName = NSSound.Name("Tink")
        notification.hasActionButton = true
        notification.actionButtonTitle = "Homepage"
        NSUserNotificationCenter.default.delegate = self
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) -> Void {
        switch (notification.activationType) {
        case .actionButtonClicked, .contentsClicked:
            self.open()
            break
        default:
            break
        }
    }
    
    static func parsePackage(pkg: String) -> (String, String) {
        var lastIndex = pkg.lastIndex(of: "@") ?? pkg.endIndex
        if lastIndex == pkg.startIndex {
            lastIndex = pkg.endIndex
        }
        
        let name = pkg.prefix(upTo: lastIndex)
        let tag = lastIndex == pkg.endIndex ? "latest" : pkg.suffix(from: pkg.index(after: lastIndex))
        
        return (String(name), String(tag))
    }
}
