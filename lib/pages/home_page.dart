import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quemeudevo/controllers/debt_page_controller.dart';
import 'package:quemeudevo/pages/add_debt_page.dart';
import 'package:quemeudevo/view_models/debt_viewmodel.dart';

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
            final debt = controller.pendantDebts[index];

            return _buildDebtCard(debt);
          }
        );
      },
      ),
      material: (context, platform){
        return MaterialScaffoldData(
          floatingActionButton: FloatingActionButton(
            onPressed: _addNewDebt,
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
          onPressed: _addNewDebt,            
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


  Widget _buildDebtCard(DebtViewModel debt) {
    return GestureDetector(
      onTap: () async{
        bool isChangedList = await Navigator.push(context, 
          Platform.isIOS ? CupertinoPageRoute(builder: (context) => AddDebtPage(existingDebt: debt.toDebtModel()))
          : MaterialPageRoute(builder: (context) => AddDebtPage(existingDebt: debt.toDebtModel()))
        );
        if (isChangedList != null){
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
                Text(debt.personToBePayed,
                  style: TextStyle(
                    color: primaryText,
                    fontSize: 18,                          
                  ),
                ),
                Text(debt.quantity,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 21,      
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text("Devendo desde: ${debt.borrowingDate}"),
            Text("Data de pagamento: ${debt.paymentDate}"),
          ],
        ),
      ),
    );
  }

  void _addNewDebt() async {
    bool isChangedList = await Navigator.push(context, 
      Platform.isIOS ? CupertinoPageRoute(builder: (context) => AddDebtPage())
      : MaterialPageRoute(builder: (context) => AddDebtPage())
    );
    if (isChangedList != null && isChangedList){
      controller.getAllPendantDebts();
    }
  }



}
