class CartProduct {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartProduct(
      {this.id, this.title, this.price, this.imageUrl, this.quantity = 1});
}
