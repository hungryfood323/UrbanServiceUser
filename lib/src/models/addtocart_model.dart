class AddToCartModel {
  String? responseCode;
  String? message;
  String? status;

  AddToCartModel({this.responseCode, this.message, this.status});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}