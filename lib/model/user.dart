class UserInfo {
  late String userId;
  late String email;
  late int admin;

  UserInfo(String userId, String email, int admin) {
    this.userId = userId;
    this.email = email;
    this.admin = admin;
  }
}

UserInfo globalSessionData = new UserInfo("", "", 0);

//Having a clear function is pretty handy
void clearSessionData() {
  globalSessionData = new UserInfo("", "", 0);
}
