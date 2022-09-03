
part of 'ContactsMainBloc.dart';


abstract class ContactsMainEvent {
  const ContactsMainEvent();
}

class getListContactsMainEvent extends ContactsMainEvent {
}


class createNewContactsMainEvent extends ContactsMainEvent {

}

class onRefreshContactsMainEvent extends ContactsMainEvent {

}

class deleteContactsMainEvent extends ContactsMainEvent {
  String id;

  deleteContactsMainEvent(this.id);
}

class logOutContactsMainEvent extends ContactsMainEvent {

}




