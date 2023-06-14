import 'package:flutter/material.dart';
import 'package:task1_app/screens/View_List.dart';
//import 'package:task1_app/screens/table_view.dart';
import 'package:task1_app/screens/table_view2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Details Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Details"),
            bottom: const TabBar(tabs: [
              Tab(
                text: "List",
              ),
              Tab(
                text: "Table",
              )
            ]),
          ),
          body: const TabBarView(children: [
            ListViewer(),
            //TableView(),
            TableView2()
            
          ]),
        ));
  }
}
