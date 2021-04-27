import 'package:mobx/mobx.dart';
import 'package:quemeudevo/models/debt_model.dart';

import '../repositories/debt_repository.dart';

part 'debt_page_controller.g.dart';

class DebtPageController = _DebtPageControllerBase with _$DebtPageController;

enum DebtStatus{loading, success}

abstract class _DebtPageControllerBase with Store {
  DebtRepository repository;

  _DebtPageControllerBase() {
    repository = DebtRepository();
  }

  ObservableList<DebtModel> pendantDebts = ObservableList<DebtModel>();

  @observable
  DebtStatus debtStatus = DebtStatus.loading;


  @action
  Future<Null> getAllPendantDebts() async {
      debtStatus = DebtStatus.loading;
      pendantDebts.clear();
      pendantDebts.addAll(await repository.getAllDebtsFromSharedPreferences());
      debtStatus = DebtStatus.success;
  }
}

