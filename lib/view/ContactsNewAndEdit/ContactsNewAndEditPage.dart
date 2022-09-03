







import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stdev_contact/model/network/requestAndResponseModels/newAndEdit/RequestCreateNewContact.dart';
import 'package:stdev_contact/utils/snackBarHelper.dart';
import 'package:stdev_contact/view/contactsMain/ContactsMainPage.dart';

import '../../di/di.dart';
import '../../model/network/requestAndResponseModels/contactsMain/GetContactsListResponse.dart';
import '../../utils/StringManager.dart';
import '../../values/MyColors.dart';
import 'bloc/ContactsNewAndEditBloc.dart';

class ContactsNewAndEditPage extends StatefulWidget {

  GetContactsListResponse? contactsListResponse;

  ContactsNewAndEditPage(this.contactsListResponse);

  ContactsNewAndEditPage.newContact();

  @override
  ContactsNewAndEditPageState createState() => ContactsNewAndEditPageState(contactsListResponse);

}

class ContactsNewAndEditPageState extends State<ContactsNewAndEditPage> {

  GetContactsListResponse? contactsListResponse;

  ContactsNewAndEditPageState(this.contactsListResponse);

  StringManager stringManager = getIt();
  SnackBarHelper snackBarHelper = getIt();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final notesController = TextEditingController();
  File? imageFile = null;
  @override
  void initState() {
    super.initState();
    if (contactsListResponse != null){
      firstNameController.text = contactsListResponse!.firstName?? "";
      lastNameController.text =  contactsListResponse!.lastName?? "";
      phoneNumberController.text =  contactsListResponse!.phone.toString();
      emailController.text =  contactsListResponse!.email?? "";
      notesController.text =  contactsListResponse!.notes?? "";
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ContactsNewAndEditBloc(initialContactsNewAndEditState()),
      child: BlocBuilder<ContactsNewAndEditBloc , ContactsNewAndEditState>(
        builder: (context, state) {
          return BlocListener<ContactsNewAndEditBloc , ContactsNewAndEditState>(
            listener: (context, state){

              if (state is savedSuccessfullyContactsNewAndEditState) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showSuccessSnackBar("Contact added."));
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactsMainPage()));
              }
              if (state is savedErrorContactsNewAndEditState) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("There is a problem."));
              }
              if (state is noInternetContactsNewAndEditState) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("No Internet connection."));
              }
              if (state is imageLoadedContactsNewAndEditState) {
               setState(() {
                 imageFile = state.imageFile;
               });

              }
            },
            child: Scaffold (
                backgroundColor: MyColors.MainBackgroundColor,
                appBar:
                AppBar(
                  backgroundColor: MyColors.AppBarBackgroundColor,
                  centerTitle: true,
                  flexibleSpace: Container(
                    decoration:
                    BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/appbar_background.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title:  Text(
                    (contactsListResponse == null)?
                    "New Contact"
                        :
                    "Edit Contact",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: MyColors.AppBarTextColor,
                        fontFamily: "Roboto",
                        fontSize: 20
                    ),
                  ),
                ),

                body: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),

                  child:
                  (state is loadingContactsNewAndEditState)?
                  SpinKitFadingCircle(
                    color:  MyColors.LoadingSpinkitColor,
                    size: 20.0,
                  )
                      :
                  (state is initialContactsNewAndEditState || state is imageLoadedContactsNewAndEditState || state is savedErrorContactsNewAndEditState)?

                  Column(
                    children: [
                      Container(
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(padding: const EdgeInsets.all(8.0),
                                    child:  TextField(
                                      keyboardType: TextInputType.text,
                                      controller: firstNameController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        fillColor: MyColors.ContactsNewAndEditPageFieldBackgroundColor,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.ContactsNewAndEditPageFieldFocusedBorderColor,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: MyColors.ContactsNewAndEditPageFieldEnabledBorderColor,
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                15.0)),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 15),
                                        labelText: "name",
                                        labelStyle: TextStyle(
                                          color: MyColors
                                              .ContactsNewAndEditPageFieldLabelColor,
                                          fontFamily: "Roboto",
                                          fontSize: 15
                                        ),
                                        alignLabelWithHint: true,
                                      ),
                                      style: TextStyle(
                                        color: MyColors
                                            .ContactsNewAndEditPageFieldTextColorColor,
                                        fontFamily: "Roboto",
                                        fontSize: 20
                                      ),
                                      textAlign: TextAlign.left,
                                    ),

                                ),
                                Padding(padding: const EdgeInsets.all(8.0),
                                  child:  TextField(
                                    keyboardType: TextInputType.text,
                                    controller: lastNameController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      fillColor: MyColors.ContactsNewAndEditPageFieldBackgroundColor,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldFocusedBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldEnabledBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 15),
                                      labelText: "last name",
                                      labelStyle: TextStyle(
                                          color: MyColors
                                              .ContactsNewAndEditPageFieldLabelColor,
                                          fontFamily: "Roboto",
                                          fontSize: 15
                                      ),
                                      alignLabelWithHint: true,
                                    ),
                                    style: TextStyle(
                                        color: MyColors
                                            .ContactsNewAndEditPageFieldTextColorColor,
                                        fontFamily: "Roboto",
                                        fontSize: 20
                                    ),
                                    textAlign: TextAlign.left,
                                  ),

                                ),
                                Padding(padding: const EdgeInsets.all(8.0),
                                  child:  TextField(
                                    keyboardType: TextInputType.phone,
                                    controller: phoneNumberController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      fillColor: MyColors.ContactsNewAndEditPageFieldBackgroundColor,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldFocusedBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldEnabledBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 15),
                                      labelText: "phone",
                                      labelStyle: TextStyle(
                                          color: MyColors
                                              .ContactsNewAndEditPageFieldLabelColor,
                                          fontFamily: "Roboto",
                                          fontSize: 15
                                      ),
                                      alignLabelWithHint: true,
                                    ),
                                    style: TextStyle(
                                        color: MyColors
                                            .ContactsNewAndEditPageFieldTextColorColor,
                                        fontFamily: "Roboto",
                                        fontSize: 20
                                    ),
                                    textAlign: TextAlign.left,
                                  ),

                                ),
                                Padding(padding: const EdgeInsets.all(8.0),
                                  child:  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      fillColor: MyColors.ContactsNewAndEditPageFieldBackgroundColor,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldFocusedBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldEnabledBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 15),
                                      labelText: "email",
                                      labelStyle: TextStyle(
                                          color: MyColors
                                              .ContactsNewAndEditPageFieldLabelColor,
                                          fontFamily: "Roboto",
                                          fontSize: 15
                                      ),
                                      alignLabelWithHint: true,
                                    ),
                                    style: TextStyle(
                                        color: MyColors
                                            .ContactsNewAndEditPageFieldTextColorColor,
                                        fontFamily: "Roboto",
                                        fontSize: 20
                                    ),
                                    textAlign: TextAlign.left,
                                  ),

                                ),
                                Padding(padding: const EdgeInsets.all(8.0),
                                  child:  TextField(
                                    keyboardType: TextInputType.multiline,
                                    controller: notesController,
                                    obscureText: false,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      fillColor: MyColors.ContactsNewAndEditPageFieldBackgroundColor,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldFocusedBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: MyColors.ContactsNewAndEditPageFieldEnabledBorderColor,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.all(const Radius.circular(8.0)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      labelText: "notes",
                                      labelStyle: TextStyle(
                                          color: MyColors
                                              .ContactsNewAndEditPageFieldLabelColor,
                                          fontFamily: "Roboto",
                                          fontSize: 15
                                      ),
                                      alignLabelWithHint: true,
                                    ),
                                    style: TextStyle(
                                        color: MyColors
                                            .ContactsNewAndEditPageFieldTextColorColor,
                                        fontFamily: "Roboto",
                                        fontSize: 20
                                    ),
                                    textAlign: TextAlign.left,
                                  ),

                                ),
                                Container(),
                                new Divider(
                                  color: MyColors.ContactsDividerColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "profile logo",
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: MyColors.ContactsNewAndEditPageFieldLabelColor,
                                          fontSize: 15,
                                          fontFamily: "Roboto"
                                      ),
                                    textAlign: TextAlign.center,),
                                  ),
                                ),
                                Padding(padding: const EdgeInsets.all(8.0),
                                  child:
                                  SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Flexible(

                                          flex:1,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child:
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: InkWell(
                                                        onTap: (){
                                                          onGalley(context);
                                                        },
                                                        child: Card(
                                                          elevation: 0,
                                                          color: MyColors.MainBackgroundColor,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                          ),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/images/blue_bakground_item.png'
                                                                    ),
                                                                    fit: BoxFit.cover
                                                                )
                                                            ),
                                                            child: Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(2.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Flexible(
                                                                      flex:1,
                                                                      child: Padding(padding: const EdgeInsets.all(5.0),

                                                                        child: new Image.asset(
                                                                          'assets/images/icon_gallery.png',
                                                                          color: MyColors.ContactsNewAndEditPageIconColor,

                                                                        ),

                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 1,
                                                                      child: Padding(padding: const EdgeInsets.only(bottom: 0),
                                                                        child: Text(
                                                                          "Gallery",
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: MyColors.ContactsNewAndEditPageIconColor,
                                                                              fontSize: 15,
                                                                              fontFamily: "Roboto"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child:
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: InkWell(
                                                        onTap: (){

                                                          onCamera(context);
                                                        },
                                                        child: Card(
                                                          elevation: 0,
                                                          color: MyColors.MainBackgroundColor,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                          ),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/images/blue_bakground_item.png'
                                                                    ),
                                                                    fit: BoxFit.cover
                                                                )
                                                            ),
                                                            child: Directionality(
                                                              textDirection: TextDirection.rtl,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(2.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Flexible(
                                                                      flex:1,
                                                                      child: Padding(padding: const EdgeInsets.all(5.0),
                                                                          child: new Image.asset(
                                                                            'assets/images/icon_camera.png',
                                                                            color: MyColors.ContactsNewAndEditPageIconColor,
                                                                          )
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 1,
                                                                      child: Padding(padding: const EdgeInsets.only(bottom: 0),
                                                                        child: Text(
                                                                          "Camera",
                                                                          textAlign: TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: MyColors.ContactsNewAndEditPageIconColor,
                                                                              fontSize: 15,
                                                                              fontFamily: "Roboto"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),

                                        Flexible(
                                          flex:1,
                                          child:
                                          CircleAvatar(
                                            backgroundColor: MyColors.ContactsImageBorderColor,
                                            radius: 51.0,
                                            child: CircleAvatar(

                                              backgroundColor: MyColors.ContactsImageBackgroundColor,
                                              backgroundImage:
                                              (imageFile != null)?
                                              FileImage(imageFile!)
                                              :
                                                  null,
                                              radius: 50.0,
                                              child:
                                              (imageFile == null)?
                                              Image.asset('assets/images/no_image_Profile.png')
                                              :
                                              Container(
                                            ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      new Divider(
                        color: MyColors.ContactsDividerColor,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/button_background_blue.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextButton(
                                        child:
                                        Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: MyColors.ButtonTextContactNewEditColor,
                                              fontSize: 18,
                                              fontFamily: "Roboto"
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/button_background_green.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextButton(
                                        child:
                                        Text(
                                          "Save",
                                          style: TextStyle(
                                              color: MyColors.ButtonTextContactNewEditColor,
                                              fontSize: 18,
                                              fontFamily: "Roboto"
                                          ),
                                        ),
                                        onPressed: () {
                                          onConfirm(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  :
                  SpinKitFadingCircle(
                    color:  MyColors.LoadingSpinkitColor,
                    size: 20.0,
                  ),
                ),
            ),
          );
        },
      ),
    );
  }

  void onGalley(BuildContext context) {
    BlocProvider.of<ContactsNewAndEditBloc>(context).add(onGalleryNewAndEditEvent());

  }
  void onCamera(BuildContext context) {
    BlocProvider.of<ContactsNewAndEditBloc>(context).add(onCameraNewAndEditEvent());
  }

  void onConfirm(BuildContext context) {

    if (stringManager.isEmptyOrSpace(firstNameController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter your name."));
    } else if (stringManager.isEmptyOrSpace(lastNameController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter your last name."));
    } else if (stringManager.isEmptyOrSpace(phoneNumberController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter your phone."));
    } else if (stringManager.isEmptyOrSpace(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter your email."));
    }else if (!stringManager.validateEmail(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter your email correctly."));
    } else if (stringManager.isEmptyOrSpace(notesController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please enter note."));
    } else {
      String id = "";
      if (contactsListResponse!= null){
        id = contactsListResponse!.id!;
      }
      RequestCreateNewContact requestCreateNewContact = RequestCreateNewContact(
        firstName: firstNameController.text, lastName: lastNameController.text,
        email: emailController.text, phone: phoneNumberController.text,
        notes: notesController.text
      );
      BlocProvider.of<ContactsNewAndEditBloc>(context).add(saveContactsNewAndEditEvent(id , requestCreateNewContact));
    }
  }
}