import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:flutter/material.dart';
import 'package:quemeudevo/styles/styles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Text("Hello from Home!")
        ],
      ),
      material: (context, platform){
        return MaterialScaffoldData(
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.add),
          )
        );
      },      
    );
  }

  Widget _buildAppBar() {
    return PlatformAppBar(
      title: Text("Pendente"),
      trailingActions: [
        Platform.isIOS ? PlatformButton(
          padding: const EdgeInsets.all(0),
          onPressed: (){},            
          child: Text("+ Novo",
            style: TextStyle(
              color: primaryAccent,
              fontSize: 18
            ),
          ),
        ) : SizedBox(),
      ]
    );
  }
}