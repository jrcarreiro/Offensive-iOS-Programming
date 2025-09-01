class ClipboardStealer: Plugin {
    required init() {}
    
    var name: String = "Clipboard Stealer"
    weak var delegate: PluginDelegate?
    
    func execute() {
        print("Stealing clipboard contents...")
        delegate?.pluginDidFinish(plugin: self)
    }
}
