import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_app_ssp/models/bus_model.dart';

import '../models/route_model.dart';
import '../services/navigation_service.dart';
import '../services/storage_service.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';

class FormProvider with ChangeNotifier {
  var formData = {};
  final Dio _dio = Dio();
  final UtilService _utilService = locator<UtilService>();
  final StorageService storageService = locator<StorageService>();
  final NavigationService navigationService = locator<NavigationService>();
  final baseUrl = "https://smta.pk/api/AccountData";
  List<BusModel>? bus = [];
  List<RouteModel>? route = [];
  String imageUrl = "";

  setFormDats(var data) {
    formData = data;
  }

  getAllBuses() async {
    try {
      bus = [];
      var response = await _dio.get('${baseUrl}/GetBus');
      for (int i = 0; i < response.data.length; i++) {
        bus!.add(BusModel.fromJson(response.data[i]));
      }
    } catch (e) {
      _utilService.showToast(e.toString());
    }
  }

  getAllRoutes() async {
    try {
      route = [];
      var response = await _dio.get('${baseUrl}/GetRoute');
      for (int i = 0; i < response.data.length; i++) {
        route!.add(RouteModel.fromJson(response.data[i]));
      }
    } catch (e) {
      _utilService.showToast(e.toString());
    }
  }

  submitForm(var data) async {
    try {
      var response = _dio.post('${baseUrl}/InsertInspection', data: data);
    } catch (e) {
      _utilService.showToast(e.toString());
    }
  }

  uploadImage(String imagePath, String filename) async {
    // var request =
    //     http.MultipartRequest('POST', Uri.parse('${baseUrl}UploadImageFile'));
    // request.files.add(await http.MultipartFile.fromPath('', imagePath));

    // http.StreamedResponse response = await request.send();
    var formData = FormData.fromMap(
        {'file': await MultipartFile.fromFile(imagePath, filename: filename)});
    var response = await _dio.post('${baseUrl}UploadImageFile', data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      imageUrl = "$baseUrl" + response.data['url'];
    }
    // if (response.da == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }
}
