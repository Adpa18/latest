//
//  StatusBarController.swift
//  latest
//
//  Created by Adrien WERY on 7/10/20.
//  Copyright © 2020 Adrien WERY. All rights reserved.
//

import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    private var statusBarButton: NSStatusBarButton
    private var eventMonitor: EventMonitor?
    
    init(_ popover: NSPopover) {
        self.statusBar = NSStatusBar.init()
        self.statusItem = self.statusBar.statusItem(withLength: 28.0)
        self.statusBarButton = self.statusItem.button!
        self.popover = popover

        self.statusBarButton.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        self.statusBarButton.image?.isTemplate = true
        
        self.statusBarButton.action = #selector(togglePopover(sender:))
        self.statusBarButton.target = self
        
        self.eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown], handler: mouseEventHandler)
    }
    
    @objc func togglePopover(sender: AnyObject) {
        if(popover.isShown) {
            hidePopover(sender)
        } else{
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
        eventMonitor?.start()
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func mouseEventHandler(_ event: NSEvent?) {
        if(popover.isShown) {
            hidePopover(event!)
        }
    }
}
