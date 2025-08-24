class AppConstants {
  const AppConstants();
  static final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static const String emailNullError = "Please enter your email";
  static const String invalidEmailError = "Please enter a valid email";
  static const String passNullError = "Please enter your password";
  static const String shortPassError = "Password is too short";
  static const String matchPassError = "Passwords don't match";
  static const String nameNullError = "Please enter your name";
  static const String phoneNumberNullError = "Please enter your phone number";
  static const String addressNullError = "Please enter your address";
}
