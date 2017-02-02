# SwiftyTask
An extreme queuing system with high performance for managing all task in app with closure

# Task

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](https://developer.apple.com/swift/)
[![Xcode 8.0](https://img.shields.io/badge/Xcode-8.0-blue.svg?style=flat)](https://developer.apple.com/swift/)

Method Tasking of queued closure (blocks) on GCD (Grand Central Dispatch).

Task is inspired by [Async](https://github.com/duemunk/Async).

## Requirements

* iOS 8.0+
* Swift 3.0+
* Xcode 8.0+

## Installation

### CocoaPods

Task is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!

pod "SwiftyTask"
```

### Carthage

To integrate Task into your Xcode project using Carthage, specify it in your Cartfile:

```ruby
github "Albin-CR/SwiftyTask"
```

## Example


### Basics

```swift
Task.main {

    // main thread queue

    return "1"
    }.background { result in

         // background qos class thread queue
         print(result) 

         return "2"
    }.userInteractive { result in

         // userInteractive qos class thread queue
         print(result) 

         return "3"
    }.userInitiated { result in
         //userInitiated qos class thread queue
         print(result) 

         return "4"
    }.onDefault { result in
         // default qos class thread queue

         print(result)
         return "5"
    }.run(.Main) { result in

         // called at main thread queue
         print(result) 
         print("Process completion")
}
```

### Custom queue

```swift
let queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)

Task.custom(queue) {
    
    //customQueue

    return nil
    }.onDefault { result in

         //default qos class thread queue

         return result
    }.main { result in

         //main thread queue

         return result
    }.custom(customQueue) { result in
         
         // customQueue
         
         return result
    }.run()
```

### After

```swift
Task.main {
    
    // main thread queue

    print("start after: \(NSDate().description)")

    return "1"
    }.after(seconds: 5) { result in

        // 5 seconds after the previous block
        //background qos class thread queue

        print(result)
        return "after 2: \(NSDate().description)"
    }.userInteractive { result in

        //userInteractive qos class thread queue

        print(result)
        return "after 3: \(NSDate().description)"
    }.after(Queue.Utility, seconds: 5) { result in

        //5 seconds after the previous block
        // called at utility qos class thread queue

        print(result) 
        return "after 4: \(NSDate().description)"
    }.run(.Main) { result in

        // last call main thread queue

        print(result) 
        print("after completion: \(NSDate().description)")
}
```

### Wait

```swift
Task.main {

    //  main thread queue

    print("start wait: \(NSDate().description)")
    return "1"
    }.wait(seconds: 5).background { result in

        // 5 seconds after the previous block
        // background qos class thread queue

        print("wait 2: \(NSDate().description)")
        return result
    }.wait(seconds: 5).main { result in

        // 5 seconds after the previous block
        // main thread queue

        print("wait 3: \(NSDate().description)")
        return result
    }.run()


```



## License

MIT license. See the LICENSE file for more info.
