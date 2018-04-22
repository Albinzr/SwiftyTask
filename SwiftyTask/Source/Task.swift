//
//  Task.swift
//  SwiftyTask
//
//  Created by Albin CR on 2/2/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation

public typealias Closure = ((Any?) -> Any?)
public typealias StartClosure = (() -> Any?)
public typealias CompletionClosure = ((Any?) -> Void)

// MARK: - SwiftyTaskClass
public final class SwiftyTask{
    
    public let closure: Closure
    public let queue: Queue
    public let previousTask: SwiftyTask?
    
    public init(_ queue: Queue, _ previousTask: SwiftyTask? = nil, _ closure: @escaping Closure) {
        self.closure = closure
        self.queue = queue
        self.previousTask = previousTask
    }
    
    public func runTask(_ next: @escaping Closure) -> Closure? {
        let _closure = self.closure
        let _queue = self.queue.queue
        
        if let _previousTask = self.previousTask{
            return _previousTask.runTask{ result in
                _queue.async { _ = next(_closure(result)) }
                return nil
            }
        } else {
            _queue.async { _ = next(_closure(nil)) }
            return nil
        }
    }
}
