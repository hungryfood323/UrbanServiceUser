class BookingNotificationModal {
  String? responseCode;
  String? message;
  List<Notifications>? notifications;
  String? status;

  BookingNotificationModal(
      {this.responseCode, this.message, this.notifications, this.status});

  BookingNotificationModal.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['notifications'] != null) {
     
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
  List<Booking>? booking;

  Notifications(
      {this.notId,
      this.userId,
      this.dataId,
      this.type,
      this.title,
      this.message,
      this.date,
      this.booking});

  Notifications.fromJson(Map<String, dynamic> json) {
    notId = json['not_id'];
    userId = json['user_id'];
    dataId = json['data_id'];
    type = json['type'];
    title = json['title'];
    message = json['message'];
    date = json['date'];
    if (json['booking'] != null) {
   
       booking = List<Booking>.empty(growable: true);
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
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
    if (this.booking != null) {
      data['booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String? date;
  String? slot;
  String? size;
  String? amount;
  String? serviceName;
  String? serviceId;
  String? resImage;

  Booking(
      {this.date,
      this.slot,
      this.size,
      this.amount,
      this.serviceName,
      this.serviceId,
      this.resImage});

  Booking.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    slot = json['slot'];
    size = json['size'];
    amount = json['amount'];
    serviceName = json['service_name'];
    serviceId = json['service_id'];
    resImage = json['res_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['size'] = this.size;
    data['amount'] = this.amount;
    data['service_name'] = this.serviceName;
    data['service_id'] = this.serviceId;
    data['res_image'] = this.resImage;
    return data;
  }
}
