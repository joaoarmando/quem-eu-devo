import 'package:meta/meta.dart';
import 'package:quemeudevo/models/debt_model.dart';

class DebtViewModel {
  DebtModel _debtModel;

  DebtViewModel({@required DebtModel debt}) : _debtModel = debt;


  String get quantity => "R\$:${_debtModel.amount}";
  
  String get description => _debtModel.description;

  String get personToBePayed => _debtModel.personToBePayed;

  String get borrowingDate {
    int timeInMillis = _debtModel.borrowingDate;
    return convertMillisToDate(timeInMillis);
  }

  String get paymentDate {
    int timeInMillis = _debtModel.paymentDate;
    return convertMillisToDate(timeInMillis);
  }
  
  String convertMillisToDate(int timeInMillis) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String day = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String year = date.year.toString();
    return "$day/$month/$year";
  }

  Map<String,dynamic> toJson() => _debtModel.toJson();
  

}