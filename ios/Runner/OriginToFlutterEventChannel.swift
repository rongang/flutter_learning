import Flutter
import UIKit

public class EventChannelDemo:NSObject, FlutterStreamHandler{
    
    var channel:FlutterEventChannel?
    var count:Int?
    var events:FlutterEventSink?
    
    public override init() {
        super.init()
    }
    
    convenience init(messenger: FlutterBinaryMessenger) {
        
        self.init()
        
        channel = FlutterEventChannel(name: "receiveOriginMessageEventChannel", binaryMessenger: messenger)
        channel?.setStreamHandler(self)
        //        startTimer()
    }
    var timer:Timer?
    func startTimer() {
        count=0
        timer = Timer.scheduledTimer(timeInterval:1, target: self, selector:#selector(self.tickDown),userInfo:nil,repeats: true)
    }
    func cancelTimer(){
        timer?.invalidate()
    }
    @objc func tickDown(){
        count! += 1
        let args = ["count":count]
        if(events != nil){
            events!(args)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        return nil;
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.events = nil
        return nil;
    }

}


