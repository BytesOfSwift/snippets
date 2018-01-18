/*:
# RUN SHELL COMMAND
The below piece of code demonstrates how to run a shell command from within a
Swift file.

## Important
The following chunk of code is unavailable on iOS, macOS, watchOS
or tvOS platforms.

In order to be able to run it, you should either be creating a command
line tool on macOS, scripting with Swift or building a Swift on Server
project.

## Author
[Can Sürmeli](https://github.com/cansurmeli)
*/


import Foundation

@discardableResult func runShellCommand(_ args: [String]) -> Int32 {
	let task = Process()
	
	task.launchPath = "/usr/bin/env"
	task.arguments = args
	task.launch()
	task.waitUntilExit()
	
	return task.terminationStatus
}

// running a command
runShellCommand(["ls"])

// running a command with additional arguments
runShellCommand(["ls", "-al"])
