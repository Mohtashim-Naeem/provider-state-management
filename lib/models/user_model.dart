class UserModel {
  int? userID;
  String? userName;
  String? fullName;

  UserModel({this.userID, this.userName, this.fullName});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    userName = json['UserName'];
    fullName = json['FullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    data['UserName'] = this.userName;
    data['FullName'] = this.fullName;
    return data;
  }
}
