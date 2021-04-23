import 'package:flutter_test/flutter_test.dart';
import 'package:quemeudevo/repositories/debt_repository.dart';



main() {
  final repository = DebtRepository();


  test('Should save a list of DebtModel', () {
    // repository.saveDebtsSharedPreferences(debtList);
  }, skip: 'Ainda não implementado');

  test('Should return a list of DebtModel', () async {
    final list = await repository.getAllDebtsFromSharedPreferences();

  }, skip: 'Ainda não foi implementado');
}