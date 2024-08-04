import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final List<String> _accountHierarchy;

  List<String> get hierarchy => _accountHierarchy;

  String get category => _accountHierarchy.first.toLowerCase();

  const Account(this._accountHierarchy);

  @override
  String toString() {
    return 'Account("accountHierarchy": ${_accountHierarchy.join(' > ')})})';
  }

  @override
  List<Object?> get props => [_accountHierarchy];
}
