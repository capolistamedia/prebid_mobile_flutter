# prebid_mobile_flutter

## This is an unofficial flutter plugin for Prebid Mobile SDK

This plugin will display header bidding ads through the native [Prebid Mobile SDK](https://docs.prebid.org/prebid-mobile/prebid-mobile.html)

⚠️  Please be aware that even though the plugin can be used in production it should be used with caution due to its age. It can contain bugs that is not yet discovered. File an issue if you have any problems.  

## Features

Will gladly accept pull requests on more features.

### Ad renderer
:white_check_mark: - Google Ad Manager

### Ad types
:white_check_mark: - Banner Ads


## Gettings started

Setup your app by reading the Google Ad Manager Docs

[Android](https://developers.google.com/ad-manager/mobile-ads-sdk/android/quick-start)

[iOS](https://developers.google.com/ad-manager/mobile-ads-sdk/ios/quick-start)

Then add a Prebid banner in you Flutter app

If your app is not building it's probably because you have not set up the Google Ad Manager settings correctly

```
PrebidBanner(
   backgroundColor: Colors.green,
   adSize: PrebidAdSize(320, 320),
   publisherId: "xxx",
   adUnitId: "xxx",
   configId: "xxx",
   serverHost: "xxx",
   onDemandFetched: (String status) {
      print("Prebid status: " + status);
   },
),
```

