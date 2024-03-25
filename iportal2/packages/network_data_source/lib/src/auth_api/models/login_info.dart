class LoginInfo {
  final String access_token;


  LoginInfo({
    required this.access_token,
  });

  factory LoginInfo.fromMap(Map<String, dynamic> map) {
   
    return LoginInfo(
      access_token: map['access_token']
    );
  }
}