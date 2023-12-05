class LoginModel {
  String? email;
  String? password;

  LoginModel({
    this.email,
    this.password,
  });

  bool get isValid {
    return email != null && password != null;
  }
}
