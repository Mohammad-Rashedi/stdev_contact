
part of 'ContactsNewAndEditBloc.dart';


abstract class ContactsNewAndEditState {
  const ContactsNewAndEditState();
}
class initialContactsNewAndEditState extends ContactsNewAndEditState {}
class loadingContactsNewAndEditState extends ContactsNewAndEditState {}
class savedSuccessfullyContactsNewAndEditState extends ContactsNewAndEditState {
}
class savedErrorContactsNewAndEditState extends ContactsNewAndEditState {
  String errorMessage;
  savedErrorContactsNewAndEditState(
      this.errorMessage);
}
class imageLoadedContactsNewAndEditState extends ContactsNewAndEditState {
  File? imageFile;

  imageLoadedContactsNewAndEditState(this.imageFile);
}
class noInternetContactsNewAndEditState extends ContactsNewAndEditState {
}



