import 'package:flutter/widgets.dart';

class PrebidBanner extends StatefulWidget {
  PrebidBanner({Key key}) : super(key: key);

  @override
  _PrebidBannerState createState() => _PrebidBannerState();
}

class _PrebidBannerState extends State<PrebidBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("This is a prebid ad"),
    );
  }
}
