import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final List<String> _hierarchy;

  List<String> get hierarchy => _hierarchy;

  String get mainCategory => _hierarchy.first.toLowerCase();

  Account get upperAccount =>
      Account(_hierarchy.sublist(0, _hierarchy.length - 1));

  AccountCategory get category {
    var rootAccount = _hierarchy.first.toLowerCase();
    for (var category in AccountCategory.values) {
      if (rootAccount == category.name) {
        return category;
      }
    }
    return AccountCategory.unknown;
  }

  const Account(this._hierarchy);

  String displayName({required bool isTree}) {
    return isTree
        ? '${upperAccount.hierarchy.map((_) => '  ').join('')}${_hierarchy.last}'
        : _hierarchy.join(':');
  }

  @override
  String toString() {
    return 'Account(${_hierarchy.join(' > ')})})';
  }

  @override
  List<Object?> get props => [_hierarchy.map((a) => a.toLowerCase())];
}

enum AccountCategory {
  assets,
  liabilities,
  income,
  expenses,
  unknown,
}
