import 'package:flutter_test/flutter_test.dart';
import 'package:model_bottom/utill/utill.dart';

void main() {
  group("User Name", () {
    test("username", () {
      String? uname = Validator.isName("");
      expect(uname, "please enter username");
    });
  });

  group("email", () {
    test("email is empty", () {
      String? email = Validator.isEmail("");
      expect(email, "please enter email address");
    });

    test("email is not Valid", () {
      String? email = Validator.isEmail("pdgmail.com");
      expect(email, "Please enter a valid email address");
    });
  });

  group("password", () {
    test("password is empty", () {
      String? pass = Validator.isPassword("");
      expect(pass, "please enter password");
    });

    test("password length check", () {
      String? pass = Validator.isPassword("123");
      expect(pass, "password must be more than 6 letter");
    });

    test("confirm password is Empty", () {
      String? conPass = Validator.isConfirmPassword("");
      expect(conPass, "please enter confirm password");
    });

    test("confirm password length check", () {
      String? conPass = Validator.isConfirmPassword("123456");
      expect(conPass, "confirm password must be more than 6 letter");
    });

    test("confirm password & password", () {
      String? conPass = Validator.isConfirmPassword("1234567");
      if(conPass != "1234567") {
        expect(conPass, "password did not match");
      }
    });
  });
}
