import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:quemeudevo/repositories/debt_repository.dart';

import '../models/debt_model.dart';

part 'add_debt_page_controller.g.dart';

class AddDebtPageController = _AddDebtPageControllerBase with _$AddDebtPageController;

abstract class _AddDebtPageControllerBase with Store {
  Timer timerBorrowingDate;
  DebtModel debt;
  _AddDebtPageControllerBase(this.debt) {
    if (this.debt != null) {
        quantity = debt.amount.toStringAsFixed(2);
        name = debt.personToBePayed;
        payed = debt.payed;
        description = debt.description;
        paymentDate = DateTime.fromMillisecondsSinceEpoch(debt.paymentDate) ;
        borrowingDate = DateTime.fromMillisecondsSinceEpoch(debt.borrowingDate);
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
  DateTime paymentDate = DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch + 604800000000);  //Default starts 1 week after today

  @observable
  DateTime borrowingDate = DateTime.now();

  @computed
  String get paymentDateString => convertDateToString(paymentDate);

  @computed
  String get borrowingDateString => convertDateToString(borrowingDate);

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
    //Use this timer to avoid instantly update.
    if (timerBorrowingDate != null) timerBorrowingDate.cancel();
    timerBorrowingDate = Timer(Duration(milliseconds: 100),(){
      borrowingDate = date;
      paymentDate = date;
    });
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
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      payed: payed
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
    debt.payed = payed;
    await repository.editDebtSharedPreferences(debt);
    return;
  }

  String convertDateToString(DateTime date) {
    String day = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String year = date.year.toString();
    return "$day/$month/$year";
  }
}