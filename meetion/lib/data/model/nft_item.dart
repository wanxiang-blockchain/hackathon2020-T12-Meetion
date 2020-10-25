
import 'package:decimal/decimal.dart';

class NFTItem {
  final String imgUrl;
  final int tokenId;
  final String title;
  final String tag;
  final Decimal priceInEther;
  bool isSelected;


  NFTItem(this.imgUrl, this.tokenId, this.title, this.tag, this.priceInEther, {this.isSelected = false}) {

  }
}