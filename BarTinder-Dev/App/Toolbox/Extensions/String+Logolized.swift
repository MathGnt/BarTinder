import Foundation

extension String {
    func logolized() -> String {
        replacingOccurrences(of: " ", with: "") + "logo"
    }
}
