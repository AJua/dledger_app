import './account.dart';
import './commodity.dart';

class PostingDto {
  final Account account;
  Commodity? commodity;

  get primaryAccount => account.hierarchy[0].toLowerCase();

  PostingDto(this.account, {this.commodity});

  @override
  String toString() {
    return 'Posting("account": $account, "commodity": $commodity)';
  }
}
