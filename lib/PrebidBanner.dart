import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PrebidBanner extends StatefulWidget {
  PrebidBanner({Key key}) : super(key: key);

  @override
  _PrebidBannerState createState() => _PrebidBannerState();
}

class _PrebidBannerState extends State<PrebidBanner> {
  DFPBannerViewController _controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 300, width: 100, child: _build(context));
  }

  Widget _build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'plugins.ercutveckling.se/prebid_mobile_flutter/banner',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'plugins.ercutveckling.se/prebid_mobile_flutter/banner',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    //throw UnsupportedError('Only android and ios are supported.');
    return null;
  }

  void _onPlatformViewCreated(int id) {
    _controller = DFPBannerViewController._internal(id: id);
    _controller._load();
    print("Platform view creatd");
  }
}

class DFPBannerViewController {
  final void Function(DFPBannerViewController controller) onAdViewCreated;
  final Map<String, dynamic> customTargeting;

  DFPBannerViewController._internal({
    this.onAdViewCreated,
    this.customTargeting,
    int id,
  }) : _channel = MethodChannel(
            'plugins.ercutveckling.se/prebid_mobile_flutter/banner/$id');

  final MethodChannel _channel;

  Future<void> reload() {
    return _load();
  }

  Future<void> _load() {
    return _channel.invokeMethod('load');
  }
}
