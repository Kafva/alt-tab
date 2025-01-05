#!/usr/bin/env swift
import AppKit

if (CommandLine.arguments.contains { $0 == "--help" || $0 == "-h" }) {
    print("""
    Basic alt-tab switcher, will switch from the active app on the current
    desktop to an inactive app on the same desktop.
    """)
    exit(1)
}

// NSWorkspace.shared.runningApplications does not have a separate entry for each window.
// E.g. if two Firefox windows are open, there will only be one NSRunningApplication in the array.
// We can only switch focus per application with an NSRunningApplication, not per window.
// To switch focus per window we need to use the Accessibility API or another shortcut.

// Get window information for all apps on the current screen
let infoList = CGWindowListCopyWindowInfo([.excludeDesktopElements, .optionOnScreenOnly],
                                          kCGNullWindowID) as NSArray? as? [[String: Any]] ?? []
// Only include those that are active (at layer 0)
let windowList = infoList.filter{ $0["kCGWindowLayer"] as! Int == 0 }

// Find the first inactive app that matches one of the windows on screen
let firstInactiveApp = NSWorkspace.shared.runningApplications.first {
    !$0.isActive &&
    windowList.map{ $0["kCGWindowOwnerPID"] as! pid_t }.contains($0.processIdentifier)
}

guard let firstInactiveApp else {
    print("No inactive app to switch to [\(windowList.count) window(s)]")
    exit(0)
}

let name = firstInactiveApp.localizedName ?? "(No name)"
print("Activating: \(name) [\(windowList.count) window(s)]")
if #available(macOS 14, *) {
    firstInactiveApp.activate()
}
else {
    firstInactiveApp.activate(options: .activateIgnoringOtherApps)
}
