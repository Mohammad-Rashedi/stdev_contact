
import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../di/di.dart';
import '../../../model/database/databaseModel/LoginDetail.dart';
import '../../../model/database/dbHelper.dart';
import '../../../model/network/requestAndResponseModels/contactsMain/GetContactsListResponse.dart';
import '../../../model/network/requestAndResponseModels/newAndEdit/ResponseDeleteContact.dart';
import '../../../model/network/retApi.dart';
import '../../../utils/InternetConnectionManager.dart';

part 'ContactsMainEvent.dart';
part 'ContactsMainState.dart';


class ContactsMainBloc extends Bloc<ContactsMainEvent, ContactsMainState> {

  final RestClient client = getIt();
  InternetConnectionManager internetConnectionManager =  getIt();

  List<GetContactsListResponse> contactsListResponse = [];

  ContactsMainBloc(ContactsMainState initialState) : super(initialState){

    on<ContactsMainEvent>(onContactsMainEvent);

    intit();

  }

  void onContactsMainEvent(ContactsMainEvent event , Emitter<ContactsMainState> emit) async {

    if (event is getListContactsMainEvent) {
      getList();
    }
    if (event is logOutContactsMainEvent) {
      DBHelper.instance.updateLoginDetailTable(new LoginDetail(1, false));
    }
    if (event is onRefreshContactsMainEvent){
      contactsListResponse.clear();
      getList();
    }
    if (event is deleteContactsMainEvent){

      deleteContact(event.id);
      contactsListResponse.clear();
      getList();
    }
  }

  void intit() async {

    getList();

  }

  Future<void> getList() async {

    bool isInternetConnected = await internetConnectionManager.checkConnection();
    if (isInternetConnected) {

      emit(loadingContactsMainState());

      try {
        contactsListResponse = await client.getContactsList();
        if (contactsListResponse.length == 0) {
          emit(loadedNotFoundContactsMainState());
        } else {
          emit(loadedSuccessfullyContactsMainState(contactsListResponse));
        }
      } catch (e) {
        emit(loadedErrorContactsMainState("There is a problem, please refresh list"));
      }
    } else {
      emit(noInternetContactsMainState());
    }
  }

  void deleteContact(String id) async {

    bool isInternetConnected = await internetConnectionManager.checkConnection();
    if (isInternetConnected) {

      emit(loadingContactsMainState());
      ResponseDeleteContact responseDeleteContact;
      try {
        responseDeleteContact = await client.deleteContact(id);
        contactsListResponse.clear();
        emit(deleteSuccessContactsMainState("Contact successfully deleted."));

      } catch (e) {
        emit(deleteErrorContactsMainState("There is a problem in deleting contact."));
      }
      getList();
    } else {
      emit(noInternetContactsMainState());
    }
  }
}