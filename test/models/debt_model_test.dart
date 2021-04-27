import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quemeudevo/models/debt_model.dart';

main() {
  Map<String,dynamic> json;
  DebtModel debtModel;
  setUp(() {
    json = {
      "amount": faker.randomGenerator.decimal(scale: 5),
      "description": faker.lorem.sentence(),
      "paymentDate": faker.date.dateTime().millisecondsSinceEpoch,
      "borrowingDate": faker.date.dateTime().millisecondsSinceEpoch,
      "personToBePayed":faker.person.name(),
      "createdAt": faker.date.dateTime().millisecondsSinceEpoch,
      "payed": faker.randomGenerator.boolean(),
      "id": faker.guid.guid()
    };
    debtModel = DebtModel.fromJson(json);
  });
   
  test('Should convert a JSON to DebtModel with success', () {
      expect(debtModel.amount, isA<double>());
      expect(debtModel.description, isA<String>());
      expect(debtModel.paymentDate, isA<int>());
      expect(debtModel.borrowingDate, isA<int>());
      expect(debtModel.personToBePayed, isA<String>());
      expect(debtModel.id, isA<String>());
      expect(debtModel.payed, isA<bool>());
  });
}