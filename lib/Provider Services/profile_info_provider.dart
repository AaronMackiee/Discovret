import 'dart:collection';

import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/friend_list_brain.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/friend_object.dart';
import 'package:discovret1_0/ProfileSearch Screens/profile_search_brain.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class UserProfileInfo with ChangeNotifier {
  String? _firstName;
  String? _lastName;
  String? _profilePicture;
  String? _sex;
  String? _gender;
  String? _firstLanguage;
  String? _interestedIn;
  String? _relationshipStatus;
  String? _bio;
  int? _age;
  String? _religions;
  List<String> _listSelectedReligions = [];
  List<int> _listSelectedLanguages = [];
  List<String> _listOtherLanguages = [];
  List<String> _listAllLanguages = [];
  List<int> _listSelectedCountriesLivedIn = [];
  List<String> _listCountriesLivedIn = [];
  List<int> _listSelectedCultures = [];
  List<String> _listCultures = [];
  List<int> _listSelectedInterest = [];
  List<String> _listInterest = [];
  List<int> _listSelectedIdeasBeliefs = [];
  List<String> _listIdeasBeliefs = [];
  List<int> _listSelectedMentoringIn = [];
  List<String> _listMentoringIn = [];
  List<SearchObject> _listDiscSearch = [];
  FriendProfile? _selectedConfirmationObject;
  List<FriendObject?> _listConfirmationObjects = [];
  List<FriendObject?> _listActiveFriends = [];
  Color yesButtonColor = Colors.transparent;
  Color noButonColor = Colors.transparent;
  String? confirmFriendErrorText;
  List<dynamic> _listUserPhotos = [
  ];
  String? _profilePhoto;
  var _logInPhoto;
  dynamic get logInPhoto => this._logInPhoto;
  set logInPhoto(var value) {
    this._logInPhoto = value;
    notifyListeners();
  }
    // 'assets/profile1.jpg',
    // 'assets/profile2.jpg',
    // 'assets/profile3.jpg',
    // 'assets/profile4.jpg',
    // 'assets/profile5.jpg',
    // 'assets/profile6.jpg',
    // 'assets/profile7.jpg',
    // 'assets/profile8.jpg',
    // 'assets/profile9.jpg',
    // 'assets/profile10.jpg',
    // 'assets/profile11.jpg',
    // 'assets/profile12.jpg',
    // 'assets/profile13.jpg',
    // 'assets/profile14.jpg',
    // 'assets/profile15.jpg',
    
  // bool isValidFormProfile = false;
  // var _numberFormProfile = GlobalKey<FormState>();

  // get numberFormProfile => this._numberFormProfile;
  // set numberFormProfile(var value) {
  //   this._numberFormProfile = value;
  //   notifyListeners();
  // }

  // get getIsValidFormProfile => this.isValidFormProfile;
  // set setIsValidFormProfile(bool isValidFormProfile) {
  //   this.isValidFormProfile = isValidFormProfile;
  //   notifyListeners();
  // }

  List<String> get selectedReligions => this._listSelectedReligions;
  set selectedReligions(List<String> value) {
    this._listSelectedReligions = value;
    notifyListeners();
  }

  List<FriendObject?> get listConfirmationObjects =>
      this._listConfirmationObjects;
  set listConfirmationObjects(List<FriendObject?> value) {
    this._listConfirmationObjects = value;
    notifyListeners();
  }

  List<FriendObject?> get listActiveFriends => this._listActiveFriends;
  set listActiveFriends(List<FriendObject?> value) {
    this._listActiveFriends = value;
    notifyListeners();
  }

  String? get profilePicture => this._profilePicture;
  set profilePicture(String? value) {
    this._profilePicture = value;
    notifyListeners();
  }

  List<dynamic> get listUserPhotos => this._listUserPhotos;
  set listUserPhotos(List<dynamic> listUserPhotos) {
    this._listUserPhotos = listUserPhotos;
    notifyListeners();
  }

  get profilePhoto => this._profilePhoto;
  set profilePhoto(profilePhoto) {
    this._profilePhoto = profilePhoto;
    notifyListeners();
  }

  get getConfirmFriendErrorText => this.confirmFriendErrorText;
  set setConfirmFriendErrorText(String confirmFriendErrorText) {
    this.confirmFriendErrorText = confirmFriendErrorText;
    notifyListeners();
  }

  get getYesButtonColor => this.yesButtonColor;
  set setYesButtonColor(Color yesButtonColor) {
    this.yesButtonColor = yesButtonColor;
    notifyListeners();
  }

  get getNoButonColor => this.noButonColor;
  set setNoButonColor(noButonColor) {
    this.noButonColor = noButonColor;
    notifyListeners();
  }

  FriendProfile? get selectedConfirmationObject =>
      this._selectedConfirmationObject;
  set selectedConfirmationObject(FriendProfile? value) {
    this._selectedConfirmationObject = value;
    notifyListeners();
  }

  // UnmodifiableListView<FriendObject> get listConfirmationObjects {
  //   return UnmodifiableListView(_listConfirmationObjects);
  // }

  // UnmodifiableListView<FriendObject> get listActiveFriends {
  //   return UnmodifiableListView(_listActiveFriends);
  // }

  UnmodifiableListView<SearchObject> get listDiscSearch {
    return UnmodifiableListView(_listDiscSearch);
  }

  List<int> get listSelectedCountriesLivedIn =>
      this._listSelectedCountriesLivedIn;
  set listSelectedCountriesLivedIn(List<int> value) {
    this._listSelectedCountriesLivedIn = value;
    notifyListeners();
  }

  get listCountriesLivedIn => this._listCountriesLivedIn;
  set listCountriesLivedIn(value) {
    this._listCountriesLivedIn = value;
    notifyListeners();
  }

  get listSelectedCultures => this._listSelectedCultures;
  set listSelectedCultures(value) {
    this._listSelectedCultures = value;
    notifyListeners();
  }

  get listCultures => this._listCultures;
  set listCultures(value) {
    this._listCultures = value;
    notifyListeners();
  }

  get religions => this._religions;
  set religions(value) {
    this._religions = value;
    notifyListeners();
  }

  get listSelectedInterest => this._listSelectedInterest;
  set listSelectedInterest(value) {
    this._listSelectedInterest = value;
    notifyListeners();
  }

  get listInterest => this._listInterest;
  set listInterest(value) {
    this._listInterest = value;
    notifyListeners();
  }

  get listSelectedIdeasBeliefs => this._listSelectedIdeasBeliefs;
  set listSelectedIdeasBeliefs(value) {
    this._listSelectedIdeasBeliefs = value;
    notifyListeners();
  }

  get listIdeasBeliefs => this._listIdeasBeliefs;
  set listIdeasBeliefs(value) {
    notifyListeners();
  }

  get listSelectedMentoringIn => this._listSelectedMentoringIn;
  set listSelectedMentoringIn(value) {
    this._listSelectedMentoringIn = value;
    notifyListeners();
  }

  get listMentoringIn => this._listMentoringIn;
  set listMentoringIn(value) {
    this._listMentoringIn = value;
    notifyListeners();
  }

  List<String> get listOtherLanguages => this._listOtherLanguages;
  set listOtherLanguages(List<String> value) {
    this._listOtherLanguages = value;
    notifyListeners();
  }

  get allLanguages => this._listAllLanguages;
  set allLanguages(value) {
    this._listAllLanguages = value;
    notifyListeners();
  }

  List<int> get listSelectedLanguages => this._listSelectedLanguages;
  set listSelectedLanguages(List<int> value) {
    this._listSelectedLanguages = value;
    // this._listSelectedLanguages = value;
    notifyListeners();
  }

  get firstName => this._firstName;
  set firstName(value) {
    this._firstName = value;
    notifyListeners();
  }

  get lastName => this._lastName;
  set lastName(value) {
    this._lastName = value;
    notifyListeners();
  }

  get sex => this._sex;
  set sex(value) {
    this._sex = value;
    notifyListeners();
  }

  String? get gender => this._gender;
  set gender(String? value) {
    this._gender = value;
    notifyListeners();
  }

  get firstLanguage => this._firstLanguage;
  set firstLanguage(value) {
    this._firstLanguage = value;
    notifyListeners();
  }

  get interestedIn => this._interestedIn;
  set interestedIn(value) {
    this._interestedIn = value;
    notifyListeners();
  }

  get relationshipStatus => this._relationshipStatus;
  set relationshipStatus(value) {
    this._relationshipStatus = value;
    notifyListeners();
  }

  int? get age => this._age;
  set age(value) {
    notifyListeners();
    this._age = value;
    // notifyListenersSetters();
  }

  void notifyListenersSetters() {
    notifyListeners();
  }

  String? get bio => this._bio;
  set bio(String? value) {
    this._bio = value;
    notifyListeners();
  }

  String? getBioHint() {
    if (bio == null) {
      return "Bio";
    } else {
      return bio;
    }
  }

  String? getGenderHint() {
    if (gender == null) {
      return "If Different From Biological Sex";
    } else {
      return gender;
    }
  }

  int get searchListCount {
    return _listDiscSearch.length;
  }

  int get friendConfirmationsCount {
    return _listConfirmationObjects.length;
  }

  int get activeFriendsCount {
    return _listActiveFriends.length;
  }

  int get userPhotosCount {
    return _listUserPhotos.length;
  }

  String getErrorText(FriendObject object) {
    if (object.onErrorText == null) {
      return "";
    } else {
      return object.onErrorText;
    }
  }

  void addSearchitem({String? selectedValue, String? textHeader}) {
    final searchItem =
        SearchObject(itemHeader: textHeader, item: selectedValue);
    _listDiscSearch.add(searchItem);
    notifyListeners();
  }

  void deleteSearchItem(SearchObject item) {
    _listDiscSearch.remove(item);
    notifyListeners();
  }

  void addConfirmationObject({FriendObject? object}) {
    _listActiveFriends.add(object);
    _listConfirmationObjects.remove(object);
    notifyListeners();
  }

  void addFriendObject({FriendObject? object}) {
    _listConfirmationObjects.add(object);
    notifyListeners();
  }

  void deleteConfirmationObject(FriendObject object) {
    _listConfirmationObjects.remove(object);
    notifyListeners();
  }

  void deleteFriend({FriendObject? object, required List<FriendObject?> list}) {
    list.remove(object);
    notifyListeners();
  }

  void deletePhoto(int photoIndex) {
    _listUserPhotos.removeAt(photoIndex);
    notifyListeners();
  }

  void addPhoto(String? photo) {
    _listUserPhotos.add(photo);
    notifyListeners();
  }

  void addReligion(String item) {
    _listSelectedReligions.add(item);
    notifyListeners();
  }

  void clearList(List<String> list) {
    list.clear();
  }

  void setNewList(
      {required List<int> selectedItems,
      List<String>? inputList,
      List<String>? userInfoList}) {
    int item;
    // int listLength = userInfoList.length;
    // userInfoList.removeRange(0, listLength);
    for (item in selectedItems) {
      // if (listOtherLanguages
      //     .contains(listLanguages[item])) {
      //   print('duplicate item');
      // } else {
      userInfoList!.add(inputList![item]);
      // }
    }
    // selectedItems.clear();
  }

