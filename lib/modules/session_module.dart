class SessionModule {
  String mimeType="application/json";
  Params? params;

  SessionModule({this.params});

  SessionModule.fromJson(Map<String, dynamic> json) {
    mimeType="application/json";
    params =
    json['params'] != null ? new Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mimeType'] = "application/json";
    if (params != null) {
      data['params'] = params!.toJson();
    }
    return data;
  }
}

class Params {
  String? login;
  String? password;
  String? db;

  Params({this.login, this.password, this.db});

  Params.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    password = json['password'];
    db = json['db'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = login;
    data['password'] = password;
    data['db'] = db;
    return data;
  }
}