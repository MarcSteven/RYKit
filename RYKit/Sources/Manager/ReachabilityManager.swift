//
//  ReachabilityManager.swift
//  RYKit
//
//  Created by Marc Steven on 2020/6/20.
//  Copyright © 2020 Rich and Young. All rights reserved.
//

import Foundation

/// network manager
open class ReachabilityManager {
    
    /// singleton
    static let shared = ReachabilityManager()
    private var reachability:Reachability!
    private var reachabilityManagerType:ReachabilityManagerType = .none
    
    ///  初始化器
    private init() {
        
        do {
            self.reachability = try Reachability()
            
            }catch {
                print("Unable to create Reachability")
                return
            }
            NotificationCenter.default.addObserver(self, selector: #selector(ReachabilityManager.reachabilityChanged(notification:)),name: Notification.Name.reachabilityChanged,object: self.reachability)
        
                do{
                    try self.reachability.startNotifier()
                }catch{
                    print("could not start reachability notifier")
                }
            
    }

            @objc private func reachabilityChanged(notification: NSNotification) {

                let reachability = notification.object as! Reachability

                if (reachability.whenReachable != nil) {
                    if reachability.connection == .wifi {
                        self.reachabilityManagerType = .wifi
                    } else {
                        self.reachabilityManagerType = .cellular
                    }
                } else {
                    self.reachabilityManagerType = .none
                }
            }
        }

public extension ReachabilityManager {
    
    /// is connected to netowrk
    /// - Returns: if it is not connected to the network, return false , or return true 
             func isConnectedToNetwork() -> Bool {
                return reachabilityManagerType != .none
            }

        }

/** Usage*/

/**
 
 let reachabilityManager = ReachabilityManager.shared.isConnectedToNetwork 
 */
