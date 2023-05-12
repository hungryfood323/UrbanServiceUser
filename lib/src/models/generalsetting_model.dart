class GeneralSettingModel {
  int? status;
  String? msg;
  Setting? setting;

  GeneralSettingModel({this.status, this.msg, this.setting});

  GeneralSettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    setting =
        json['setting'] != null ? new Setting.fromJson(json['setting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.setting != null) {
      data['setting'] = this.setting!.toJson();
    }
    return data;
  }
}

class Setting {
  String? id;
  String? nServerKey;
  String? sSecretKey;
  String? sPublicKey;
  String? rSecretKey;
  String? rPublicKey;

  Setting(
      {this.id,
      this.nServerKey,
      this.sSecretKey,
      this.sPublicKey,
      this.rSecretKey,
      this.rPublicKey});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nServerKey = json['n_server_key'];
    sSecretKey = json['s_secret_key'];
    sPublicKey = json['s_public_key'];
    rSecretKey = json['r_secret_key'];
    rPublicKey = json['r_public_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['n_server_key'] = this.nServerKey;
    data['s_secret_key'] = this.sSecretKey;
    data['s_public_key'] = this.sPublicKey;
    data['r_secret_key'] = this.rSecretKey;
    data['r_public_key'] = this.rPublicKey;
    return data;
  }
}