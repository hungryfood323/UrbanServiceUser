class ServiceListModel {
  String? responseCode;
  String? message;
  List<Services>? services;
  String? status;

  ServiceListModel(
      {this.responseCode, this.message, this.services, this.status});

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Services {
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
  String? storeName;
  String? storeAddress;
  String? storeLatitude;
  String? storeLongitude;
  String? vendorName;
  String? reviewCount;

  Services(
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
      this.storeAddress,
      this.storeLatitude,
      this.storeLongitude,
      this.vendorName,
      this.reviewCount});

  Services.fromJson(Map<String, dynamic> json) {
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
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    vendorName = json['vendor_name'];
    reviewCount = json['review_count'];
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
    data['store_address'] = this.storeAddress;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    data['vendor_name'] = this.vendorName;
    data['review_count'] = this.reviewCount;
    return data;
  }
}