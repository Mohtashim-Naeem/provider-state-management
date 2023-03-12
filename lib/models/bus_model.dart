class BusModel {
  int? busID;
  String? busNo;

  BusModel({this.busID, this.busNo});

  BusModel.fromJson(Map<String, dynamic> json) {
    busID = json['BusID'];
    busNo = json['BusNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BusID'] = this.busID;
    data['BusNo'] = this.busNo;
    return data;
  }
}