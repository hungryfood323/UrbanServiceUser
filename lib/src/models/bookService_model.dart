class BookServiceModel {
  String? responseCode;
  String? message;
  String? status;
  Booking? booking;

  BookServiceModel(
      {this.responseCode, this.message, this.status, this.booking});

  BookServiceModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Booking {
  String? vid;
  String? resId;
  String? serviceId;
  String? userId;
  String? date;
  String? slot;
  String? size;
  String? notes;
  String? address;
  String? createDate;
  int? bookingId;

  Booking(
      {this.vid,
      this.resId,
      this.serviceId,
      this.userId,
      this.date,
      this.slot,
      this.size,
      this.notes,
      this.address,
      this.createDate,
      this.bookingId});

  Booking.fromJson(Map<String, dynamic> json) {
    vid = json['vid'];
    resId = json['res_id'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    date = json['date'];
    slot = json['slot'];
    size = json['size'];
    notes = json['notes'];
    address = json['address'];
    createDate = json['create_date'];
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vid'] = this.vid;
    data['res_id'] = this.resId;
    data['service_id'] = this.serviceId;
    data['user_id'] = this.userId;
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['size'] = this.size;
    data['notes'] = this.notes;
    data['address'] = this.address;
    data['create_date'] = this.createDate;
    data['booking_id'] = this.bookingId;
    return data;
  }
}