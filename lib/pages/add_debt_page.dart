import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../controllers/add_debt_page_controller.dart';
import '../models/debt_model.dart';
import '../styles/styles.dart';


class AddDebtPage extends StatefulWidget {
  final DebtModel existingDebt;
  AddDebtPage({this.existingDebt});

  @override
  _AddDebtPageState createState() => _AddDebtPageState();
}

class _AddDebtPageState extends State<AddDebtPage> {
  AddDebtPageController controller;

  @override
  void initState() {
    super.initState();
    controller = AddDebtPageController(widget.existingDebt);
  }

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
            onPressed: _saveOrEditDebt,
          ) : SizedBox()
        ],
        leading: PlatformIconButton(
          padding: EdgeInsets.zero,
            icon: Icon( Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: primaryAccent),
            onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: Platform.isIOS ? 0 : 12, vertical: 24),
        children: [
          Text("Informações do empréstimo",
            style: TextStyle(
              color: secondaryText,
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: _buildTextField(hint:"Nome", 
              onChanged: controller.onChangedName, 
              initialText: controller.name,
              keyboardType: TextInputType.name
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: _buildTextField(hint:"Valor", 
              onChanged: controller.onChangedQuantity, 
              initialText: controller.quantity,
              keyboardType: TextInputType.numberWithOptions(decimal: true)
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: _buildTextField(hint:"Descrição", 
              onChanged: controller.onChangedDescription, 
              maxLines: 4, 
              initialText: controller.description,
              keyboardType: TextInputType.text
            ),
          ),
          SizedBox(height: 12),
          Observer(builder: (_) => _buildBorrowingDate(description: "Data do empréstimo:", date: controller.borrowingDateString)),
          SizedBox(height: 12),
          Observer(builder: (_) => _buildPaymentDate(description: "Data do pagamento:", date: controller.paymentDateString)),          
          SizedBox(height: 12),
          Observer(builder: (_) {
            return _buildCardSection(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pago:"),
                    PlatformSwitch(
                      value: controller.payed, 
                      onChanged: (isChecked) {
                        controller.changePayedState(isChecked);
                        controller.hideDatePickers();
                      },
                    ),
                  ],
                )
              );
          },
          ),

          Platform.isIOS ? Container() : _androidSaveButton()

        ],
      )
    );
  }

  Widget _buildTextField({@required String hint, @required Function(String) onChanged, 
    int maxLines = 1, @required String initialText, TextInputType keyboardType = TextInputType.text }) {
    return PlatformTextField(              
      onChanged: onChanged,
      hintText: hint,      
      maxLines: maxLines,
      controller: TextEditingController(text: initialText)..selection = TextSelection.fromPosition(TextPosition(offset: initialText.length)),
      textAlign: TextAlign.start,
      onTap: controller.hideDatePickers,
      keyboardType: keyboardType,
      autocorrect: true,
      cupertino: (_,__) => CupertinoTextFieldData(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: dividerColorSecondary, width: 1),
          borderRadius: Platform.isIOS ?  BorderRadius.zero : BorderRadius.circular(5)
        ),
        // maxLines: 4
      ),
      material: (_,__) => MaterialTextFieldData(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          labelText: hint
        )
      ),
    );
  }

  Widget _buildBorrowingDate({@required String description, String date}) {
    return GestureDetector(
      onTap: () async {
        if (Platform.isIOS) controller.showBorrowingDatePicker();
        else {
          DateTime pickedDate = await showDatePicker(context: context, 
            initialDate: controller.borrowingDate, 
            firstDate: DateTime.now(), 
            lastDate: DateTime(2050),
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                dialogBackgroundColor: secondaryBackgroundColor,
                colorScheme: ColorScheme.dark(
                  primary: primaryAccent,
                  onPrimary: primaryText,
                  surface: backgroundColor,
                  onSurface: primaryAccent,
                ),
                ),
                child: child,
              );
            }            
          );
          if (pickedDate != null) controller.changeBorrowingDate(pickedDate);          
        }
      },
      child: Observer(builder: (_) {
         return _buildCardSection(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Data do empréstimo:",
                      style: TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text("$date",
                      style: TextStyle(
                        color: secondaryText
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: controller.showingBorrowingDatePicker ? 200 : 0, // for some reason when parent of CupertinoDatePicker is 0 flutter throws an exception (issue: 55630)
                  child: CupertinoDatePicker(
                    initialDateTime: controller.borrowingDate,
                    minimumYear: DateTime.now().year,
                    maximumYear: 2050,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: controller.changeBorrowingDate,
                  ),
                )
              ],
            ),
          )
        );
      },
      ),
    );
  }

  Widget _buildPaymentDate({@required String description, String date}) {
    return GestureDetector(
      onTap: () async{
        if (Platform.isIOS) controller.showPaymentDatePicker();
        else {
          DateTime pickedDate = await showDatePicker(context: context, 
            initialDate: controller.paymentDate, 
            firstDate: controller.borrowingDate, 
            lastDate: DateTime(2050),
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.dark().copyWith(
                dialogBackgroundColor: secondaryBackgroundColor,
                colorScheme: ColorScheme.dark(
                  primary: primaryAccent,
                  onPrimary: primaryText,
                  surface: backgroundColor,
                  onSurface: primaryAccent,
                ),
                ),
                child: child,
              );
            } 
          );
          if (pickedDate != null) controller.changePaymentDate(pickedDate);          
        }
        
      },
      child: Observer(builder: (_) {
         return _buildCardSection(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Data do do pagamento:",
                      style: TextStyle(
                        color: primaryText,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text("$date",
                      style: TextStyle(
                        color: secondaryText
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: controller.showingPaymentDatePicker ? 200 : 0, // for some reason when parent of CupertinoDatePicker is 0 flutter throws an exception (issue: 55630)
                  child: CupertinoDatePicker(
                    initialDateTime: controller.paymentDate,
                    minimumDate: controller.borrowingDate,
                    maximumYear: 2050,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: controller.changePaymentDate,
                  ),
                )
              ],
            ),
          )
        );
      },
      ),
    );
  }

  Widget _buildCardSection(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:12, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: dividerColorSecondary, width: 1),
        borderRadius: Platform.isIOS ?  BorderRadius.zero : BorderRadius.circular(5)
      ),
      child: child,
    );
  }

  Widget _androidSaveButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical:24),
      width: MediaQuery.of(context).size.width *.75,
      height: 50,
      decoration: BoxDecoration(
        color: primaryAccent,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: _saveOrEditDebt,
          splashColor: backgroundColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(5),
          child: Center(
            child: Text("Salvar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _saveOrEditDebt() async {
    if (widget.existingDebt == null) {
        await controller.saveDebt();
    }
    else await controller.editDebt();
    Navigator.pop(context, true);
  }
}