class SignUpModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? reEnterPassword;
  bool? rememberMe;

  SignUpModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.reEnterPassword,
    this.rememberMe,
  });

  bool get isValid {
    return firstName != null &&
        lastName != null &&
        email != null &&
        password != null &&
        reEnterPassword != null &&
        password == reEnterPassword;
  }
}
