import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/routes/routes_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Safe Entry',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      getPages: RoutesPages.pages,
    );
  }
}
