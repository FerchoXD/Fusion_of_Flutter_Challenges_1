import 'package:flutter/material.dart';
import 'package:merging_of_applications/Presentation/pages/http_page.dart';
import 'package:merging_of_applications/Presentation/pages/scaffold_page.dart';
import 'package:merging_of_applications/Presentation/pages/stateful_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/scaffold': (context) => ScaffoldPage(),
        '/stateful': (context) => StatefulPage(),
        '/http': (context) => HttpPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/scaffold'),
            child: Text('Scaffold Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/stateful'),
            child: Text('Stateful Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/http'),
            child: Text('HTTP Page'),
          ),
        ],
      ),
    );
  }
}
