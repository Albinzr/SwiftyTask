//
//  TaskExtension.swift
//  SwiftyTask
//
//  Created by Albin CR on 2/2/17.
//  Copyright © 2017 Albin CR. All rights reserved.
//

import Foundation


// MARK: - Run Task
extension SwiftyTask{
    
    public final func run(_ queue: Queue? = nil, _ completion: CompletionClosure? = nil) {
        let _queue = queue?.queue ?? self.queue.queue
        _ = self.runTask{ result in
            _queue.async { completion?(result) }
            return nil
        }
    }
}

// MARK: - Static Functions
extension SwiftyTask{
    
    public static func main(_ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(Queue.main, nil, { _ in return closure() })
    }
    
    public static func background(_ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(Queue.background, nil, { _ in return closure() })
    }
    
    public static func userInteractive(_ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(Queue.userInteractive, nil, { _ in return closure() })
    }
    
    public static func userInitiated(_ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(Queue.userInitiated, nil, { _ in return closure() })
    }
    
    public static func utility(_ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(Queue.utility, nil, { _ in return closure() })
    }
    
    public static func onDefault(_ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(Queue.default, nil, { _ in return closure() })
    }
    
    public static func custom(_ queue: DispatchQueue, _ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(Queue.custom(queue: queue), nil, { _ in return closure() })
    }
    
    public static func after(_ queue: Queue = Queue.background, seconds: Double, _ closure: @escaping StartClosure) -> SwiftyTask{
        return SwiftyTask(queue, nil) { _ in
            SwiftyTask.waitBlock(seconds)()
            return closure()
        }
    }
    
    public static func wait(_ queue: Queue = Queue.background, seconds: Double, _ closure: StartClosure) -> SwiftyTask{
        return SwiftyTask(queue, nil) { _ in
            SwiftyTask.waitBlock(seconds)()
            return nil
        }
    }
    
    fileprivate static func waitBlock(_ seconds: Double) -> (() -> ()) {
        return {
            let nanoSeconds = Int64(seconds * Double(NSEC_PER_SEC))
            let time = DispatchTime.now() + Double(nanoSeconds) / Double(NSEC_PER_SEC)
            
            let sem = DispatchSemaphore(value: 0)
            _ = sem.wait(timeout: time)
        }
    }
}

// MARK: - Instance Functions
extension SwiftyTask{
    
    public final func main(_ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(Queue.main, self, closure)
    }
    
    public final func background(_ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(Queue.background, self, closure)
    }
    
    public final func userInteractive(_ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(Queue.userInteractive, self, closure)
    }
    
    public final func userInitiated(_ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(Queue.userInitiated, self, closure)
    }
    
    public final func utility(_ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(Queue.utility, self, closure)
    }
    
    public final func onDefault(_ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(Queue.default, self, closure)
    }
    
    public final func custom(_ queue: DispatchQueue, _ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(Queue.custom(queue: queue), self, closure)
    }
    
    public final func after(_ queue: Queue = Queue.background, seconds: Double, _ closure: @escaping Closure) -> SwiftyTask{
        return SwiftyTask(queue, self) { result in
            SwiftyTask.waitBlock(seconds)()
            return closure(result)
        }
    }
    
    public final func wait(_ queue: Queue = Queue.background, seconds: Double) -> SwiftyTask{
        return SwiftyTask(queue, self) { result in
            SwiftyTask.waitBlock(seconds)()
            return result
        }
    }
}
