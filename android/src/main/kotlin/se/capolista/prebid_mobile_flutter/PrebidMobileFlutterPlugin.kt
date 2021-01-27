package se.capolista.prebid_mobile_flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

/** PrebidMobileFlutterPlugin */
class PrebidMobileFlutterPlugin: FlutterPlugin {

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
    binding
            .platformViewRegistry
            .registerViewFactory("plugins.capolista.se/prebid_mobile_flutter/banner", PrebidBannerViewFactory(binding.binaryMessenger))
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
}
