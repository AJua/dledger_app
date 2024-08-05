import 'package:equatable/equatable.dart';

import './account.dart';
import 'commodity.dart';

class Posting extends Equatable {
  final DateTime date;
  final String? description;
  final Account account;
  final Commodity commodity;

  get primaryAccount => account.hierarchy[0].toLowerCase();

  const Posting(this.date, this.account, this.commodity, {this.description});

  Iterable<Posting> get tree {
    if (account.hierarchy.length == 1) {
      return [Posting(date, account, commodity)];
    }
    return [
      Posting(date, account, commodity),
      ...Posting(date, account.upperAccount, commodity).tree
    ];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [date, account, commodity];
}
