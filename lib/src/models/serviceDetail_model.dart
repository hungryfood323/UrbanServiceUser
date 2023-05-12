class ServiceDetailModel {
  int? status;
  String? msg;
  Restaurant? restaurant;
  List<Review>? review;

  ServiceDetailModel({this.status, this.msg, this.restaurant, this.review});

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String? id;
  String? catId;
  String? resId;
  String? vId;
  String? serviceName;
  String? servicePrice;
  String? serviceDescription;
  List<String>? serviceImage;
  String? priceUnit;
  String? duration;
  String? serviceRatings;
  String? createdDate;
  String? categoryName;
  String? storeName;
  List<String>? storeImage;
  String? storeAddress;
  String? storeLatitude;
  String? storeLongitude;
  String? vendorName;
  String? reviewCount;
  String? isRating;

  Restaurant(
      {this.id,
      this.catId,
      this.resId,
      this.vId,
      this.serviceName,
      this.servicePrice,
      this.serviceDescription,
      this.serviceImage,
      this.priceUnit,
      this.duration,
      this.serviceRatings,
      this.createdDate,
      this.categoryName,
      this.storeName,
      this.storeImage,
      this.storeAddress,
      this.storeLatitude,
      this.storeLongitude,
      this.vendorName,
      this.reviewCount,
      this.isRating});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    resId = json['res_id'];
    vId = json['v_id'];
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    serviceDescription = json['service_description'];
    serviceImage = json['service_image'].cast<String>();
    priceUnit = json['price_unit'];
    duration = json['duration'];
    serviceRatings = json['service_ratings'];
    createdDate = json['created_date'];
    categoryName = json['category_name'];
    storeName = json['store_name'];
    storeImage = json['store_image'].cast<String>();
    storeAddress = json['store_address'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    vendorName = json['vendor_name'];
    reviewCount = json['review_count'];
    isRating = json['is_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['res_id'] = this.resId;
    data['v_id'] = this.vId;
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['service_description'] = this.serviceDescription;
    data['service_image'] = this.serviceImage;
    data['price_unit'] = this.priceUnit;
    data['duration'] = this.duration;
    data['service_ratings'] = this.serviceRatings;
    data['created_date'] = this.createdDate;
    data['category_name'] = this.categoryName;
    data['store_name'] = this.storeName;
    data['store_image'] = this.storeImage;
    data['store_address'] = this.storeAddress;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    data['vendor_name'] = this.vendorName;
    data['review_count'] = this.reviewCount;
    data['is_rating'] = this.isRating;
    return data;
  }
}

class Review {
  String? revId;
  String? revService;
  String? revUser;
  String? revStars;
  String? revText;
  String? revDate;
  String? username;
  String? profilePic;
  RevUserData? revUserData;

  Review(
      {this.revId,
      this.revService,
      this.revUser,
      this.revStars,
      this.revText,
      this.revDate,
      this.username,
      this.profilePic,
      this.revUserData});

  Review.fromJson(Map<String, dynamic> json) {
    revId = json['rev_id'];
    revService = json['rev_service'];
    revUser = json['rev_user'];
    revStars = json['rev_stars'];
    revText = json['rev_text'];
    revDate = json['rev_date'];
    username = json['username'];
    profilePic = json['profile_pic'];
    revUserData = json['rev_user_data'] != null
        ? new RevUserData.fromJson(json['rev_user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rev_id'] = this.revId;
    data['rev_service'] = this.revService;
    data['rev_user'] = this.revUser;
    data['rev_stars'] = this.revStars;
    data['rev_text'] = this.revText;
    data['rev_date'] = this.revDate;
    data['username'] = this.username;
    data['profile_pic'] = this.profilePic;
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