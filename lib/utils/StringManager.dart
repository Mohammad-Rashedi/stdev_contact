



class StringManager{


  bool isEmptyOrSpace(String? text){
    print('StringManager.isEmptyOrSpace');
    return text!.isEmpty;
  }

  String deleteSpaces(String text){
    return text.replaceFirst(new RegExp(r"\s+"), "");
  }

  bool validateEmail(String email){
    print('StringManager.validateEmail email $email');

    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      caseSensitive: false,
      multiLine: false,
    );

    print('StringManager.validateEmail email $email');
    print('StringManager.validateEmail ${regExp.hasMatch(email)}');
    return regExp.hasMatch(email);

  }

}