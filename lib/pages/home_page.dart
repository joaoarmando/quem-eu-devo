import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quemeudevo/controllers/debt_page_controller.dart';
import 'package:quemeudevo/pages/add_debt_page.dart';

import '../styles/styles.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  final controller = DebtPageController();
  @override
  void initState() { 
    super.initState();
    controller.getAllPendantDebts();

  }

  @override
  Widget build(BuildContext context) {

    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      appBar: _buildAppBar(),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: controller.pendantDebts.length,
          itemBuilder: (_, index) {
            final pendingDebt = controller.pendantDebts[index];

            return GestureDetector(
              onTap: () async{
               bool isChangedList = await Navigator.push(context, CupertinoPageRoute(builder: (context) => 
                AddDebtPage(existingDebt: pendingDebt.toDebtModel())));
                if (isChangedList != null && isChangedList){
                  controller.getAllPendantDebts();
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal:12, vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: dividerColorSecondary, width: 2)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pendingDebt.personToBePayed,
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 18,                          
                          ),
                        ),
                        Text(pendingDebt.quantity,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 21,      
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text("Devendo desde: ${pendingDebt.borrowingDate}"),
                    Text("Data de pagamento: ${pendingDebt.paymentDate}"),
                  ],
                ),
              ),
            );
          }
        );
      },
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
          onPressed: () async {
            bool isChangedList = await Navigator.push(context, CupertinoPageRoute(builder: (context) => AddDebtPage()));
            if (isChangedList != null && isChangedList){
              controller.getAllPendantDebts();
            }
          },            
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
