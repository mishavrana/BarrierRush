import Foundation
import Network

final class NetworkCheck: ObservableObject {
    static let shared = NetworkCheck()
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published public var isConnected: Bool = true
    
    func startCheckingConnection() async {
        return await withCheckedContinuation { continuation in
            monitor.pathUpdateHandler = { [weak self] path in
                self?.isConnected = path.status == .satisfied ? true : false
                continuation.resume(returning: ())
            }
            monitor.start(queue: queue)
        }
    }
    
    private init() { }
}
