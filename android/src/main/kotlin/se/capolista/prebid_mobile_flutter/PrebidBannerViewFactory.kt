package se.capolista.prebid_mobile_flutter

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * Factory class of Banner for Android.
 */
class PrebidBannerViewFactory(private val messenger: BinaryMessenger) :
        PlatformViewFactory(StandardMessageCodec.INSTANCE) {


    override fun create(context: Context, id: Int, parameter: Any?): PlatformView {
        return PrebidBannerView(context, id, messenger)
    }

}
