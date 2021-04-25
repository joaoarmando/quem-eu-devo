import 'package:mobx/mobx.dart';
import 'package:quemeudevo/models/debt_model.dart';

import '../repositories/debt_repository.dart';
import '../view_models/debt_viewmodel.dart';

part 'debt_page_controller.g.dart';

class DebtPageController = _DebtPageControllerBase with _$DebtPageController;

enum DebtStatus{loading, success}

abstract class _DebtPageControllerBase with Store {
  DebtRepository repository;

  _DebtPageControllerBase() {
    repository = DebtRepository();
  }

  ObservableList<DebtViewModel> pendantDebts = ObservableList<DebtViewModel>();

  @observable
  DebtStatus debtStatus = DebtStatus.loading;


  @action
  Future<Null> getAllPendantDebts() async {
      debtStatus = DebtStatus.loading;
      List<DebtModel> debts = await repository.getAllDebtsFromSharedPreferences();
      pendantDebts.clear();
      pendantDebts.addAll(debts.map((debt) => DebtViewModel(debt: debt)).toList());
      debtStatus = DebtStatus.success;
  }
}

