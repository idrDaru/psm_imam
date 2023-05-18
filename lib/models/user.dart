class User {
  String email, imageDownloadURL;
  int type;
  bool isVerified;

  User(
    this.type,
    this.email,
    this.imageDownloadURL,
    this.isVerified,
  );
}
