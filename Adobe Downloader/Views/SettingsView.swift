//
//  Adobe Downloader
//
//  Created by X1a0He on 2024/10/30.
//
import SwiftUI

struct SettingsView: View {
    @AppStorage("defaultLanguage") private var defaultLanguage: String = "zh_CN"
    @AppStorage("defaultDirectory") private var defaultDirectory: String = ""
    @Binding var useDefaultLanguage: Bool
    @Binding var useDefaultDirectory: Bool
    
    var onSelectLanguage: () -> Void
    var onSelectDirectory: () -> Void

    private let languageMap: [(code: String, name: String)] = AppStatics.supportedLanguages
    
    var body: some View {
        VStack() {
            HStack() {
                HStack() {
                    Toggle(isOn: $useDefaultLanguage) {
                        Text("语言:")
                            .fixedSize()
                    }
                    .toggleStyle(.checkbox)
                    .fixedSize()
                    
                    Text(getLanguageName(code: defaultLanguage))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .frame(alignment: .leading)
                    Spacer()
                    Button("选择", action: onSelectLanguage)
                        .fixedSize()
                }
                
                Divider()
                    .frame(height: 16)
                
                HStack() {
                    Toggle(isOn: $useDefaultDirectory) {
                        Text("目录:")
                            .fixedSize()
                    }
                    .toggleStyle(.checkbox)
                    .fixedSize()
                    
                    Text(formatPath(defaultDirectory.isEmpty ? String(localized: "未设置") : defaultDirectory))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .frame(alignment: .leading)
                    Spacer()
                    Button("选择", action: onSelectDirectory)
                        .fixedSize()
                }
            }
        }
        .padding()
        .fixedSize()
    }
    
    private func getLanguageName(code: String) -> String {
        let languageDict = Dictionary(uniqueKeysWithValues: languageMap)
        return languageDict[code] ?? code
    }
    
    private func formatPath(_ path: String) -> String {
        if path.isEmpty { return String(localized: "未设置") }
        let url = URL(fileURLWithPath: path)
        return url.lastPathComponent
    }
}

#Preview {
    SettingsView(
        useDefaultLanguage: .constant(true),
        useDefaultDirectory: .constant(true),
        onSelectLanguage: {},
        onSelectDirectory: {}
    )
}
