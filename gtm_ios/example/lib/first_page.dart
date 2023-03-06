import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm_ios/gtm_ios.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    try {
      final gtm = GtmIOS()
        ..setCustomTagHandler(
          (event, arguments) async {
            print(event);
            print(arguments);
            return;
          },
        );
      gtm.getPlatformVersion();
    } on PlatformException {
      print('exception occurred!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(),
    );
  }
}
