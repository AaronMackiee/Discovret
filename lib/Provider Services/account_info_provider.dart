import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserAccountInfo with ChangeNotifier {
  String? _email;
  String? _password;
  String? _confirmPassword;
  bool? _eighteenPlus = false;
  bool? _termsAgreement = false;
  bool? _privacyAgreement = false;
  bool? _hasProfilePicture = false;
  double? _strengthValue;
  String passwordStrength = "";

  bool? get hasProfilePicture => this._hasProfilePicture;
 set hasProfilePicture(bool? value) {
   this._hasProfilePicture = value;
   notifyListeners();
 }

  String get getPasswordStrength => this.passwordStrength;
  set setPasswordStrength(String passwordStrength) {
    this.passwordStrength = passwordStrength;
    notifyListeners();
  }

  double? get strengthValue => this._strengthValue;
  set strengthValue(double? value) {
    this._strengthValue = value;
    notifyListeners();
  }

  String? get confirmPassword => this._confirmPassword;
  set confirmPassword(String? value) {
    this._confirmPassword = value;
    notifyListeners();
  }

  String? get email => this._email;
  set email(String? value) {
    this._email = value;
    notifyListeners();
  }

  String? get password => this._password;
  set password(String? value) {
    this._password = value;
    notifyListeners();
  }

  bool? get eighteenPlus => this._eighteenPlus;
  set eighteenPlus(bool? value) {
    this._eighteenPlus = value;
    notifyListeners();
  }

  bool? get termsAgreement => this._termsAgreement;
  set termsAgreement(bool? value) {
    this._termsAgreement = value;
    notifyListeners();
  }

  bool? get privacyAgreement => this._privacyAgreement;
  set privacyAgreement(bool? value) {
    this._privacyAgreement = value;
    notifyListeners();
  }
}
