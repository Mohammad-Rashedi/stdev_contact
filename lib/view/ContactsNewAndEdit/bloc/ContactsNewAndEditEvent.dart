
part of 'ContactsNewAndEditBloc.dart';


abstract class ContactsNewAndEditEvent {
  const ContactsNewAndEditEvent();
}
class saveContactsNewAndEditEvent extends ContactsNewAndEditEvent {
  String id;
  RequestCreateNewContact requestCreateNewContact;

  saveContactsNewAndEditEvent(this.id, this.requestCreateNewContact);
}
class onGalleryNewAndEditEvent extends ContactsNewAndEditEvent {
}
class onCameraNewAndEditEvent extends ContactsNewAndEditEvent {
}





