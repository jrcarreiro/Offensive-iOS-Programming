import SwiftUI

struct PluginsListView: View {
    @StateObject private var viewModel = PluginsViewModel()

    var body: some View {
        NavigationStack {
            List(Array(viewModel.pluginNames.enumerated()), id: \.element) { index, name in
                Text(name)
                    .font(.body)
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())      
                    .onTapGesture {
                        viewModel.executePlugin(at: index)
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Plugins")
        }
    }
}
