import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:quemeudevo/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return PlatformApp(
      title: 'Quem eu Devo',      
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
