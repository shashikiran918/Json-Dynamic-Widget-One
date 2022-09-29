import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const RenderingWidget());
  }
}

class RenderingWidget extends StatefulWidget {
  const RenderingWidget({Key? key}) : super(key: key);

  @override
  _RenderingWidgetState createState() => _RenderingWidgetState();
}

class _RenderingWidgetState extends State<RenderingWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          var widgetJson = json.decode(snapshot.data!.toString());
          var widget = JsonWidgetData.fromDynamic(widgetJson);
          return widget!.build(context: context);
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      future: DefaultAssetBundle.of(context).loadString('assets/json/sample.json'),
    );
  }
}
