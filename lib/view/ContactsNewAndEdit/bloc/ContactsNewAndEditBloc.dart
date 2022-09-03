
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stdev_contact/model/network/requestAndResponseModels/newAndEdit/ResponseUpdateContact.dart';
import '../../../di/di.dart';
import '../../../model/network/requestAndResponseModels/newAndEdit/RequestCreateNewContact.dart';
import '../../../model/network/requestAndResponseModels/newAndEdit/ResponseCreateNewContact.dart';
import '../../../model/network/retApi.dart';
import '../../../utils/InternetConnectionManager.dart';

part 'ContactsNewAndEditEvent.dart';
part 'ContactsNewAndEditState.dart';

class ContactsNewAndEditBloc extends Bloc<ContactsNewAndEditEvent, ContactsNewAndEditState> {

  final RestClient client = getIt();
  InternetConnectionManager internetConnectionManager =  getIt();

  var loginDetail;
  File? imageFile = null;

  ContactsNewAndEditBloc(ContactsNewAndEditState initialState) : super(initialState){

    on<ContactsNewAndEditEvent>(onContactsMainEvent);
  }

  void onContactsMainEvent(ContactsNewAndEditEvent event , Emitter<ContactsNewAndEditState> emit) async {

    if (event is onGalleryNewAndEditEvent) {
      if (!kIsWeb){
        getFromGallery();
      }
    }

    if (event is onCameraNewAndEditEvent) {
      if (!kIsWeb){
        getFromCamera();
      }
    }

    if (event is saveContactsNewAndEditEvent) {
     if (event.id == "") {
       createNewContact(event.requestCreateNewContact);
     } else {
       updateContact(event.id, event.requestCreateNewContact);
     }
    }
  }

  void getFromCamera() async {

    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      emit(imageLoadedContactsNewAndEditState(imageFile));

    }
  }

  void getFromGallery() async {

    PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      emit(imageLoadedContactsNewAndEditState(imageFile));
    }
  }

  void createNewContact(RequestCreateNewContact requestCreateNewContact) async{

    ResponseCreateNewContact responseCreateNewContact = ResponseCreateNewContact();

    bool isInternetConnected = await internetConnectionManager.checkConnection();
    if (isInternetConnected) {
      emit(loadingContactsNewAndEditState());

      try {
        responseCreateNewContact = await client.createNewContact(requestCreateNewContact);
        emit(savedSuccessfullyContactsNewAndEditState());
      } catch (e) {
        emit(savedErrorContactsNewAndEditState("There is a problem, please try again"));
      }
    } else {
      emit(noInternetContactsNewAndEditState());
    }
  }

  void updateContact(String id ,RequestCreateNewContact requestCreateNewContact) async {

    ResponseUpdateContact responseUpdateContact = ResponseUpdateContact();

    bool isInternetConnected = await internetConnectionManager.checkConnection();
    if (isInternetConnected) {
      emit(loadingContactsNewAndEditState());

      try {
        responseUpdateContact = await client.updateContact(id, requestCreateNewContact);
        emit(savedSuccessfullyContactsNewAndEditState());
      } catch (e) {
        emit(savedErrorContactsNewAndEditState("There is a problem, please try again"));
      }
    } else {
      emit(noInternetContactsNewAndEditState());
    }
  }
}


