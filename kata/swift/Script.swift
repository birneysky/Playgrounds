import Foundation
/// https://github.com/kareman/SwiftShell
/// https://blog.csdn.net/u011865919/article/details/89415390
/// swift -sdk $(xcrun --show-sdk-path --sdk macosx) Script.swift

@discardableResult
func run(_ command:String, arguments:[String]? = nil) -> (Int32) {
	let process = Process()
	process.launchPath = command 
	if let argv = arguments {
		process.arguments = argv
	}
	process.launch()
	process.waitUntilExit()
	return (process.terminationStatus)
}

func exec(_ command: String, arguments:[String]? = nil) ->(Int32, String?) {
	let process = Process()
    process.launchPath = command;
    if let argv = arguments {
        process.arguments = argv
    }
    let pipe = Pipe()
    process.standardOutput = pipe
    process.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String? = String(data: data, encoding: .utf8)
    process.waitUntilExit()
    pipe.fileHandleForReading.closeFile()
    return (process.terminationStatus, output)
}

let enviroment = ProcessInfo.processInfo.environment
if let shell = enviroment["SHELL"] {
	print("SHELL is \(shell)")
}
run("/usr/bin/say", arguments: ["ladies and gentlemen, may i have your attention please, i have a very import announcement to make"])
let  (status, message) = exec("/usr/bin/whereis",arguments: ["ls"])
guard status == 0, let msg = message else {
	fatalError()
}
print("status:\(status), \(msg)")
