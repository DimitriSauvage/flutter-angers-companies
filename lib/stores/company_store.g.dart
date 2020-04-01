// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CompanyStore on _CompanyStore, Store {
  final _$companiesAtom = Atom(name: '_CompanyStore.companies');

  @override
  ObservableList<Company> get companies {
    _$companiesAtom.context.enforceReadPolicy(_$companiesAtom);
    _$companiesAtom.reportObserved();
    return super.companies;
  }

  @override
  set companies(ObservableList<Company> value) {
    _$companiesAtom.context.conditionallyRunInAction(() {
      super.companies = value;
      _$companiesAtom.reportChanged();
    }, _$companiesAtom, name: '${_$companiesAtom.name}_set');
  }

  final _$saveAsyncAction = AsyncAction('save');

  @override
  Future<void> save(Company company) {
    return _$saveAsyncAction.run(() => super.save(company));
  }

  final _$loadAsyncAction = AsyncAction('load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    final string = 'companies: ${companies.toString()}';
    return '{$string}';
  }
}
