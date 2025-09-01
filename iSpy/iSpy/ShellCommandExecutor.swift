import Foundation

class ShellCommandExecutor: Plugin {
    var name: String = "Shell Command Executor"
    
    weak var delegate: PluginDelegate?
    required init() { }
    
    func execute() throws {
        print("Executing shell command...")
        
        let shellPath = findShellPath()
        let output = executeCommand(shellPath, "ls")
        print("Output: \(output)")
    }
    
    func findShellPath() -> String {
        let shellPaths = ["/bin/sh"]
        
        for path in shellPaths {
            if FileManager.default.fileExists(atPath: path) {
                return path
            }
        }
        return "/bin/sh"
    }
}
