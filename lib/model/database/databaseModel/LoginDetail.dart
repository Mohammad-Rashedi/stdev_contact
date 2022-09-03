

class LoginDetail {

  int? id;
  bool isLoggedIn;

  LoginDetail(this.id, this.isLoggedIn);

  LoginDetail.withoutId(this.isLoggedIn);

  LoginDetail.fromJson(Map<String, dynamic> json)
      : id =  json['id'],
        isLoggedIn = json['isLoggedIn'] == 1;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'isLoggedIn': isLoggedIn ? 1 : 0
      };

}

