import 'package:flutter/material.dart';

import 'package:prebid_mobile_flutter/prebid_mobile_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ListView(children: [
            Column(children: [
              ListTile(title: Text("THIS IS AN ARTICLE")),
              PrebidBanner(
                adSize: PrebidAdSize(320, 320),
                publisherId: "8a84dd34-ea31-43c5-96e5-cd8de12e5ea6",
                adUnitId: "/3953516/leeads-test/apptestfotbollsthlm",
                configId: "fotbollsthlm_desktop-app-1-ios",
                serverHost: "http://lwadm.com/openrtb2/auction",
                onDemandFetched: (String status) {
                  print("Prebid status: " + status);
                },
              ),
              ListTile(title: Text("THIS IS AN ARTICLE")),
              ListTile(title: Text("THIS IS AN ARTICLE")),
              ListTile(title: Text("THIS IS AN ARTICLE")),
              ListTile(title: Text("THIS IS AN ARTICLE")),
            ])
          ])),
    );
  }
}
