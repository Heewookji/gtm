import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm_ios/gtm_ios.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';

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
        ..setCustomTagTypes([
          CustomTagType(
            'amplitude',
            handler: (eventName, parameters) {
              print('amplitude!');
              print(eventName);
              print(parameters);
            },
          ),
        ]);
      gtm.push(
        'test',
        parameters: {
          'user_no': 912342,
        },
      );
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
