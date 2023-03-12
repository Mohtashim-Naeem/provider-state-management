class RouteModel {
  int? routeID;
  String? route;

  RouteModel({this.routeID, this.route});

  RouteModel.fromJson(Map<String, dynamic> json) {
    routeID = json['RouteID'];
    route = json['Route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RouteID'] = this.routeID;
    data['Route'] = this.route;
    return data;
  }
}