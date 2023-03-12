import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:form_app_ssp/services/navigation_service.dart';
import 'package:form_app_ssp/services/storage_service.dart';

import '../models/user_model.dart';
import '../services/util_service.dart';
import '../utils/service_locator.dart';
import '../utils/routes.dart';

class AuthProvider with ChangeNotifier {
  UserModel? user;
  final Dio _dio = Dio();
  final UtilService _utilService = locator<UtilService>();
  final StorageService storageService = locator<StorageService>();
  final NavigationService navigationService = locator<NavigationService>();
  final baseUrl = "https://smta.pk/api/AccountData/";

  setData(UserModel data){
    this.user = data;
  }

  loginwithUserNameAndPassword(String username, String password) async {
    try {
      var http = await _dio.post(
        '${baseUrl}login',
        data: {
          "UserName": username,
          "Password": password,
        },
      );
      user = UserModel.fromJson(http.data[0]);
      await storageService.setData('user', user);
      await storageService.setBoolData('isLogin', true);
      await Future.delayed(const Duration(seconds: 1));

      navigationService.navigateTo(formScreenRoute);
    } catch (e) {
      _utilService.showToast(
        '${e.toString()}',
      );
    }
  }

  signOut() async {
    await storageService.removeData('isLogin');
    navigationService.navigateTo(loginScreenRoute);
  }
}
