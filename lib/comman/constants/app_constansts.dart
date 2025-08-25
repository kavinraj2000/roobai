class AppConstants {
  const AppConstants();
  static final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  final String emailNullError = "Please enter your email";
  final String invalidEmailError = "Please enter a valid email";
  final String passNullError = "Please enter your password";
  final String shortPassError = "Password is too short";
  final String matchPassError = "Passwords don't match";
  final String nameNullError = "Please enter your name";
  final String phoneNumberNullError = "Please enter your phone number";
  final String addressNullError = "Please enter your address";
}
