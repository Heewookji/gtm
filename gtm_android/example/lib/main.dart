import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm_android/gtm_android.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    try {
      final gtm = GtmAndroid()
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
