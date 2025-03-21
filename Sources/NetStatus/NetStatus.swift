// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Network

public class NetStatus {
    
    // MARK: - Properties
    static public let shared = NetStatus()
    var monitor: NWPathMonitor?
    public var isMonitoring: Bool = false
    
    // MARK: - Getter propertoes
    public var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    public var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
        
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type)}.first?.type
    }
    
    public var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    public var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
    
    public var didStartMonitoringHandler: (() -> Void)?
    public var didStopMonitoringHandler: (() -> Void)?
    public var netStatusChangeHandler:(() -> Void)?
    
    // MARK: - Life cycle
    private init() {
        
    }
    
    deinit {
        stopMonitoring()
    }
    
    // MARK: - Public methods
    public func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
        
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
        
        isMonitoring = true
        didStartMonitoringHandler?()
    }
    
    public func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
    
}
