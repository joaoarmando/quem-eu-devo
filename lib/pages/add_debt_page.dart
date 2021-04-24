import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:quemeudevo/styles/styles.dart';

class AddDebtPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(      
      appBar: PlatformAppBar(
        title: Text("Adicionar debito"),
        trailingActions: [
          Platform.isIOS ? PlatformButton(
            padding: const EdgeInsets.all(0),
            child: PlatformText("Salvar",
              style: TextStyle(
                color: primaryAccent,
                fontSize: 18
              ),
            ),
            onPressed: (){},
          ) : SizedBox()
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        children: [
          SizedBox(
            height: 40,
            child: _buildTextField(hint:"Nome", onChanged: (s) {}),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: _buildTextField(hint:"Valor", onChanged: (s) {}),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: _buildTextField(hint:"Descrição", onChanged: (s) {}, maxLines: 4),
          ),
          SizedBox(height: 12),
          _buildDateSecion(description: "Data do empréstimo:", date: "23/04/2021"),
          SizedBox(height: 12),
          _buildDateSecion(description: "Data do pagamento:", date: "30/04/2021"),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pago:"),
              PlatformSwitch(
                value: false, 
                onChanged: (checked) {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextField({@required String hint, @required Function(String) onChanged, int maxLines}) {
    return PlatformTextField(              
      onChanged: onChanged,
      hintText: hint,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      autocorrect: true,
      cupertino: (_,__) => CupertinoTextFieldData(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: dividerColorSecondary, width: 1),
          borderRadius: BorderRadius.circular(5)
        ),
        // maxLines: 4
      ),
    );
  }

  Widget _buildDateSecion({@required String description, String date}){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:12, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: dividerColorSecondary, width: 1),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$description",
            style: TextStyle(
              color: primaryText
            ),
          ),
          Text("$date",
            style: TextStyle(
              color: primaryText
            ),
          ),
        ],
      ),
    );
  }
}