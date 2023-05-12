class SocialModel {
  String? responseCode;
  String? message;
  String? userId;
  String? userToken;
  String? status;

  SocialModel(
      {this.responseCode,
      this.message,
      this.userId,
      this.userToken,
      this.status});

  SocialModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    userId = json['user_id'];
    userToken = json['user_token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['user_token'] = this.userToken;
    data['status'] = this.status;
    return data;
  }
}
