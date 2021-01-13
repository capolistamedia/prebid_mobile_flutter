import Flutter
import UIKit

public class SwiftPrebidMobileFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(PrebidBannerFactory(messenger: registrar.messenger()), withId: "plugins.ercutveckling.se/prebid_mobile_flutter/banner")

    let channel = FlutterMethodChannel(name: "prebid_mobile_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftPrebidMobileFlutterPlugin()

    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
