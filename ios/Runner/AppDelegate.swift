import Flutter
import UIKit
import Photos

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  let saveImageChannel = FlutterMethodChannel(name: "save-file" , binaryMessenger : controller.binaryMessenger)

  saveImageChannel.setMethodCallHandler({
  (call: FlutterMethodCall , result : @escaping FlutterResult) ->

   })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func saveFile(_filePath : String , _mediaType)
}

