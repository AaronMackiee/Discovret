import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UserProfileSettings with ChangeNotifier {
  bool _mapEnableLocation = true;
  bool _mapLocationViewCloseFriends = false;
  bool _mapLocationViewActiveFriends = false;
  bool _walletPinEnabled = false;
  bool _profileFriendListView = true;
  bool _notificationsEnteringDiscLocations = true;
  bool _notifcationsMatchedPerson = true;
  bool _infoLanguagesVisibleDiscSearch = false;
  bool _infoLanguagesVisibleFriends = false;
  bool _infoCountriesVisibleDiscSearch = false;
  bool _infoCountriesVisibleFriends = false;
  bool _infoCulturesVisibleDiscSearch = false;
  bool _infoCulturesVisibleFriends = false;
  bool _infoReligionVisibleDiscSearch = false;
  bool _infoReligionVisibleFriends = false;
  bool _infoInterestVisibleDiscSearch = false;
  bool _infoInterestVisibleFriends = false;
  bool _infoMentoringInVisibleDiscSearch = false;
  bool _infoMentoringInVisibleFriends = false;

  get infoLanguagesVisibleDiscSearch => this._infoLanguagesVisibleDiscSearch;
  set infoLanguagesVisibleDiscSearch(value) {
    this._infoLanguagesVisibleDiscSearch = value;
    notifyListeners();
  }

  get infoLanguagesVisibleFriends => this._infoLanguagesVisibleFriends;
  set infoLanguagesVisibleFriends(value) {
    this._infoLanguagesVisibleFriends = value;
    notifyListeners();
  }

  get infoCountriesVisibleDiscSearch => this._infoCountriesVisibleDiscSearch;
  set infoCountriesVisibleDiscSearch(value) {
    this._infoCountriesVisibleDiscSearch = value;
    notifyListeners();
  }

  get infoCountriesVisibleFriends => this._infoCountriesVisibleFriends;
  set infoCountriesVisibleFriends(value) {
    this._infoCountriesVisibleFriends = value;
    notifyListeners();
  }

  get infoCulturesVisibleDiscSearch => this._infoCulturesVisibleDiscSearch;
  set infoCulturesVisibleDiscSearch(value) {
    this._infoCulturesVisibleDiscSearch = value;
    notifyListeners();
  }

  get infoCulturesVisibleFriends => this._infoCulturesVisibleFriends;
  set infoCulturesVisibleFriends(value) {
    this._infoCulturesVisibleFriends = value;
    notifyListeners();
  }

  get infoReligionVisibleDiscSearch => this._infoReligionVisibleDiscSearch;
  set infoReligionVisibleDiscSearch(value) {
    this._infoReligionVisibleDiscSearch = value;
    notifyListeners();
  }

  get infoReligionVisibleFriends => this._infoReligionVisibleFriends;
  set infoReligionVisibleFriends(value) {
    this._infoReligionVisibleFriends = value;
    notifyListeners();
  }

  get infoInterestVisibleDiscSearch => this._infoInterestVisibleDiscSearch;
  set infoInterestVisibleDiscSearch(value) {
    this._infoInterestVisibleDiscSearch = value;
    notifyListeners();
  }

  get infoInterestVisibleFriends => this._infoInterestVisibleFriends;
  set infoInterestVisibleFriends(value) {
    this._infoInterestVisibleFriends = value;
    notifyListeners();
  }

  get infoMentoringInVisibleDiscSearch =>
      this._infoMentoringInVisibleDiscSearch;
  set infoMentoringInVisibleDiscSearch(value) {
    this._infoMentoringInVisibleDiscSearch = value;
    notifyListeners();
  }

  get infoMentoringInVisibleFriends => this._infoMentoringInVisibleFriends;
  set infoMentoringInVisibleFriends(value) {
    this._infoMentoringInVisibleFriends = value;
    notifyListeners();
  }

  get mapLocationViewCloseFriends => this._mapLocationViewCloseFriends;
  set mapLocationViewCloseFriends(value) {
    this._mapLocationViewCloseFriends = value;
    notifyListeners();
  }

  get mapLocationViewActiveFriends => this._mapLocationViewActiveFriends;
  set mapLocationViewActiveFriends(value) {
    this._mapLocationViewActiveFriends = value;
    notifyListeners();
  }

  get walletPinEnabled => this._walletPinEnabled;
  set walletPinEnabled(value) {
    this._walletPinEnabled = value;
    notifyListeners();
  }

  get profileFriendListView => this._profileFriendListView;
  set profileFriendListView(value) {
    this._profileFriendListView = value;
    notifyListeners();
  }

  get notificationsEnteringDiscLocations =>
      this._notificationsEnteringDiscLocations;
  set notificationsEnteringDiscLocations(value) {
    this._notificationsEnteringDiscLocations = value;
    notifyListeners();
  }

  get notifcationsMatchedPerson => this._notifcationsMatchedPerson;
  set notifcationsMatchedPerson(value) {
    this._notifcationsMatchedPerson = value;
    notifyListeners();
  }

  bool get mapEnableLocation => this._mapEnableLocation;
  set mapEnableLocation(bool value) {
    this._mapEnableLocation = value;
    notifyListeners();
  }
}
