import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


import '../models/debt_model.dart';
import '../view_models/debt_viewmodel.dart';

class DebtRepository {
  SharedPreferences prefs;

  DebtRepository(){    
    initSharedPreferences();
  }

  Future<List<DebtViewModel>> getAllDebtsFromSharedPreferences() async {
      List<DebtViewModel> debts = [];

      if (prefs == null) await initSharedPreferences();
      final debtsFromSharedPreferences = prefs.getString("debts");

      if (debtsFromSharedPreferences != null) {
          List debtsJSON = json.decode(debtsFromSharedPreferences);
          
          debts = debtsJSON.map((debt) =>
            DebtViewModel(debt: DebtModel.fromJson(debt))
          ).toList();

      }
      return debts;
  }
  
  Future<Null> saveDebtsSharedPreferences(List<DebtViewModel> debtList) async{
    final pendantDebtsString = json.encode(debtList.map((e) => e.toJson()).toList());
    prefs.setString("debts", pendantDebtsString);    
  } 

  Future initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }
}