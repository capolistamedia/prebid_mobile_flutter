import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:prebid_mobile_flutter/prebid_mobile_flutter.dart';

class PrebidBanner extends StatefulWidget {
  final PrebidAdSize adSize;
  final String publisherId;
  final String configId;
  final String adUnitId;
  final String serverHost;
  final void Function(String status) onDemandFetched;
  final Color backgroundColor;
  /**
   * Size
   * publisherID
   * configId
   * adUnitId
   */
  PrebidBanner(
      {@required this.adSize,
      @required this.adUnitId,
      @required this.configId,
      @required this.publisherId,
      @required this.serverHost,
      this.onDemandFetched,
      this.backgroundColor});

  @override
  _PrebidBannerState createState() => _PrebidBannerState();
}

class _PrebidBannerState extends State<PrebidBanner> {
  DFPBannerViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.backgroundColor ?? Colors.grey[300],
        child: SizedBox(
            height: widget.adSize.height,
            width: widget.adSize.width,
            child: _build(context)));
  }

  Widget _build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'plugins.capolista.se/prebid_mobile_flutter/banner',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (Platform.isIOS) {
      return UiKitView(
        viewType: 'plugins.capolista.se/prebid_mobile_flutter/banner',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    //throw UnsupportedError('Only android and ios are supported.');
    return null;
  }

  void _onPlatformViewCreated(int id) {
    _controller = DFPBannerViewController._internal(
        id: id,
        publisherId: widget.publisherId,
        adSize: widget.adSize,
        configId: widget.configId,
        adUnitId: widget.adUnitId,
        serverHost: widget.serverHost,
        onDemandFetched: widget.onDemandFetched);

    _controller._init();
  }
}

class DFPBannerViewController {
  final void Function(DFPBannerViewController controller) onAdViewCreated;
  final Map<String, dynamic> customTargeting;
  final String publisherId;
  final PrebidAdSize adSize;
  final String configId;
  final String adUnitId;
  final String serverHost;
  final void Function(String status) onDemandFetched;

  DFPBannerViewController._internal({
    this.onAdViewCreated,
    this.customTargeting,
    this.adSize,
    this.adUnitId,
    this.configId,
    this.serverHost,
    this.publisherId,
    this.onDemandFetched,
    int id,
  }) : _channel = MethodChannel(Platform.isIOS
            ? 'plugins.capolista.se/prebid_mobile_flutter/banner/$id'
            : 'plugins.capolista.se/prebid_mobile_flutter/banner/$id');

  final MethodChannel _channel;

  Future<void> reload() {
    return _load();
  }

  Future<void> _init() {
    _channel.setMethodCallHandler(_handler);
    return _load();
  }

  Future<void> _load() {
    return _channel.invokeMethod('load', {
      "publisherId": this.publisherId,
      "adHeight": this.adSize.height,
      "adWidth": this.adSize.width,
      "configId": this.configId,
      "adUnitId": this.adUnitId,
      "serverHost": this.serverHost
    });
  }

  Future<void> _handler(MethodCall call) {
    switch (call.method) {
      case "demandFetched":
        onDemandFetched(call.arguments['name']);
        break;
    }
  }
}
