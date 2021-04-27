import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/debt_model.dart';

class DebtRepository {
  SharedPreferences prefs;

  DebtRepository(){    
    initSharedPreferences();
  }

  Future<List<DebtModel>> getAllDebtsFromSharedPreferences() async {
      List<DebtModel> debts = [];
      if (prefs == null) await initSharedPreferences();
      final debtsFromSharedPreferences = prefs.getString("debts");
    
      if (debtsFromSharedPreferences != null) {
          List debtsJSON = json.decode(debtsFromSharedPreferences);
          
          debts = debtsJSON.map((debt) =>
            DebtModel.fromJson(debt)
          ).toList();

      }
      return debts;
  }

  Future<Null> saveDebtsSharedPreferences(DebtModel debt) async{
    List<DebtModel> debtList = await getAllDebtsFromSharedPreferences();
    debtList.add(debt);
    final pendantDebtsString = json.encode(debtList.map((e) => e.toJson()).toList());
    prefs.setString("debts", pendantDebtsString);
  }

  Future<Null> editDebtSharedPreferences(DebtModel debt) async{
    List<DebtModel> debtList = await getAllDebtsFromSharedPreferences();
    for (var i =0; i <debtList.length; i++) {
      if (debtList[i].id == debt.id) {
          debtList[i] = debt;
      }
    }    
    final pendantDebtsString = json.encode(debtList.map((e) => e.toJson()).toList());
    prefs.setString("debts", pendantDebtsString);    
  }

  Future initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}