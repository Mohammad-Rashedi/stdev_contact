



  class GetContactsListResponse {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? notes;
  bool? bMock;

  GetContactsListResponse(
  {this.id,
  this.firstName,
  this.lastName,
  this.phone,
  this.email,
  this.notes,
  this.bMock});

  GetContactsListResponse.fromJson(Map<String, dynamic> json) {
  id = json['_id'];
  firstName = json['firstName'];
  lastName = json['lastName'];
  phone = json['phone'];
  email = json['email'];
  notes = json['notes'];
  bMock = json['_mock'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['_id'] = this.id;
  data['firstName'] = this.firstName;
  data['lastName'] = this.lastName;
  data['phone'] = this.phone;
  data['email'] = this.email;
  data['notes'] = this.notes;
  data['_mock'] = this.bMock;
  return data;
  }
  }