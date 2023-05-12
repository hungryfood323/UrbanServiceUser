class ServiceRatingModel {
  String? status;
  String? msg;
  String? preview;

  ServiceRatingModel({this.status, this.msg, this.preview});

  ServiceRatingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['preview'] = this.preview;
    return data;
  }
}