class GetProdByCatID {
  String? responseCode;
  String? message;
  List<Products>? products;
  String? status;

  GetProdByCatID({this.responseCode, this.message, this.products, this.status});

  GetProdByCatID.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['products'] != null) {
      products =  <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Products {
  String? productId;
  String? catId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productImage;
  String? proRatings;
  String? productCreateDate;
  String? categories;

  Products(
      {this.productId,
      this.catId,
      this.productName,
      this.productDescription,
      this.productPrice,
      this.productImage,
      this.proRatings,
      this.productCreateDate,
      this.categories});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    catId = json['cat_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    proRatings = json['pro_ratings'];
    productCreateDate = json['product_create_date'];
    categories = json['categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['cat_id'] = this.catId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['pro_ratings'] = this.proRatings;
    data['product_create_date'] = this.productCreateDate;
    data['categories'] = this.categories;
    return data;
  }
}