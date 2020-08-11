import 'package:mallatweb/providers/cartProduct.dart';

class Order{
  String id;
  double amount;
  List<CartProduct> products;
  final DateTime timeStamp;

  Order({this.id,this.amount,this.products,this.timeStamp});


}