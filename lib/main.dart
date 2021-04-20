import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'pages/home_page.dart';
import 'styles/styles.dart';

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
      material: (_,__) => MaterialAppData(
        theme: ThemeData(
          accentColor: primaryAccent,
          backgroundColor: primaryAccent,
          scaffoldBackgroundColor: secondaryBackgroundColor,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            backgroundColor: backgroundColor,
            brightness: Brightness.dark,            
          ),
        )
      ),
      cupertino: (_,__) => CupertinoAppData(
        theme: CupertinoThemeData(
          primaryColor: primaryText,
          primaryContrastingColor: primaryAccent,
          scaffoldBackgroundColor: secondaryBackgroundColor,
          barBackgroundColor: backgroundColor,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              color: primaryText,
            ),
          )
        )
      ),
    );
  }
}
