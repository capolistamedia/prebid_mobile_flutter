import Foundation
import GoogleMobileAds
import PrebidMobile
import AppTrackingTransparency
import AdSupport

class PrebidBannerView: NSObject, FlutterPlatformView, GADBannerViewDelegate {
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
        let argument = call.arguments as! Dictionary<String, Any>
        let publisherId = argument["publisherId"] as? String ?? ""
        let adUnitId = argument["adUnitId"] as? String ?? ""
        let configId = argument["configId"] as? String ?? ""
        let serverHost = argument["serverHost"] as? String ?? ""
        let adHeight = argument["adHeight"] as? Double ?? 0
        let adWidth = argument["adWidth"] as? Double ?? 0

        Prebid.shared.prebidServerAccountId = publisherId
        do {
            try Prebid.shared.setCustomPrebidServer(url: serverHost)
        } catch  {
            print("ERROR")
        }
 
        let adSize = CGSize(width: adWidth, height: adHeight)
        let bannerUnit = BannerAdUnit(configId: configId, size: adSize)
        let bannerView = DFPBannerView(adSize: GADAdSizeFromCGSize(adSize))
        let request = DFPRequest()
        bannerView.adUnitID = adUnitId
        bannerView.delegate = self
        bannerView.rootViewController = UIApplication.shared.delegate!.window!!.rootViewController!
        addBannerViewToView(bannerView)
        bannerView.backgroundColor = UIColor.clear
        
        bannerUnit.fetchDemand(adObject:request) {(ResultCode ) in
            self.channel.invokeMethod("demandFetched", arguments: ["name": ResultCode.name()])
            print("Prebid demand fetch for Google Ad Manager \(ResultCode.name())")
            if #available(iOS 14, *) {
               ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                bannerView.load(request)
               })
            } else {
                bannerView.load(request)
            }
        }
   //     bannerView.load(request)
        result(nil)
    }

    private func addBannerViewToView(_ bannerView: DFPBannerView) {
        container.addSubview(bannerView)
        container.addConstraints([NSLayoutConstraint(item: bannerView,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: container,
                                                        attribute: .centerX,
                                                        multiplier: 1,
                                                        constant: 0),
                                     NSLayoutConstraint(item: bannerView,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: container,
                                                        attribute: .centerY,
                                                        multiplier: 1,
                                                        constant: 0)])
    }
}

