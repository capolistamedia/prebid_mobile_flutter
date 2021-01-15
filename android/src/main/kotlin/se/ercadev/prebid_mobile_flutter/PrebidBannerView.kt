package se.ercadev.prebid_mobile_flutter


import android.content.Context
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import com.google.android.gms.ads.AdListener
import com.google.android.gms.ads.AdRequest
import com.google.android.gms.ads.AdSize
import com.google.android.gms.ads.doubleclick.PublisherAdRequest
import com.google.android.gms.ads.doubleclick.PublisherAdView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import org.prebid.mobile.*

class PrebidBannerView(private val context: Context, id: Int, messenger: BinaryMessenger) :PlatformView, MethodChannel.MethodCallHandler {
    private var container: ViewGroup?
    private var publisherAdView: PublisherAdView? = null
    private var adUnit: AdUnit? = null
    private val channel = MethodChannel(messenger, "plugins.ercadev.se/prebid_mobile_flutter/banner/$id")

    init {
        channel.setMethodCallHandler(this)
        Host.CUSTOM.hostUrl = "https://lwadm.com/openrtb2/auction"
        PrebidMobile.setPbsDebug(true)
        PrebidMobile.setPrebidServerHost(Host.CUSTOM)
        PrebidMobile.setApplicationContext(context)
        PrebidMobile.setPrebidServerAccountId("8a84dd34-ea31-43c5-96e5-cd8de12e5ea6")
        container = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            layoutParams = LinearLayout.LayoutParams(
                    LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT
            )
            descendantFocusability = ViewGroup.FOCUS_BLOCK_DESCENDANTS
        }

    }

    override fun getView() = container
    override fun dispose() {
        publisherAdView?.pause()
        publisherAdView?.adListener = null
        publisherAdView?.destroy()
        val parent = publisherAdView?.parent
        if (parent is ViewGroup) {
            parent.removeView(publisherAdView)
        }
        container?.removeAllViews()
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "load" -> load(methodCall, result)
            else -> result.notImplemented()
        }
    }
    private fun load(call: MethodCall, result: MethodChannel.Result) {
        Log.v("Loading ads",PrebidMobile.getPbsDebug().toString())

        val builder = PublisherAdRequest.Builder()
        val publisherAdRequest = builder.build()
       // var bannerUnit = BannerAdUnit("8a84dd34-ea31-43c5-96e5-cd8de12e5ea6",320,320)
        adUnit = BannerAdUnit("8a84dd34-ea31-43c5-96e5-cd8de12e5ea6",320,320)
        this.publisherAdView = PublisherAdView(context)
        publisherAdView?.adUnitId = "/3953516/leeads-test/apptestfotbollsthlm"
        publisherAdView?.setAdSizes(AdSize(320,320))
        publisherAdView?.visibility = View.VISIBLE
        container?.addView(publisherAdView)

        adUnit!!.fetchDemand(builder) { resultCode ->
            Log.v("Resultcode from prebid", resultCode.name)
            publisherAdView?.loadAd(builder.build())
        }

    }
}