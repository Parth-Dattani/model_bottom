import 'package:flutter_test/flutter_test.dart';
import 'package:model_bottom/controller/login_controller.dart';
import 'package:model_bottom/utill/utill.dart';

void main() {
  group("email", () {
    test("email is empty", () {
      String? result = Validator.isEmail("");

      expect(result, "please enter email address");
    });

    test("email is not Valid", () {
      String? result = Validator.isEmail("parthgmail.com");
      //String? result = Validator.isEmail(LoginController().emailController.value.text);
      expect(result, "Please enter a valid email address");
    });
  });

  group("password", () {
    test("password is empty", () {
      String? result = Validator.isPassword("");
      expect(result, "please enter password");
    });

    test("password length check ", () {
      String? result = Validator.isPassword("123456");
      expect(result, "password must be more than 6 letter");

    });
  });
}
