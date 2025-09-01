@MainActor
protocol PluginDelegate: AnyObject {
    func pluginDidFinish(plugin: Plugin)
}

@MainActor
protocol Plugin {
    init()
    var name: String { get }
    var delegate: PluginDelegate? { get set }
    func execute() throws
}
