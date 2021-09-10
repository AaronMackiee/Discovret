

import 'package:discovret1_0/FirebaseServices/db_services.dart';

import 'db_models.dart';



/// Static global state. Immutable services that do not care about build context. 
class Global {

  static final UserData<DbUserDiscSearchList> discSearchListRef = UserData<DbUserDiscSearchList>(collection: 'UserDiscSearchList');
  static final UserData<DbUserProfileInfo> dbProfileInfoRef = UserData<DbUserProfileInfo>(collection: 'UserProfileInfo');  

    // Data Models
  static final Map models = {
    DbUserDiscSearchList: (data) => DbUserDiscSearchList.fromMap(data: data),
    DbUserProfileInfo: (data) => DbUserProfileInfo.fromMap(data: data)
  };

}