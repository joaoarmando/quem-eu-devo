import 'package:flutter_test/flutter_test.dart';
import 'package:quemeudevo/models/debt_model.dart';
import 'package:quemeudevo/view_models/debt_viewmodel.dart';

main() {
  DebtViewModel model;

  setUp(() {
    model = DebtViewModel(debt: DebtModel(
      amount: 10, 
      paymentDate: 1619280741000, 
      borrowingDate: 1618071141000, 
      personToBePayed: "Sueli", 
      createdAt: 1619280741000
    ));
  });

  test('Should return the name of the person to be payed', () {
    String personToBePayed = model.personToBePayed;
    expect(personToBePayed, equals("Sueli")); 
  });

  test('Should return the debt value', () {
    String quantity = model.quantity;
    expect(quantity, equals("R\$:10.00")); 
  });

  test('Should return the correct Payment Date(String) when given the date in millis', () {
    String paymentDate = model.paymentDate;
    expect(paymentDate, equals("24/04/2021")); 
  });

  test('Should return the correct Borrowing Date(String) when given the date in millis', () {
    String borrowingDate = model.borrowingDate;
    expect(borrowingDate, equals("10/04/2021")); 
  });
}