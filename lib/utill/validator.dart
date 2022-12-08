class Validator{
  static String? pass;
  // static String isEmail(String? email){
  //   //String message = '';
  //   if(email!.isEmpty){
  //    return  "please enter email address";
  //   }
  //   if (RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
  //    return  "Please enter a valid email address";
  //   }
  //   return "";
  // }
  static String? isEmail(String? email) {
    if (email!.isEmpty) {
      return 'please enter email address';
    }
    else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? isPassword(String? password){
    if(password!.isEmpty){
      return "please enter password";
    }
    else if(password.length < 6){
      return "password must be more than 6 letter";
    }
    else{
      pass = password.toString();
    }
    return null;
  }

  static String? isConfirmPassword(String? confirmPassword) {
    if (confirmPassword!.isEmpty) {
      return 'please enter confirm password';
    }
    else if (confirmPassword.isNotEmpty) {
      if (confirmPassword.length < 6) {
        return 'confirm password must be more than 6 letter';
      }
      else if (pass != confirmPassword.trim().toString()) {
        return "password did not match";
      }
     // return null;
    }
    return null;
  }

  static String? isName(String? uname){
    if (uname!.isEmpty) {
      return "please enter username";
    }
    return null;
  }
}