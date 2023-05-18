class User {
  String email, profileFilePath, profileFileName;
  int type;
  bool isVerified;

  User(
    this.type,
    this.email,
    this.profileFileName,
    this.profileFilePath,
    this.isVerified,
  );
}
