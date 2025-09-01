class SystemInfoFetcher: Plugin {
    var name: String = "System Info Fetcher"
    weak var delegate: PluginDelegate?
    
    func execute() {
        print("Fetching system information...")
        delegate?.pluginDidFinish(plugin: self)
    }
}
