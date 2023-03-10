
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

  loginwithUserNameAndPassword(String username, String password) async {
    try {
      // var http = await _dio.post(
      //   'https://95.217.199.41/plesk-site-preview/smta.pk/api/AccountData/Login',
      //   data: {
      //     "UserName": username,
      //     "Password": password,
      //   },
      // );
      // user = UserModel.fromJson(http.data);
      await Future.delayed(const Duration(seconds: 1));
      if (username == 'admin' && password == 'admin') {
        await storageService.setBoolData('isLogin', true);
        navigationService.navigateTo(formScreenRoute);
      } else {
        _utilService.showToast('Invalid credentials');
      }
    } catch (e) {
      _utilService.showToast(
        'Invalid credentials - ${e.toString()}',
      );
    }
  }
  signOut()async{
    await storageService.removeData('isLogin');
    navigationService.navigateTo(loginScreenRoute);
  }
}