//   void dropDownBirthYear(value) {
//     birthYear = value;
//     age = 2021 - birthYear;
//   }
  List<String> listSex = ['Male', 'Female'];
  List<String> listInterestedIn = ['Men', 'Women', 'Both Sexes'];
  List<String> listRelationshipStatus = [
    'Single',
    'In a Relationship',
    'Engaged',
    'Married'
  ];

  List<String> listWorldReligions = [
    "Atheism",
    "Baháʼí Faith",
    "Buddhism",
    "Caodaism",
    "Cheondoism",
    "Christianity",
    "Confucianism",
    "Hinduism",
    "Hoahaoism",
    "Islam",
    "Jainism",
    "Judaism",
    "Korean Shamanism",
    "No Religion",
    "Other",
    "Shinto",
    "Sikhism",
    "Spiritism",
    "Taoism",
    "Tenriism",
  ];

  List<String> listMentorTopics = [
    "Academic Problems",
    "Addiction",
    "Alcohol Abuse",
    "Anger Management",
    "Anorexia",
    "Anxiety",
    "Bullying",
    "Communication",
    "Dating",
    "Depression",
    "Divorce",
    "Drug Abuse",
    "Eating Disorders",
    "Emotional Abuse",
    "Employment",
    "Exercise",
    "Family Issues",
    "Forgiveness",
    "Grieving Death",
    "Learning Disabilities",
    "Marriage",
    "Mental Disabilities",
    "Money Management",
    "Obesity",
    "Physical Abuse",
    "Physical Disabilities",
    "Pornography",
    "PTSD",
    "Relationship Problems",
    "Self-esteem",
    "Sexual Abuse",
    "Suicide",
  ];

  List<int> listAge = [
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    97,
    98,
    99,
    100,
  ];
  List<String> listLanguages = [
    "Afrikaans",
    "Albanian Tosk",
    "Amharic",
    "Arabic",
    "Armenian",
    "Azerbaijani",
    "Belarusan",
    "Bengali",
    "Bosnian",
    "Bulgarian",
    "Burmese",
    "Chamorro",
    "Chinese Cantonese",
    "Chinese Mandarin",
    "Chuukese",
    "Croatian",
    "Czech",
    "Danish",
    "Dari",
    "Dutch",
    "Dzongkha",
    "English",
    "Estonian",
    "Fijian",
    "Filipino",
    "Finnish",
    "French",
    "Georgian",
    "German",
    "Greek",
    "Guaraní Paraguayan",
    "Haitian",
    "Hebrew",
    "Hindi",
    "Hungarian",
    "Icelandic",
    "Indonesian",
    "Inuktitut Greenlandic",
    "Italian",
    "Japanese",
    "Kazakh",
    "Khmer",
    "Kiribati",
    "Kosraean",
    "Korean",
    "Kyrgyz",
    "Lao",
    "Latvian",
    "Lithuanian",
    "Macedonian",
    "Malagasy Plateau",
    "Malay",
    "Maldivian",
    "Maltese",
    "Marshallese",
    "Mongolian Halh",
    "Ndebele",
    "Nepali",
    "Niue",
    "Norwegian",
    "Palauan",
    "Papiamentu",
    "Pashto",
    "Persian Iranian",
    "Pohnpeian",
    "Polish",
    "Portuguese",
    "Romanian",
    "Rundi",
    "Russian",
    "Rwanda",
    "Samoan",
    "Sango",
    "Serbian",
    "Seselwa Creole French",
    "Sinhala",
    "Slovak",
    "Slovene",
    "Somali",
    "Sotho Northern",
    "Sotho Southern",
    "Spanish",
    "Swahili",
    "Swati",
    "Swedish",
    "Tahitian",
    "Tajiki",
    "Tamazight Moroccan",
    "Tetun Dili",
    "Thai",
    "Tok Pisin",
    "Tongan",
    "Tsonga",
    "Tswana",
    "Turkish",
    "Turkmen",
    "Ukrainian",
    "Urdu",
    "Uzbek Northern",
    "Venda",
    "Vietnamese",
    "Xhosa",
    "Yapese",
    "Zulu",
  ];
  List<String> listCountries = [
    "Abkhazia",
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde Islands",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Costa Rica",
    "Côte d’Ivoire",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Democratic Republic of the Congo",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "French Guiana",
    "French Polynesia",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guadeloupe",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea, North",
    "Korea, South",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macao",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Nagorno-Karabakh",
    "Namibia",
    "Nauru",
    "Navassa Island",
    "Nepal",
    "Netherlands",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Northern Cyprus",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Réunion",
    "Romania",
    "Russian Federation",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "São Tomé e Príncipe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "Somaliland",
    "South Africa",
    "South Korea",
    "South Ossetia",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tonga",
    "Transnistria",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "USA",
    "Uzbekistan",
    "Vanuatu",
    "Vatican State",
    "Venezuela",
    "Viet Nam",
    "Wallis and Futuna",
    "Western Sahara",
    "Yemen",
    "Zambia",
    "Zimbabwe",
  ];
  List<String> listWorldCultures = [
    "Abkhazian",
    "Adjarian",
    "Afghani",
    "African-American",
    "Afrikaner",
    "Afro-Brazilian",
    "Ainu",
    "Aka",
    "Albanian",
    "Algerian",
    "American",
    "Amhara",
    "Andalusian",
    "Andhra",
    "Andorran",
    "Angolan",
    "Antiguan and Barbudan",
    "Araucanian",
    "Argentine",
    "Armenian",
    "Asháninka",
    "Asmat",
    "Australian Aborigines",
    "Australian",
    "Austrian",
    "Aymara",
    "Azande",
    "Azerbaijanis",
    "Baganda",
    "Bahamian",
    "Bahrainis",
    "Bakongo",
    "Balinese",
    "Baluchi",
    "Bangladeshis",
    "Banyankole",
    "Barbadian",
    "Basques",
    "Bedu",
    "Belarusan",
    "Belgian",
    "Belizean",
    "Bemba",
    "Bengalis",
    "Beninese",
    "Bhutanese",
    "Bolivian",
    "Brahui",
    "Brazilian",
    "Breton",
    "Bulgarian",
    "Burkinabe",
    "Burman",
    "Burundian",
    "Cambodia",
    "Cameroonian",
    "Canadian",
    "Cape Colored",
    "Cape Verdean",
    "Castilian",
    "Catalan",
    "Central African",
    "Chadian",
    "Chagga",
    "Chakmas",
    "Cham",
    "Chechen",
    "Chilean",
    "Chinese",
    "Chukchi",
    "Colombian",
    "Congolese",
    "Costa Rican",
    "Croatian",
    "Cuban",
    "Cunas",
    "Czech",
    "Danish",
    "Dinka",
    "Djiboutian",
    "Dominican",
    "Dong",
    "Druze",
    "Ecuadoran",
    "Efe and Mbuti",
    "Egyptian",
    "Emirian",
    "English",
    "Equatorial Guinean",
    "Eritrean",
    "Estonian",
    "Ethiopian",
    "Ewenki",
    "Fijian",
    "Filipinos",
    "Finish",
    "Fleming",
    "French",
    "French Canadian",
    "French Guianan",
    "Frisian",
    "Fulani",
    "Gabonese",
    "Galician",
    "Gambian",
    "Garifuna",
    "Georgian",
    "German",
    "Ghanaian",
    "Gikuyu",
    "Gond",
    "Greek Cypriot",
    "Greek",
    "Grenadian",
    "Guajiro",
    "Guaraní",
    "Guatemalan",
    "Guinean",
    "Gujarati",
    "Gusii",
    "Guyanan",
    "Haitian",
    "Han",
    "Hausa",
    "Hazara",
    "Hiligaynon",
    "Honduran",
    "Hungarian",
    "Hutu",
    "Iatmul",
    "Icelander",
    "Igbo",
    "Ilocano",
    "Indian",
    "Indo-Fijian",
    "Indonesian",
    "Inuit",
    "Iranian",
    "Iraqi",
    "Irish",
    "Israeli",
    "Italian",
    "Ivoirian",
    "Jamaican",
    "Japanese",
    "Javanese",
    "Jivaro",
    "Jordanian",
    "Kalenjin",
    "Kammu",
    "Karakalpak",
    "Karen",
    "Kayapo",
    "Kazak",
    "Kenyan",
    "Khmer",
    "Kittitian and Nevisian",
    "Kurd",
    "Kuwaiti",
    "Kyrgyz",
    "Laotian",
    "Latvian",
    "Lebanese",
    "Lesotho",
    "Liberian",
    "Libyan",
    "Liechtensteiner",
    "Lithuanian",
    "Luhya",
    "Luo",
    "Luxembourger",
    "Ma'dan(Marsh Arabs)",
    "Maasai",
    "Macedonian",
    "Malagasy",
    "Malawi",
    "Malays",
    "Malian",
    "Malinke",
    "Man (Manchus)",
    "Maori",
    "Maratha",
    "Maronite",
    "Mauritanian",
    "Melanesian",
    "Melpa",
    "Mexican",
    "Miao",
    "Micronesian",
    "Moldovan",
    "Monégasque",
    "Mongol",
    "Mordvin",
    "Moroccan",
    "Mossi",
    "Motu",
    "Mozambican",
    "Namibian",
    "Native American",
    "Nentsy",
    "Nepalis",
    "Netherlander",
    "New Zealander",
    "Nicaraguan",
    "Nigerian",
    "North Korean",
    "Norwegian",
    "Nyamwezi",
    "Omani",
    "Oriya",
    "Oromo",
    "Páez",
    "Pakistani",
    "Palestinian",
    "Pamiri",
    "Panamanian",
    "Paraguayan",
    "Pashtun",
    "Pemon",
    "Peruvian",
    "Poles",
    "Polynesian",
    "Portuguese",
    "Punjabis",
    "Qataris",
    "Quechua",
    "Rajput",
    "Romanian",
    "Russian",
    "Rwandan",
    "Salvadoran",
    "Sami",
    "Sammarinese",
    "Samoan",
    "Saudi",
    "Scottish",
    "Senegalese",
    "Seychellois",
    "Shambaa",
    "Shan",
    "Sherpa",
    "Sierra Leonean",
    "Sinhalese",
    "Slovak",
    "Slovene",
    "Somali",
    "Songhay",
    "Sotho",
    "South Korean",
    "Spaniard",
    "St. Lucian",
    "St. Vincentian",
    "Sudanes",
    "Sumu and Miskito",
    "Sundanese",
    "Surinamese",
    "Swahili",
    "Swazi",
    "Swede",
    "Swiss",
    "Syrian",
    "Tajik",
    "Tamil",
    "Tanzanian",
    "Tatar",
    "Thai",
    "Tibetan",
    "Tigray",
    "Tongan",
    "Trinidadian and Tobagonian",
    "Tuareg",
    "Tunisian",
    "Turkmen",
    "Turk",
    "Tutsi",
    "Ugandan",
    "Uighur",
    "Ukrainian",
    "Uruguayan",
    "Uzbek",
    "Vanuatu",
    "Venezuelan",
    "Vietnamese",
    "Walloon",
    "Welsh",
    "Wolof",
    "Xavante",
    "Yemenis",
    "Yoruba",
    "Zambian",
    "Zhuang",
    "Zimbabwean",
    "Zulu",
  ];

  List<String> listHobbiesInterest = [
    "Action Figures",
    "Adventure Running",
    "Aikido",
    "Air Soft",
    "Airbrushing",
    "Aircraft Spotting",
    "All-Terrain Vehicle",
    "Alpine Skiing",
    "Amateur Radio",
    "American Football",
    "Animal Fancy",
    "Ant Keeping",
    "Antiquing",
    "Aquarium (Freshwater & Saltwater)",
    "Archery",
    "Architectural Models",
    "Articles",
    "Astrology",
    "Astronomy",
    "Australian Football",
    "Badminton",
    "Bagpipes",
    "Baking",
    "Banjo",
    "Base Jumping",
    "Baseball",
    "Basketball",
    "Bass Drum",
    "Bassoon",
    "Baton Twirling",
    "Beach Volleyball",
    "Beach-Combing",
    "Beach/Sun Tanning",
    "Beachcross",
    "Beekeeping",
    "Bell",
    "Bell Ringing",
    "Bicycle Polo",
    "Bicycling",
    "Billiards",
    "Bird Watching",
    "Blacksmithing",
    "Bmx (Bicycle Motocross)",
    "Board Games",
    "Board Track Racing",
    "Bodybuilding",
    "Bongo",
    "Book Restoration",
    "Book-Binding",
    "Books",
    "Boomeranging",
    "Bowling",
    "Boxing",
    "Brazilian Jiu-Jitsu (Bjj)",
    "Brewing Beer",
    "Building Dollhouses",
    "Bus Spotting",
    "Butterfly Watching",
    "Cake Decorating",
    "Calligraphy",
    "Camping",
    "Candle Making",
    "Candy Making",
    "Canning",
    "Canoeing",
    "Capoeira",
    "Card Games",
    "Cardboard Engineering",
    "Cartooning",
    "Castanets",
    "Cave Diving",
    "Cello",
    "Ceramics",
    "Cheer-Leading",
    "Chess",
    "Chess Tournaments",
    "Church Going",
    "Cigar Smoking / Pipe Smoking",
    "Clarinet",
    "Clavichord",
    "Climbing",
    "Cloud Watching",
    "Co-Splaying",
    "Coffee Roasting",
    "Collecting Antiques",
    "Collecting Artwork",
    "Collecting Book",
    "Collecting Buttons",
    "Collecting Card",
    "Collecting Coin",
    "Collecting Comic Books",
    "Collecting Deltiology (Postcard Collecting)",
    "Collecting Diecast Cars",
    "Collecting Elements",
    "Collecting Guns",
    "Collecting Hats",
    "Collecting Insect",
    "Collecting Metal",
    "Collecting Minerals",
    "Collecting Movie Memorabilia",
    "Collecting Music Albums And Records",
    "Collecting Sea Glass",
    "Collecting Seashells",
    "Collecting Sports Cards",
    "Collecting Stamp",
    "Collecting Stones",
    "Collecting Swords",
    "Collecting Tools",
    "Collecting Toys",
    "Collecting Trains",
    "Collecting Video Game",
    "Color Guard",
    "Coloring",
    "Computer Programming",
    "Con-Worlding",
    "Conga Drum",
    "Contrabassoon",
    "Cooking",
    "Cooking Competitions",
    "Cornet",
    "Couponing",
    "Creative",
    "Cricket",
    "Crocheting",
    "Cross Country Running",
    "Cross-Country Skiing",
    "Cross-Stitch",
    "Crossword Puzzles",
    "Cryptography",
    "Curling",
    "Cycling",
    "Cymbals",
    "Dancing",
    "Darts",
    "Debate",
    "Digital Arts",
    "Digital Photography",
    "Dirt Track",
    "Disc Golf",
    "Dodge-Ball",
    "Dog Sports",
    "Dolls",
    "Dolphin Watching",
    "Dominoes",
    "Dowsing",
    "Drag Boat",
    "Drag Racing",
    "Drawing",
    "Driving",
    "Drums",
    "Dulcian",
    "Dumpster Diving",
    "Dynamophone",
    "E-Books",
    "Electronics",
    "Embroidery",
    "Equestrianism – Horseback Riding",
    "Eskrima, Arnis & Kali",
    "Exercise",
    "Falconry",
    "Fantasy Sports",
    "Farming",
    "Fashion",
    "Fellrunning",
    "Felting",
    "Fencing",
    "Field Hockey",
    "Figure Skating",
    "Fire Poi",
    "Firearm Models",
    "Fish Tournaments",
    "Fish-Keeping",
    "Fishing",
    "Flag Football",
    "Flat Track",
    "Floor-Ball",
    "Flower Arranging",
    "Flower Collecting And Pressing",
    "Flute",
    "Flutophone",
    "Flying Drones",
    "Foraging",
    "Formula",
    "Fossil Hunting / Fossilizing",
    "Foster Care Volunteer",
    "Four Wheeling",
    "Freelance Model",
    "Freshwater Aquariums",
    "Frisbee Golf",
    "Gambling",
    "Gardening",
    "Genealogy",
    "Geocaching",
    "Ghost Hunting",
    "Glassblowing",
    "Glockenspiel",
    "Glow-Sticking",
    "Gnoming",
    "Golfing",
    "Gongoozling",
    "Gongs",
    "Graffiti",
    "Grand Prix Motorcycle Racing",
    "Grasstrack (Aka Long Track)",
    "Grilling / Bbq",
    "Guitar",
    "Gundam Models",
    "Gunsmith",
    "Gymnastics",
    "Gyotaku",
    "Handball",
    "Handwriting Analysis",
    "Hapkido",
    "Harmonica",
    "Harp",
    "Harpsichord",
    "Hiking / Backpacking",
    "History",
    "Home Brewing",
    "Home Decorating",
    "Home Theater",
    "Horseback Riding",
    "Hot Air Ballooning",
    "Hula Hooping",
    "Hunting",
    "Hydroplane",
    "Ice Hockey",
    "Illusion",
    "Impersonations",
    "Inline Skating",
    "Inventing",
    "Janggi (Korean Chess)",
    "Jeet Kune Do",
    "Jet Engines",
    "Jet Sprint Boat",
    "Jewelry Making",
    "Jigsaw Puzzles",
    "Jiu-Jitsu",
    "Jogging",
    "Judo",
    "Juggling",
    "Jumping Rope",
    "Karate",
    "Kart",
    "Kayaking",
    "Kendo",
    "Kenpo",
    "Kickboxing",
    "Kicksled",
    "Kitchen Chemistry",
    "Kite Boarding Or Kite Surfing",
    "Kite Flying",
    "Knapping",
    "Knife Throwing",
    "Knife-Making",
    "Knitting",
    "Knotting",
    "Kombucha Brewing",
    "Krav Maga",
    "Kung Fu",
    "Lace-Making",
    "Lacrosse",
    "Lapidary",
    "Larping",
    "Laser Tag",
    "Lawn Darts",
    "Lawnmower",
    "Lego Building",
    "Letter-Boxing",
    "Letters",
    "Live Steam Models",
    "Lock-Picking",
    "Locomotive & Train Models",
    "Lute",
    "Machining",
    "Macramé",
    "Magic",
    "Mahjong",
    "Mandolin",
    "Maracas",
    "Marathon Running",
    "Marbles",
    "Marksmanship",
    "Matchstick Models",
    "Meditation",
    "Metal Detecting",
    "Metallophone",
    "Metalworking",
    "Meteorology",
    "Microscopy",
    "Midget Car",
    "Military Martial Arts",
    "Military Models",
    "Mixed Martial Arts (Mma)",
    "Model Aircraft",
    "Model Cars",
    "Model Commercial Vehicles",
    "Model Construction Vehicles",
    "Model Military Vehicles",
    "Model Rockets",
    "Model Ships",
    "Motocross",
    "Mountain Biking",
    "Mountain Climbing / Mountaineering",
    "Muay Thai",
    "Music Lyrics",
    "Musical Box",
    "Nail Art",
    "Needlepoint",
    "Ninjutsu",
    "Novels",
    "Oboe",
    "Odes-Martenot",
    "Offroad",
    "Offshore Powerboat",
    "Open-Wheel",
    "Origami",
    "Outrigger Canoe",
    "Paintball",
    "Painting",
    "Paper Mache",
    "Paper-Making",
    "Parachuting",
    "Paragliding",
    "Parkour",
    "People Watching",
    "Photography",
    "Piano",
    "Pickup Truck",
    "Pinochle",
    "Pocketbike",
    "Poetry",
    "Poi",
    "Polo",
    "Pottery",
    "Power-Blocking",
    "Production Bike",
    "Production Car",
    "Protesting",
    "Puppetry",
    "Puzzles",
    "Pyrotechnics",
    "Quilting",
    "R/C Boats",
    "R/C Cars",
    "R/C Helicopters",
    "R/C Planes",
    "Racquetball",
    "Rafting",
    "Rail Fans (Trainspotting)",
    "Rail Transport Modeling",
    "Rallycross",
    "Rappelling (Abseiling)",
    "Reading Books",
    "Reading To Children",
    "Reading To The Elderly",
    "Recorder",
    "Renaissance Faire",
    "Rescuing Abused Or Abandoned Animals",
    "Road Bicycle",
    "Road Running",
    "Robotics",
    "Rock Balancing",
    "Rock Climbing",
    "Rocket Shooting",
    "Role-Playing",
    "Roller Derby",
    "Roller Skating",
    "Roller Skiing",
    "Rowing",
    "Rugby",
    "Sailing",
    "Sambo",
    "Sand Art",
    "Sand Castles",
    "Saxophone",
    "Scale Model Building",
    "Scrap-Booking",
    "Scuba Diving",
    "Sculling Or Rowing",
    "Sewing",
    "Shawm",
    "Shooting Sport",
    "Shopping",
    "Shortwave Listening",
    "Singing",
    "Skateboarding",
    "Skeet Shooting",
    "Sketching",
    "Skiing",
    "Skimboarding",
    "Slacklining",
    "Slingshots",
    "Smoking",
    "Snare Drum",
    "Snorkeling",
    "Snowboarding",
    "Snowmobile Racing",
    "Soap-Making",
    "Soccer",
    "Socializing",
    "Songs",
    "Speed Skating",
    "Speed-Cubing (Rubik’S Cube)",
    "Speedway",
    "Spelunking",
    "Sports Car",
    "Sprint Car",
    "Squash",
    "Stand-Up Comedy",
    "Steel Drum",
    "Stock Car",
    "Stone Skipping",
    "Storm Chasing",
    "Storytelling",
    "String Figures",
    "Sudoku",
    "Superbike",
    "Supercross",
    "Supermoto (Aka Supermotard)",
    "Surf Fishing",
    "Surfing",
    "Survivalism",
    "Swimming",
    "Table Football",
    "Table Tennis (Ping Pong)",
    "Taekwondo",
    "Tai Chi",
    "Tambourine",
    "Tang Soo Do",
    "Tatting",
    "Taxidermy",
    "Teach Cooking Lessons",
    "Tennis",
    "Tesla Coils",
    "Tetris",
    "Textiles",
    "Theremin",
    "Topiary",
    "Touring Car",
    "Tower Running",
    "Track Cycling",
    "Track Racing",
    "Track Running",
    "Trail Running",
    "Training Animals",
    "Traveling",
    "Treasure Hunting",
    "Triangle",
    "Trombone",
    "Truck",
    "Trumpet",
    "Tuba",
    "Tutoring Children",
    "Tv Watching",
    "Ukulele",
    "Ultimate Disc",
    "Urban Exploration",
    "Vehicle Restoration",
    "Video Games",
    "Videophilia",
    "Vintage Cars",
    "Violin",
    "Volleyball",
    "Volunteering",
    "War-Hammer",
    "Watching Movies",
    "Watching Sporting Events",
    "Watercraft",
    "Weather Watcher",
    "Whale Watching",
    "Whittling",
    "Windsurfing",
    "Winemaking",
    "Wing Chun",
    "Wingsuit Flying",
    "Woodcarving",
    "Woodworking",
    "World-Building",
    "Wrestling",
    "Wrestling",
    "Xiangqi (Chinese Chess)",
    "Xylophone",
    "Yacht",
    "Zither",
    "Zoo Volunteer",
  ];
}
