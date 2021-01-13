import Foundation
//import GoogleMobileAds

class PrebidBannerView: NSObject, FlutterPlatformView {
    private var container: UIView!
    private let channel: FlutterMethodChannel!

    init(frame: CGRect, viewIdentifier viewId: Int64, messenger: FlutterBinaryMessenger) {
        container = UIView(frame: frame)
        channel = FlutterMethodChannel(name: "plugins.ercutveckling.se/prebid_mobile_flutter/banner/\(viewId)", binaryMessenger: messenger)

        super.init()

        //container.backgroundColor = UIColor.clear
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            self.handle(call, result: result)
        })
    }

    func view() -> UIView {
        return container
    }

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "load":
            load(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func load(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.black
        container.backgroundColor = UIColor.green
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        addBannerViewToView(nativeLabel);
        result(nil)
    }

    private func addBannerViewToView(_ bannerView: UILabel) {
        container.addSubview(bannerView)
    }
}
