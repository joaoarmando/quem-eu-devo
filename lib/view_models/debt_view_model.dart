import 'package:meta/meta.dart';
import 'package:quemeudevo/models/debt_model.dart';

class DebtViewModel {
  DebtModel _debtModel;

  DebtViewModel({@required DebtModel debt}) : _debtModel = debt;


  String get quantity => _debtModel.amount;
  
  String get description => _debtModel.description;

  String get borrowingDate => _debtModel.borrowingDate;

  String get paymentDate => _debtModel.paymentDate;

  String get personToBePayed => _debtModel.personToBePayed;
  
}