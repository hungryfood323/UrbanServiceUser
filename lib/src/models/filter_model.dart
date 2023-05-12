class FilterModel {
  String? responseCode;
  String? message;
  List<Servic>? servic;
  String? status;

  FilterModel({this.responseCode, this.message, this.servic, this.status});

  FilterModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['servic'] != null) {
      servic = <Servic>[];
      json['servic'].forEach((v) {
        servic!.add(new Servic.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.servic != null) {
      data['servic'] = this.servic!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Servic {
  String? id;
  String? catId;
  String? resId;
  String? vId;
  String? serviceName;
  String? servicePrice;
  String? serviceDescription;
  String? serviceImage;
  String? priceUnit;
  String? duration;
  String? serviceRatings;
  String? createdDate;
  String? categoryName;
  String? reviewCount;
  String? storeName;
  String? storeAddress;
  String? storeLatitude;
  String? storeLongitude;
  String? vendorName;

  Servic(
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
      this.reviewCount,
      this.storeName,
      this.storeAddress,
      this.storeLatitude,
      this.storeLongitude,
      this.vendorName});

  Servic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    resId = json['res_id'];
    vId = json['v_id'];
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    serviceDescription = json['service_description'];
    serviceImage = json['service_image'];
    priceUnit = json['price_unit'];
    duration = json['duration'];
    serviceRatings = json['service_ratings'];
    createdDate = json['created_date'];
    categoryName = json['category_name'];
    reviewCount = json['review_count'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    vendorName = json['vendor_name'];
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
    data['review_count'] = this.reviewCount;
    data['store_name'] = this.storeName;
    data['store_address'] = this.storeAddress;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    data['vendor_name'] = this.vendorName;
    return data;
  }
}