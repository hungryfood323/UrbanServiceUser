class NotificationModal {
  String? responseCode;
  String? message;
  List<Notifications>? notifications;
  String? status;

  NotificationModal(
      {this.responseCode, this.message, this.notifications, this.status});

  NotificationModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['notifications'] != null) {
      //notifications = new List<Notifications>();
       notifications = List<Notifications>.empty(growable: true);
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Notifications {
  String? notId;
  String? userId;
  String? dataId;
  String? type;
  String? title;
  String? message;
  String? date;
  List<Products>? products;

  Notifications(
      {this.notId,
      this.userId,
      this.dataId,
      this.type,
      this.title,
      this.message,
      this.date,
      this.products});

  Notifications.fromJson(Map<String, dynamic> json) {
    notId = json['not_id'];
    userId = json['user_id'];
    dataId = json['data_id'];
    type = json['type'];
    title = json['title'];
    message = json['message'];
    date = json['date'];
    if (json['products'] != null) {
      //products = new List<Products>();
       products = List<Products>.empty(growable: true);
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['not_id'] = this.notId;
    data['user_id'] = this.userId;
    data['data_id'] = this.dataId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['message'] = this.message;
    data['date'] = this.date;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
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
  String? quantity;

  Products(
      {this.productId,
      this.catId,
      this.productName,
      this.productDescription,
      this.productPrice,
      this.productImage,
      this.proRatings,
      this.productCreateDate,
      this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    catId = json['cat_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    proRatings = json['pro_ratings'];
    productCreateDate = json['product_create_date'];
    quantity = json['quantity'];
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
    data['quantity'] = this.quantity;
    return data;
  }
}