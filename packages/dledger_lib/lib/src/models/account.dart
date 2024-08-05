import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final List<String> _hierarchy;

  List<String> get hierarchy => _hierarchy;

  String get mainCategory => _hierarchy.first.toLowerCase();

  Account get upperAccount => Account(_hierarchy.sublist(0, _hierarchy.length - 1));

  const Account(this._hierarchy);

  String displayName({required bool isTree}) {
    return isTree
        ? '${upperAccount.hierarchy.map((_) => '  ').join('')}${_hierarchy.last}'
        : _hierarchy.join(':');
  }

  @override
  String toString() {
    return 'Account("hierarchy": ${_hierarchy.join(' > ')})})';
  }

  @override
  List<Object?> get props => [_hierarchy];
}
