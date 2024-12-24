#!/usr/bin/env swift
import AppKit

func hasGUIWindow(_ app: NSRunningApplication) -> Bool {
    guard let appName = app.localizedName else {
        print("Unable to get application name: \(app)")
        return false
    }

    let options: CGWindowListOption = [.excludeDesktopElements, .optionOnScreenOnly]
    let windowInfoList = CGWindowListCopyWindowInfo(options, kCGNullWindowID)
                            as NSArray? as? [[String: Any]] ?? []

    for windowInfo in windowInfoList {
        if let ownerName = windowInfo[kCGWindowOwnerName as String] as? String,
           ownerName == appName {
            return true
        }
    }

    return false
}

if (CommandLine.arguments.contains { $0 == "--help" || $0 == "-h" }) {
    print("""
    Simplified alt-tab switcher, will switch from the active window
    on the current workspace to an inactive window on the same workspace.
    Only meant to work well for workflows with two windows on a workspace.
    Use karabiner elements with `shell_command` to create a mapping.
    """)
    exit(1)
}

let inactiveGuiApps = NSWorkspace.shared.runningApplications
                                .filter{ !$0.isActive && hasGUIWindow($0) }

guard let firstInactiveApp = inactiveGuiApps.first else {
    print("No inactive app to switch to")
    exit(0)
}

print("Activating: \(firstInactiveApp.localizedName ?? "(No name)")")
firstInactiveApp.activate()
