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
              ListTile(title: Text("THIS IS AN ARTICLE")),
              ListTile(title: Text("THIS IS AN ARTICLE")),
              ListTile(title: Text("THIS IS AN ARTICLE")),
              ListTile(title: Text("THIS IS AN ARTICLE")),
            ])
          ])),
    );
  }
}
