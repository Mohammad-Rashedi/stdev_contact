
part of 'ContactsMainBloc.dart';


abstract class ContactsMainState {
  const ContactsMainState();
}

class initialContactsMainState extends ContactsMainState {}

class loadingContactsMainState extends ContactsMainState {}

class loadedSuccessfullyContactsMainState extends ContactsMainState {

  List<GetContactsListResponse> contactsListResponse;

  loadedSuccessfullyContactsMainState(this.contactsListResponse);
}

class loadedNotFoundContactsMainState extends ContactsMainState {

}

class loadedErrorContactsMainState extends ContactsMainState {
  String errorMessage;

  loadedErrorContactsMainState(this.errorMessage);
}

class deleteErrorContactsMainState extends ContactsMainState {
  String errorMessage;

  deleteErrorContactsMainState(this.errorMessage);
}
class deleteSuccessContactsMainState extends ContactsMainState {
  String successMessage;

  deleteSuccessContactsMainState(this.successMessage);
}

class noInternetContactsMainState extends ContactsMainState {
}


