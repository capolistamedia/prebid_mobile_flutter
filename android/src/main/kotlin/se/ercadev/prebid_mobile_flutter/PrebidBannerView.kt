package se.ercadev.prebid_mobile_flutter



import android.util.Log

import com.google.android.gms.ads.doubleclick.PublisherAdView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

import android.view.ViewGroup
import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import com.google.android.gms.ads.AdListener
import com.google.android.gms.ads.AdSize
import com.google.android.gms.ads.MobileAds
import com.google.android.gms.ads.doubleclick.PublisherAdRequest
import org.prebid.mobile.*
import org.prebid.mobile.addendum.AdViewUtils
import org.prebid.mobile.addendum.PbFindSizeError


/**
 * Banner of Google Ad Manger.
 */

class PrebidBannerView(private val context: Context, id: Int, messenger: BinaryMessenger) : PlatformView,
        MethodChannel.MethodCallHandler {
    private val container: ViewGroup?
    internal var adUnit: AdUnit? = null
    private var publisherAdView: PublisherAdView? = null

    private val channel = MethodChannel(messenger, "plugins.ercadev.se/prebid_mobile_flutter/banner/$id")

    init {
        channel.setMethodCallHandler(this)
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

        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "load" -> load(methodCall, result)
            else -> result.notImplemented()
        }
    }

    private fun load(call: MethodCall, result: MethodChannel.Result) {
        val arguments: Map<String, Any> = call.arguments()
        val adUnitId = arguments["adUnitId"] as String
        val publisherId = arguments["publisherId"] as String
        val serverHost = arguments["serverHost"] as String
        val configId = arguments["configId"] as String
        val adHeight = arguments["adHeight"] as Double
        val adWidth = arguments["adWidth"] as Double
        Host.CUSTOM.hostUrl = serverHost;
        PrebidMobile.setPrebidServerHost(Host.CUSTOM);
        MobileAds.initialize(context)
        PrebidMobile.setPrebidServerAccountId(publisherId);
        PrebidMobile.setApplicationContext(context)
        container?.removeAllViews()
        publisherAdView?.destroy()

        var builder = PublisherAdRequest.Builder()
        this.publisherAdView = PublisherAdView(context);
        adUnit = BannerAdUnit(configId, adWidth.toInt(),adHeight.toInt())
        publisherAdView?.adUnitId = adUnitId
        publisherAdView?.setAdSizes(AdSize(adWidth.toInt(),adHeight.toInt()))
        publisherAdView?.visibility = View.VISIBLE
        container?.addView(publisherAdView)
        val publisherAdRequest = builder.build()

        adUnit!!.fetchDemand(builder, object : OnCompleteListener {
            override fun onComplete(resultCode: ResultCode) {
                channel.invokeMethod("demandFetched", mapOf("name" to resultCode.toString()))
                publisherAdView?.loadAd(builder.build());
            }
        })

        publisherAdView?.setAdListener(object: AdListener() {
            override fun onAdLoaded() {
                super.onAdLoaded()

                AdViewUtils.findPrebidCreativeSize(publisherAdView, object : AdViewUtils.PbFindSizeListener {
                    override fun success(width: Int, height: Int){
                        publisherAdView?.setAdSizes(AdSize(width, height))
                    }

                    override fun failure(error: PbFindSizeError) {
                        Log.d("Error", "error :$error")
                    }
                })
            }
        })




    }





}