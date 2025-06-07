class Validators {
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp nameRegex = RegExp(r'^[a-zA-Z ]{2,50}$');

  static final RegExp phoneNumberRegex = RegExp(r'^[0-9]{10,15}$');
}
