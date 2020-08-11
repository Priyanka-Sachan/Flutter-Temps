import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mallatweb/providers/cartProduct.dart';
import '../providers/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    List<CartProduct> products = widget.order.products;
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Order ID:${widget.order.id}'),
          subtitle: Text(widget.order.timeStamp.toIso8601String()),
          trailing: IconButton(
            icon: Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Container(
            width: double.infinity,
            height: products.length>=4?300.0:(products.length*75).ceilToDouble(),
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(products[index].title),
                    subtitle: Text('Amount: Rs.${(products[index].price*products[index].quantity).toStringAsFixed(2)}'),
                    trailing: Text('${products[index].quantity}X',
                    style: Theme.of(context).textTheme.headline5,),
                  );
                }),
          ),
      ],
    );
  }
}
