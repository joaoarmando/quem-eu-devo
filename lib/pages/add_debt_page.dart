import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:quemeudevo/add_debt_page_controller.dart';
import 'package:quemeudevo/models/debt_model.dart';
import 'package:quemeudevo/styles/styles.dart';
import 'package:quemeudevo/view_models/debt_viewmodel.dart';

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
            onPressed: () async {
              if (widget.existingDebt == null) {
                  await controller.saveDebt();
              }
              else await controller.editDebt();
              Navigator.pop(context, true);
            },
          ) : SizedBox()
        ],
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
              initialText: controller.name
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: _buildTextField(hint:"Valor", 
              onChanged: controller.onChangedQuantity, 
              initialText: controller.quantity
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: _buildTextField(hint:"Descrição", 
              onChanged: controller.onChangedDescription, 
              maxLines: 4, 
              initialText: controller.description
            ),
          ),
          SizedBox(height: 12),
          _buildBorrowingDate(description: "Data do empréstimo:", date: controller.borrowingDateString),
          SizedBox(height: 12),
          _buildPaymentDate(description: "Data do pagamento:", date: controller.paymentDateString),
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
          )
        ],
      )
    );
  }

  Widget _buildTextField({@required String hint, @required Function(String) onChanged, int maxLines = 1, @required String initialText}) {
    return PlatformTextField(              
      onChanged: onChanged,
      hintText: hint,      
      maxLines: maxLines,
      controller: TextEditingController(text: initialText)..selection = TextSelection.fromPosition(TextPosition(offset: initialText.length)),
      textAlign: TextAlign.start,
      onTap: controller.hideDatePickers,
      autocorrect: true,
      cupertino: (_,__) => CupertinoTextFieldData(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: dividerColorSecondary, width: 1),
          borderRadius: Platform.isIOS ?  BorderRadius.zero : BorderRadius.circular(5)
        ),
        // maxLines: 4
      ),
    );
  }

  Widget _buildBorrowingDate({@required String description, String date}) {
    return GestureDetector(
      onTap: controller.showBorrowingDatePicker,
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
                  height: controller.showingBorrowingDatePicker ? 200 : 0.1, // for some reason when parent of CupertinoDatePicker is 0 flutter throws an exception (issue: 55630)
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
      onTap: controller.showPaymentDatePicker,
      child: Observer(builder: (_) {
        print("initialYear: ${controller.paymentDate.year}");
        print("minimumYear: ${controller.borrowingDate.year}");
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
                  height: controller.showingPaymentDatePicker ? 200 : 0.1, // for some reason when parent of CupertinoDatePicker is 0 flutter throws an exception (issue: 55630)
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
}