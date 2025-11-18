import 'package:flutter/material.dart';

// Login model placeholder
class LoginModel {
  int? status;
  List<UserResult>? result;

  LoginModel({this.status, this.result});
}

class UserResult {
  int? id;
  String? channelId;
  String? channelName;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? countryCode;
  String? image;
  String? coverImg;
  String? deviceType;
  String? deviceToken;
  int? isBuy;
  int? adsFree;
  int? isDownload;
  int? isCreator;
  double? walletBalance;
}

class GeneralProvider extends ChangeNotifier {
  bool loading = false;
  bool isProgressLoading = false;
  LoginModel loginModel = LoginModel();

  void setLoading(bool value) {
    isProgressLoading = value;
    notifyListeners();
  }

  Future<void> login(
    String type,
    String email,
    String mobile,
    String deviceType,
    String deviceToken,
    String countryCode,
    String countryName,
  ) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Mock successful login
    loginModel = LoginModel(
      status: 200,
      result: [
        UserResult()
          ..id = 1
          ..channelId = "channel_123"
          ..channelName = "Test Channel"
          ..fullName = "Test User"
          ..email = email
          ..mobileNumber = mobile
          ..countryCode = countryCode
          ..deviceType = deviceType
          ..deviceToken = deviceToken
          ..isBuy = 0
          ..adsFree = 0
          ..isDownload = 0
          ..isCreator = 0
          ..walletBalance = 0.0,
      ],
    );
    
    loading = false;
    notifyListeners();
  }
}
