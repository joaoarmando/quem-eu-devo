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
      pendantDebts.addAll(await repository.getAllDebtsFromSharedPreferences());
      debtStatus = DebtStatus.success;
  }

  @action
  Future<Null> saveAllPendantDebts() async {
      pendantDebts.add(DebtViewModel(debt: DebtModel(
        amount: 10,
        description: "Peguei emprestado para pagar a passagem do ônibus.",
        borrowingDate: 1619336404000,
        paymentDate: 1618731604000,
        createdAt: DateTime.now().millisecond,
        personToBePayed: "Sueli"
      )));

      await repository.saveDebtsSharedPreferences(pendantDebts);
      return;
  }
}

