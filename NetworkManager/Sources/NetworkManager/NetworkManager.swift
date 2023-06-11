//
//  NetworkManager.swift
//  DictionaryApp
//
//  Created by Emre Cambolat on 30.05.2023.
//

import Network
import SystemConfiguration

public final class NetworkManager {
    
    // MARK: - Variables
    static public let shared = NetworkManager()
    private var monitor: NWPathMonitor?
    private var isMonitoring = false
    
    // MARK: - Functions
    private init() {}
    
    public func startMonitoring(completion: @escaping (Bool) -> Void) {
        guard !isMonitoring else { return }
        
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
             let isReachable = path.status == .satisfied
            completion(isReachable)
        }
        
        self.monitor = monitor
        isMonitoring = true
    }
    
    public func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
    }
    
    public func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
}
