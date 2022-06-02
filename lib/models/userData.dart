class UserDate {
  final String? userName;
  final String? userEmail;
  final String? userImage;
  final String? userPhoneNamber;

  UserDate(
      {  this.userName,   this.userEmail,
          this.userImage,   this.userPhoneNamber});
}

UserDate userDate = UserDate(
  userName: 'A.Kahraba',
  userImage: 'lib/images/user.jpg',
  userEmail: 'AhmedIbrahim1310@ilcoud.com',
  userPhoneNamber: '0155105150',
);

class UserApp {
  static String? userToken;
  static String? userName;
  static String? userEmail;

  static String? userPhoneNum;
  static String? userAge;
  static String? userStutes;
  static String? userGender;
  static String? userPassword;
  static var appLang;
  static var apiLang;
  static String? userlat;
  static String? userlong;
  static String? prefs;
  static bool? userLogIn;
  static bool? userSkipLogIn;
  static bool? onBoarding;
}
