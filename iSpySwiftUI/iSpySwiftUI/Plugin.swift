protocol PluginDelegate: AnyObject {
    func pluginDidFinish(plugin: Plugin)
}

protocol Plugin {
    var name: String { get }
    var delegate: PluginDelegate? { get set }
    func execute()
}
