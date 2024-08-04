import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final List<String> _hierarchy;

  List<String> get hierarchy => _hierarchy;

  String get mainCategory => _hierarchy.first.toLowerCase();

  Account get upperAccounts => Account(_hierarchy.sublist(0, _hierarchy.length - 1));

  const Account(this._hierarchy);

  @override
  String toString() {
    return 'Account("hierarchy": ${_hierarchy.join(' > ')})})';
  }

  @override
  List<Object?> get props => [_hierarchy];
}
