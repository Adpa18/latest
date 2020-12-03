import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var popover = NSPopover()
    var statusBar: StatusBarController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        popover.contentViewController = ViewController()
                
        // Create the Status Bar Item with the Popover
        statusBar = StatusBarController.init(popover)
    }
}
