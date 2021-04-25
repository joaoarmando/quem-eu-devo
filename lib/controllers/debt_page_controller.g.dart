// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DebtPageController on _DebtPageControllerBase, Store {
  final _$debtStatusAtom = Atom(name: '_DebtPageControllerBase.debtStatus');

  @override
  DebtStatus get debtStatus {
    _$debtStatusAtom.reportRead();
    return super.debtStatus;
  }

  @override
  set debtStatus(DebtStatus value) {
    _$debtStatusAtom.reportWrite(value, super.debtStatus, () {
      super.debtStatus = value;
    });
  }

  final _$getAllPendantDebtsAsyncAction =
      AsyncAction('_DebtPageControllerBase.getAllPendantDebts');

  @override
  Future<Null> getAllPendantDebts() {
    return _$getAllPendantDebtsAsyncAction
        .run(() => super.getAllPendantDebts());
  }

  @override
  String toString() {
    return '''
debtStatus: ${debtStatus}
    ''';
  }
}
