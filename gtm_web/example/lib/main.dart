import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gtm_web/gtm_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      final gtm = GtmWeb();
      gtm.push(
        'test',
        parameters: {
          'user_no': 912342,
        },
      );
      gtm.push(
        'readCase',
        parameters: {
          'user_no': 912342,
          'user_type': 2,
        },
      );
      gtm.push(
        'buyEduCamp',
        parameters: {
          'user_no': 912342,
          'price': 10000.0,
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
