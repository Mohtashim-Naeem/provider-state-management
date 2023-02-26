import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../services/navigation_service.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';

class FormProvider with ChangeNotifier {
  var formData = {};
  final Dio _dio = Dio();
  final UtilService _utilService = locator<UtilService>();
  final NavigationService navigationService = locator<NavigationService>();

  setFormDats(var data) {
    formData = data;
  }

  getAllBuses() async {
    try {
      var response = _dio.get('');
    } catch (e) {
      _utilService.showToast(e.toString());
    }
  }

  getAllRoutes() async {
    try {
      var response = _dio.get('');
    } catch (e) {
      _utilService.showToast(e.toString());
    }
  }

  submitForm() async {
    try {
      var response = _dio.post('');
    } catch (e) {
      _utilService.showToast(e.toString());
    }
  }
}
