import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let originEvent = EventChannelDemo(messenger: controller.binaryMessenger)
        let channelUtils = FlutterMethodChannel.init(name: "flutter.io/utils",binaryMessenger: controller.binaryMessenger)
        channelUtils.setMethodCallHandler{(call,result) in
            switch(call.method){
            case "cancelTimer":
                originEvent.cancelTimer()
                break
            case "startTimer":
                originEvent.startTimer()
                break
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        //        let controller:FlutterViewController = self.window.rootViewController as! FlutterViewController
        //        let sendOriginMessageEventChannel = FlutterEventChannel.init(name: "receiveOriginMessageEventChannel", binaryMessenger: controller as! FlutterBinaryMessenger)
        //        sendOriginMessageEventChannel.setStreamHandler(FlutterStreamHandler{
        //            override; fun; onli
        //        })
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
