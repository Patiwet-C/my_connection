class CommonRegex {
  CommonRegex._();

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9]{8,}$');
}
