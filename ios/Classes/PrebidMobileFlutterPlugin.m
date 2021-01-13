#import "PrebidMobileFlutterPlugin.h"
#if __has_include(<prebid_mobile_flutter/prebid_mobile_flutter-Swift.h>)
#import <prebid_mobile_flutter/prebid_mobile_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "prebid_mobile_flutter-Swift.h"
#endif

@implementation PrebidMobileFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPrebidMobileFlutterPlugin registerWithRegistrar:registrar];
}
@end
