import 'package:flutter_test/flutter_test.dart';
import 'package:quemeudevo/models/debt_model.dart';
import 'package:quemeudevo/repositories/debt_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {

  DebtRepository repository;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues ({
      "debts": mockResponse
    });
    repository = DebtRepository();
  });

  test('Should save new Debt with success', () async {
    final newDebt = DebtModel(
      amount: 25.50,
      description: "Empréstimo para o mercado",
      payed: false,
      borrowingDate: 1619540599000,
      paymentDate: 1622132599000,
      createdAt: 1619540599000,
      id: "1619540599000",
      personToBePayed: "Solange"
    );
    await repository.saveDebtsSharedPreferences(newDebt);
    final savedDebts = await repository.getAllDebtsFromSharedPreferences();
    expect(savedDebts[1].id, "1619540599000");
  });

  test('Should return a list of DebtModel with the correct values', () async {
    final savedDebts = await repository.getAllDebtsFromSharedPreferences();
    DebtModel debt = savedDebts[0];
    expect(debt.personToBePayed, "Joao");
    expect(debt.description, "Peguei emprestado para ir ao cinema.");
    expect(debt.id, "1619539814028");
    expect(debt.amount, 35.5);
    expect(debt.paymentDate, 1620144568805);
    expect(debt.borrowingDate, 1619539768806);
    expect(debt.createdAt, 1619539814028);
    expect(debt.payed, false);
  });

  test('Should edit an existing debt with success', () async {
    List<DebtModel> savedDebts = await repository.getAllDebtsFromSharedPreferences();
    DebtModel debt = savedDebts[0];
    debt.personToBePayed = "Marcos";
    await repository.editDebtSharedPreferences(debt);
    savedDebts = await repository.getAllDebtsFromSharedPreferences();
    expect(savedDebts[0].personToBePayed, "Marcos"); 
  });

}
String mockResponse = '[{"amount":35.5,"description":"Peguei emprestado para ir ao cinema.","paymentDate":1620144568805,"borrowingDate":1619539768806,"personToBePayed":"Joao","createdAt":1619539814028,"payed":false,"id":"1619539814028"}]';