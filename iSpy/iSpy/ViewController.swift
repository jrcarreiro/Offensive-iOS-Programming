import UIKit
import Foundation

//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let output = executeCommand("ls")
//        print("Output: \(output)")
//    }
//}
//
class ViewController: UITableViewController {
    var pluginClasses: [String: Plugin.Type] =  [
        "Clipboard Stealer": ClipboardStealer.self,
        "System Info Fetcher": SystemInfoFetcher.self,
        "Shell Command Executor": ShellCommandExecutor.self
        ]
    
    var plugins: [String] = []
    
    override func viewDidLoad() {
        plugins = Array(pluginClasses.keys)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plugins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = plugins[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pluginName = plugins[indexPath.row]
        if let pluginClass = pluginClasses[pluginName] {
            let plugin = pluginClass.init()
            try? plugin.execute()
        } else {
            print("No class found for \(pluginName)")
        }
    }
}
