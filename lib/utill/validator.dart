class Validator{

  static String isEmail(String? email){
    //String message = '';
    if(email!.isEmpty){
     return  "please enter email address";
    }
    else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
     return  "Please enter a valid email address";
    }
    return "";
  }

  static String isPassword(String? password){
    if(password!.isEmpty){
      return "please enter password";
    }
    else if(password.length < 6){
      return "password must be more than 6 letter";
    }
    return "";
  }
}