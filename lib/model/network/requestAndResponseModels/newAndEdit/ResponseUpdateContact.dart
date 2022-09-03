



class ResponseUpdateContact {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? notes;
  String? phone;
  String? sCreated;
  String? sChanged;
  String? sCreatedby;
  String? sChangedby;
  List<String>? lKeywords;
  String? sTags;
  int? iVersion;

  ResponseUpdateContact(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.notes,
        this.phone,
        this.sCreated,
        this.sChanged,
        this.sCreatedby,
        this.sChangedby,
        this.lKeywords,
        this.sTags,
        this.iVersion});

  ResponseUpdateContact.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    notes = json['notes'];
    phone = json['phone'];
    sCreated = json['_created'];
    sChanged = json['_changed'];
    sCreatedby = json['_createdby'];
    sChangedby = json['_changedby'];
    lKeywords = json['_keywords'].cast<String>();
    sTags = json['_tags'];
    iVersion = json['_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['notes'] = this.notes;
    data['phone'] = this.phone;
    data['_created'] = this.sCreated;
    data['_changed'] = this.sChanged;
    data['_createdby'] = this.sCreatedby;
    data['_changedby'] = this.sChangedby;
    data['_keywords'] = this.lKeywords;
    data['_tags'] = this.sTags;
    data['_version'] = this.iVersion;
    return data;
  }
}
