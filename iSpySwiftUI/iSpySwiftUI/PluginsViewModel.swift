import SwiftUI

@MainActor
final class PluginsViewModel: ObservableObject, PluginDelegate {
    @Published private(set) var pluginNames: [String]
    
    private var plugins: [Plugin]

    init() {
        let available: [Plugin] = [
            SystemInfoFetcher(),
            ShellCommandExecutor()
            
        ]
        
        self.plugins = available
        self.pluginNames = available.map { $0.name }
        
        for index in plugins.indices {
            plugins[index].delegate = self
        }
    }
    
    func executePlugin(at index: Int) {
        guard plugins.indices.contains(index) else { return }
        plugins[index].execute()
    }
    
    func pluginDidFinish(plugin: Plugin) {
        print("Plugin \(plugin.name) finished")
    }
}
