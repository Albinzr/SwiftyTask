//
//  Queue.swift
//  DemoApp-iOS
//
//  Created by Albin CR on 1/27/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation

public enum Queue {
    case main
    case background
    case userInteractive
    case userInitiated
    case utility
    case `default`
    case custom(queue: DispatchQueue)
    
    public var queue : DispatchQueue {
        switch self {
        case .main:
            return DispatchQueue.main
        case .background:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        case .userInteractive:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive)
        case .userInitiated:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated)
        case .utility:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.utility)
        case .default:
            return DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        case .custom(let queue):
            return queue
        }
    }
}


