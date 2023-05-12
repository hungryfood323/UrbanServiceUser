class TokenModel {
  String? responseCode;
  String? message;
  User? user;
  String? status;

  TokenModel({this.responseCode, this.message, this.user, this.status});

  TokenModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
  String? username;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? deviceToken;
  String? profileImage;

  User(
      {this.username,
      this.email,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.deviceToken,
      this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    deviceToken = json['device_token'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['device_token'] = this.deviceToken;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
