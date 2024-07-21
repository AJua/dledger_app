class Account {
  final List<String> _accountHierarchy;

  List<String> get hierarchy => _accountHierarchy;

  String get category => _accountHierarchy.first;

  Account(this._accountHierarchy);

  @override
  String toString() {
    return 'Account("accountHierarchy": ${_accountHierarchy.join(' > ')})})';
  }
}
