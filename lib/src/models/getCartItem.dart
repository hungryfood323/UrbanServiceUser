class GetCartModel {
  String? responseCode;
  String? message;
  List<Cart>? cart;
  String? cartTotal;
  String? totalItems;
  String? status;

  GetCartModel(
      {this.responseCode,
      this.message,
      this.cart,
      this.cartTotal,
      this.totalItems,
      this.status});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
    cartTotal = json['cart_total'];
    totalItems = json['total_items'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    data['cart_total'] = this.cartTotal;
    data['total_items'] = this.totalItems;
    data['status'] = this.status;
    return data;
  }
}

class Cart {
  String? productId;
  String? cartId;
  String? productImage;
  String? productName;
  String? quantity;
  String? price;

  Cart(
      {this.productId,
      this.cartId,
      this.productImage,
      this.productName,
      this.quantity,
      this.price});

  Cart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    cartId = json['cart_id'];
    productImage = json['product_image'];
    productName = json['product_name'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['cart_id'] = this.cartId;
    data['product_image'] = this.productImage;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}