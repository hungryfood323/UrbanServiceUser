class GetWishListModal {
  String? responseCode;
  String? message;
  List<Wishlist>? wishlist;
  String? status;

  GetWishListModal(
      {this.responseCode, this.message, this.wishlist, this.status});

  GetWishListModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Wishlist {
  String? proId;
  String? productName;
  String? productPrice;
  String? productImage;

  Wishlist(
      {this.proId, this.productName, this.productPrice, this.productImage});

  Wishlist.fromJson(Map<String, dynamic> json) {
    proId = json['pro_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pro_id'] = this.proId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    return data;
  }
}