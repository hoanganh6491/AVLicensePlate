import Foundation

class ReachabilityHelper: NSObject {
    let NetworkChangedStateNotification = "NetworkChangedStateNotificationCenter"
    var reachability : Reachability? = Reachability.reachabilityForInternetConnection()
    
    class var sharedInstance: ReachabilityHelper {
        struct Static {
            static let instance: ReachabilityHelper = ReachabilityHelper()
        }
        return Static.instance
    }
    
    override class func initialize() {
        super.initialize()
    }
    
    func start() {
        
    }
    
    func isNetworkConntected() -> Bool {
        if (reachability != nil) {
            return reachability!.isReachable()
        }
        return false
    }
    
    func registerNetworkChangedState() {
        reachability?.startNotifier()
        reachability?.unreachableBlock = { (ability: Reachability?) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(self.NetworkChangedStateNotification, object: nil )
        }
        reachability?.reachableBlock = { (ability: Reachability?) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(self.NetworkChangedStateNotification, object: nil )
        }
    }
    
    func getNetworkStatus() -> NetworkStatus {
        let status = reachability?.currentReachabilityStatus()
        return status!
    }
}
