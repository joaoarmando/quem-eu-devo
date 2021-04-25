import 'dart:async';
import 'dart:ffi';

import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';
import 'package:quemeudevo/repositories/debt_repository.dart';

import 'models/debt_model.dart';
part 'add_debt_page_controller.g.dart';

class AddDebtPageController = _AddDebtPageControllerBase with _$AddDebtPageController;

abstract class _AddDebtPageControllerBase with Store {

  DebtModel debt;
  _AddDebtPageControllerBase(this.debt) {
    if (this.debt != null) {
        quantity = debt.amount.toStringAsFixed(2);
        name = debt.personToBePayed;
        description = debt.description;
        paymentDate = DateTime.fromMicrosecondsSinceEpoch(debt.paymentDate);
        borrowingDate = DateTime.fromMicrosecondsSinceEpoch(debt.borrowingDate);
    }
  }

  DebtRepository repository = DebtRepository();

  @observable
  bool showingBorrowingDatePicker = false;

  @observable
  bool showingPaymentDatePicker = false;

  @observable
  bool payed = false;

  @observable
  String name = "";

  @observable
  String quantity = "";

  @observable
  String description = "";

  @observable
  DateTime paymentDate;
  @observable

  DateTime borrowingDate;

  @action
  void onChangedName(String value) => name = value;
  
  @action
  void onChangedQuantity(String value){
     quantity = value;
     print(quantity);
  }
  
  @action
  void onChangedDescription(String value) => description = value;

  @action
  void showBorrowingDatePicker() {
    hideDatePickers();
    showingBorrowingDatePicker = true; 
  }

  @action
  void showPaymentDatePicker(){
    hideDatePickers();
    showingPaymentDatePicker = true; 
  }

  @action
  void changeBorrowingDate(DateTime date) {
    borrowingDate = date;
  }
  
  @action
  void changePaymentDate(DateTime date) {
    paymentDate = date; 
  }

  @action
  void hideDatePickers() {
    showingBorrowingDatePicker = false;
    showingPaymentDatePicker = false;
  }

  @action
  void changePayedState(bool value) => payed = value;


  Future<Null> saveDebt() async {
    debt = DebtModel(
      personToBePayed: name,
      description: description,
      paymentDate: paymentDate.millisecondsSinceEpoch,
      borrowingDate: borrowingDate.millisecondsSinceEpoch,
      amount: double.parse(quantity),
      createdAt: DateTime.now().millisecondsSinceEpoch
    );
    await repository.saveDebtsSharedPreferences(debt);
    return;
  }

  Future<Null> editDebt() async {
    debt.personToBePayed = name;
    debt.description = description;
    debt.paymentDate = paymentDate.millisecondsSinceEpoch;
    debt.borrowingDate = borrowingDate.millisecondsSinceEpoch;
    debt.amount = double.parse(quantity);
    await repository.saveDebtsSharedPreferences(debt);
    return;
  }
}