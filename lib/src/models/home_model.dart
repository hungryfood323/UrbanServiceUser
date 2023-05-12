class HomeModel {
  String? responseCode;
  String? message;
  List<String>? banners;
  List<Category>? category;
  List<Services>? services;
  List<Products>? products;

  HomeModel(
      {this.responseCode,
      this.message,
      this.banners,
      this.category,
      this.services,
      this.products});

  HomeModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    banners = json['banners'].cast<String>();
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['banners'] = this.banners;
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? id;
  String? cName;
  String? cNameA;
  String? icon;
  String? img;
  String? type;

  Category({this.id, this.cName, this.cNameA, this.icon, this.img, this.type});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cName = json['c_name'];
    cNameA = json['c_name_a'];
    icon = json['icon'];
    img = json['img'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['c_name'] = this.cName;
    data['c_name_a'] = this.cNameA;
    data['icon'] = this.icon;
    data['img'] = this.img;
    data['type'] = this.type;
    return data;
  }
}

class Services {
  String? id;
  String? catId;
  String? resId;
  String? serviceImage;
  String? serviceRatings;
  String? servicePrice;
  String? serviceName;
  String? serviceDescription;

  Services(
      {this.id,
      this.catId,
      this.resId,
      this.serviceImage,
      this.serviceRatings,
      this.servicePrice,
      this.serviceName,
      this.serviceDescription});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    resId = json['res_id'];
    serviceImage = json['service_image'];
    serviceRatings = json['service_ratings'];
    servicePrice = json['service_price'];
    serviceName = json['service_name'];
    serviceDescription = json['service_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['res_id'] = this.resId;
    data['service_image'] = this.serviceImage;
    data['service_ratings'] = this.serviceRatings;
    data['service_price'] = this.servicePrice;
    data['service_name'] = this.serviceName;
    data['service_description'] = this.serviceDescription;
    return data;
  }
}

class Products {
  String? productId;
  String? vid;
  String? catId;
  String? productName;
  String? productDescription;
  String? productPrice;
  String? productImage;
  String? proRatings;
  String? productCreateDate;

  Products(
      {this.productId,
      this.vid,
      this.catId,
      this.productName,
      this.productDescription,
      this.productPrice,
      this.productImage,
      this.proRatings,
      this.productCreateDate});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    vid = json['vid'];
    catId = json['cat_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    proRatings = json['pro_ratings'];
    productCreateDate = json['product_create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['vid'] = this.vid;
    data['cat_id'] = this.catId;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['pro_ratings'] = this.proRatings;
    data['product_create_date'] = this.productCreateDate;
    return data;
  }
}