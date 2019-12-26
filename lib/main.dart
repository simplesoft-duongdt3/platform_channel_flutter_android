import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  static const platform =
      const MethodChannel('tinyappsteam.flutter.dev/open_file');

  String openFileUrl;

  @override
  void initState() {
    super.initState();
    getOpenFileUrl();
    // Listen to lifecycle events.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getOpenFileUrl();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Audio file: " + (openFileUrl != null ? openFileUrl : "Nothing!")),
      ),
    );
  }

  void getOpenFileUrl() async {
    dynamic url = await platform.invokeMethod("getOpenFileUrl");
    print("getOpenFileUrl");
    if (url != null && url != openFileUrl) {
      setState(() {
        openFileUrl = url;
      });
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}