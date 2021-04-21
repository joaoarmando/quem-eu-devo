import 'package:meta/meta.dart';
import 'package:quemeudevo/models/debt_model.dart';

class DebtViewModel {
  DebtModel _debtModel;

  DebtViewModel({@required DebtModel debt}) : _debtModel = debt;


  String get quantity => _debtModel.amount;
  
  String get description => _debtModel.description;

  String get borrowingDate {
    int timeInMillis = _debtModel.borrowingDate;
    return convertMillisToDate(timeInMillis);
  }

  String get paymentDate {
    int timeInMillis = _debtModel.paymentDate;
    return convertMillisToDate(timeInMillis);
  }


  String get personToBePayed => _debtModel.personToBePayed;


  String convertMillisToDate(int timeInMillis) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    return "${date.day}/${date.month}/${date.year}";
  }

  Map<String,dynamic> toJson() => _debtModel.toJson();
  

}