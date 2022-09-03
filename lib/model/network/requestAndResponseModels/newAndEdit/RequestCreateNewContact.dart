

class RequestCreateNewContact {
  String? firstName;
  String? lastName;
  String? email;
  String? notes;
  String? phone;

  RequestCreateNewContact(
      {this.firstName, this.lastName, this.email, this.notes, this.phone});

  RequestCreateNewContact.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    notes = json['notes'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['notes'] = this.notes;
    data['phone'] = this.phone;
    return data;
  }
}