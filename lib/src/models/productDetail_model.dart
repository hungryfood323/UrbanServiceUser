class ProductDetailModel {
  String? responseCode;
  String? message;
  Product? product;
  List<Review>? review;
  String? status;

  ProductDetailModel(
      {this.responseCode,
      this.message,
      this.product,
      this.review,
      this.status});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Product {
  String? productId;
  String? vid;
  String? catId;
  String? productName;
  String? productDescription;
  String? productPrice;
  List<String>? productImage;
  String? proRatings;
  String? productCreateDate;
  String? categories;

  Product(
      {this.productId,
      this.vid,
      this.catId,
      this.productName,
      this.productDescription,
      this.productPrice,
      this.productImage,
      this.proRatings,
      this.productCreateDate,
      this.categories});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    vid = json['vid'];
    catId = json['cat_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productImage = json['product_image'].cast<String>();
    proRatings = json['pro_ratings'];
    productCreateDate = json['product_create_date'];
    categories = json['categories'];
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
    data['categories'] = this.categories;
    return data;
  }
}

class Review {
  String? revId;
  String? revUser;
  String? revPro;
  String? revStars;
  String? revText;
  String? revDate;
  RevUserData? revUserData;

  Review(
      {this.revId,
      this.revUser,
      this.revPro,
      this.revStars,
      this.revText,
      this.revDate,
      this.revUserData});

  Review.fromJson(Map<String, dynamic> json) {
    revId = json['rev_id'];
    revUser = json['rev_user'];
    revPro = json['rev_pro'];
    revStars = json['rev_stars'];
    revText = json['rev_text'];
    revDate = json['rev_date'];
    revUserData = json['rev_user_data'] != null
        ? new RevUserData.fromJson(json['rev_user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rev_id'] = this.revId;
    data['rev_user'] = this.revUser;
    data['rev_pro'] = this.revPro;
    data['rev_stars'] = this.revStars;
    data['rev_text'] = this.revText;
    data['rev_date'] = this.revDate;
    if (this.revUserData != null) {
      data['rev_user_data'] = this.revUserData!.toJson();
    }
    return data;
  }
}

class RevUserData {
  String? id;
  String? username;
  String? email;
  String? mobile;
  String? password;
  String? profilePic;
  String? facebookId;
  String? type;
  String? isGold;
  String? address;
  String? city;
  String? country;
  String? deviceToken;
  String? date;

  RevUserData(
      {this.id,
      this.username,
      this.email,
      this.mobile,
      this.password,
      this.profilePic,
      this.facebookId,
      this.type,
      this.isGold,
      this.address,
      this.city,
      this.country,
      this.deviceToken,
      this.date});

  RevUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
    type = json['type'];
    isGold = json['isGold'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    deviceToken = json['device_token'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    data['type'] = this.type;
    data['isGold'] = this.isGold;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['device_token'] = this.deviceToken;
    data['date'] = this.date;
    return data;
  }
}