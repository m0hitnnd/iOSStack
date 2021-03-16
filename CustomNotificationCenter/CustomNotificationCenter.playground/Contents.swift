import UIKit

// Design Custom Notification Center

/* Requirements:
  - Every notification will have an id and some info with it.
  - There can be multiple observers observing a particular notification
  - Observer can remove itself from all the notifications or from a particular notification.
  - Post a notification which will notify all the observers
  - Add an observer for a notification
*/

protocol NotificationCenterable {
    typealias Action = (([AnyHashable: Any]) -> Void)
    func add(observer: AnyObject, for name: String, action: @escaping NotificationCenterable.Action)
    func post(for name: String, info: [AnyHashable: Any])
    func remove(observer: AnyObject)
    func remove(observer: AnyObject, for name: String)
}

struct Notification {
    let observingTo: String
    let observedBy: AnyObject
    let action: NotificationCenterable.Action
}

class CustomNotificationCenter: NotificationCenterable {
    
    private init() {}
    
    static let shared: CustomNotificationCenter = CustomNotificationCenter()
    
    private let internalQueue = DispatchQueue(label: "custom_notification")

    private var _notificationObservers: [String: [Notification]] = [:]
    
    private var notificationObservers: [String: [Notification]] {
        get {
            return internalQueue.sync {
                _notificationObservers
            }
        }
        set {
            internalQueue.async {
                self._notificationObservers = newValue
            }
        }
    }
    
    func add(observer: AnyObject, for name: String, action: @escaping NotificationCenterable.Action) {
        let newObserver = Notification(observingTo: name, observedBy: observer, action: action)
        if notificationObservers[name] != nil {
            notificationObservers[name]?.append(newObserver)
        } else {
            notificationObservers[name] = [newObserver]
        }
    }

    func post(for name: String, info: [AnyHashable : Any]) {
        let observers = notificationObservers[name]
        observers?.forEach { observer in
            observer.action(info)
        }
    }

    func remove(observer: AnyObject) {
        for key in notificationObservers.keys {
            remove(observer: observer, for: key)
        }
    }

    func remove(observer: AnyObject, for name: String) {
        var observers = notificationObservers[name]
        observers?.removeAll(where: { (notification) -> Bool in
            notification.observedBy === observer
        })
        notificationObservers[name] = observers
    }
}

let center = CustomNotificationCenter.shared

class A {
    init() {
        addObservers()
    }
    
    func addObservers() {
        center.add(observer: self, for: "abc", action: { (_) in
            print("notification a abc")
        })
        
        center.add(observer: self, for: "def", action: { (_) in
            print("notification a def")
        })

    }
    
    @objc private func abcChanged(notification: NSNotification){
        print("notification a - \(notification)")
    }
}

class B {
    init() {
        addObservers()
    }
    
    func addObservers() {
        center.add(observer: self, for: "abc", action: { (_) in
            print("notification b abc")
        })
    }
    
    @objc private func abcChanged(notification: NSNotification){
        print("notification b - \(notification)")
    }
}

let a1 = A()
let a2 = A()
let b2 = B()

center.post(for: "abc", info: [:])
center.remove(observer: a1)
print("badummbaa")
center.post(for: "abc", info: [:])
center.post(for: "def", info: [:])


