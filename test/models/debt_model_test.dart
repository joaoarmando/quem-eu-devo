import 'package:flutter_test/flutter_test.dart';
import 'package:quemeudevo/models/debt_model.dart';

main() {
  Map<String,dynamic> json;
  DebtModel debtModel;
  setUp(() {
    json = {
      "amount": 10.90,
      "description": "Pagamento da passagem",
      "paymentDate": 1619563526000,
      "borrowingDate": 1619131526000,
      "personToBePayed":"Gabriel",
      "createdAt": 1619563526000,
      "payed": true,
      "id": "1619563526000"
    };
    debtModel = DebtModel.fromJson(json);
  });
   
  test('Should convert a JSON to DebtModel with success', () {
      expect(debtModel.amount, equals(10.90));
      expect(debtModel.description, equals("Pagamento da passagem"));
      expect(debtModel.paymentDate, equals(1619563526000));
      expect(debtModel.borrowingDate, equals(1619131526000));
      expect(debtModel.personToBePayed, equals("Gabriel"));
      expect(debtModel.createdAt, 1619563526000);
      expect(debtModel.id, "1619563526000");
      expect(debtModel.payed, true);
  });

  test('Should return the debt value', () {
    String quantity = debtModel.quantity;
    expect(quantity, equals("R\$:10,90")); 
  });

  test('Should return the correct Payment Date(String) when given the date in millis', () {
    String paymentDate = debtModel.paymentDateConverted;
    expect(paymentDate, equals("27/04/2021")); 
  });

  test('Should return the correct Borrowing Date(String) when given the date in millis', () {
    String borrowingDate = debtModel.borrowingDateConverted;
    expect(borrowingDate, equals("22/04/2021")); 
  });
}