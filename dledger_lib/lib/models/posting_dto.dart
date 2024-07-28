import './account.dart';
import './commodity.dart';

class PostingDto {
  final Account account;
  Commodity? commodity;

  PostingDto(this.account, {this.commodity});
}
