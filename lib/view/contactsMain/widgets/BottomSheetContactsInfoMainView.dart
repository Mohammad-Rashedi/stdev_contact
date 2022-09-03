

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stdev_contact/model/network/requestAndResponseModels/contactsMain/GetContactsListResponse.dart';

import '../../../values/MyColors.dart';

class BottomSheetContactsInfoMainView extends StatefulWidget {

  Function(BuildContext, GetContactsListResponse) editContact;
  Function(BuildContext, GetContactsListResponse) deleteContact;
  BuildContext myContext;
  GetContactsListResponse contact;

  BottomSheetContactsInfoMainView(
      this.editContact, this.deleteContact, this.myContext, this.contact);

  @override
  BottomSheetContactsInfoMainViewState createState() =>
      BottomSheetContactsInfoMainViewState(editContact, deleteContact, myContext, contact);

}

class BottomSheetContactsInfoMainViewState extends State<BottomSheetContactsInfoMainView>{

  Function(BuildContext, GetContactsListResponse) editContact;
  Function(BuildContext, GetContactsListResponse) deleteContact;
  BuildContext myContext;
  GetContactsListResponse contact;

  BottomSheetContactsInfoMainViewState(
      this.editContact, this.deleteContact, this.myContext, this.contact);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.MainBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 12,right: 20,left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new IconButton(
                      icon: new Image.asset('assets/images/delete_icon.png',width: 35.0,height: 35.0,
                        color: MyColors.ContactsDeleteIconColor,),
                      onPressed: (){
                        deleteContact(myContext, contact);
                      },

                    ),
                    CircleAvatar(
                      backgroundColor: MyColors.ContactsImageBorderColor,
                      radius: 61.0,
                      child: CircleAvatar(
                        backgroundColor: MyColors.ContactsImageBackgroundColor,
                        radius: 60.0,
                        child:
                        // todo handle this
                        // (contactsListResponse.picture == null)?
                        // Image.asset('assets/images/no_image_Profile.png')
                        // :
                        Image.asset('assets/images/no_image_Profile.png'),

                      ),
                    ),
                    new IconButton(
                      icon: new Image.asset('assets/images/edit_icon.png',width: 35.0,height: 35.0,
                        color: MyColors.ContactsEditIconColor,),
                      onPressed: (){
                        editContact(myContext,contact);
                      }

                      ,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "name:",
                    style: TextStyle(
                        color: MyColors.ContactsTitleFieldColor,
                        fontFamily: "Roboto",
                        fontSize: 10
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      "${contact.firstName}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MyColors.ContactsTextFieldColor,
                          fontFamily: "Roboto",
                          fontSize: 15
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "surname:",
                    style: TextStyle(
                        color: MyColors.ContactsTitleFieldColor,
                        fontFamily: "Roboto",
                        fontSize: 10
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      "${contact.lastName}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MyColors.ContactsTextFieldColor,
                          fontFamily: "Roboto",
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: MyColors.ContactsDividerColor,
                  thickness:1,
                  endIndent:20,
                  indent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "phone number:",
                    style: TextStyle(
                        color: MyColors.ContactsTitleFieldColor,
                        fontFamily: "Roboto",
                        fontSize: 10
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      "${contact.phone}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MyColors.ContactsTextFieldColor,
                          fontFamily: "Roboto",
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: MyColors.ContactsDividerColor,
                  thickness:1,
                  endIndent:20,
                  indent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "email:",
                    style: TextStyle(
                        color: MyColors.ContactsTitleFieldColor,
                        fontFamily: "Roboto",
                        fontSize: 10
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      "${contact.email}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: MyColors.ContactsTextFieldColor,
                          fontFamily: "Roboto",
                          fontSize: 15
                      ),
                    ),
                  ),
                ),

                Divider(
                  color: MyColors.ContactsDividerColor,
                  thickness:1,
                  endIndent:20,
                  indent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "notes:",
                    style: TextStyle(
                        color: MyColors.ContactsTitleFieldColor,
                        fontFamily: "Roboto",
                        fontSize: 10
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      "${contact.notes}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: TextStyle(
                          color: MyColors.ContactsTextFieldColor,
                          fontFamily: "Roboto",
                          fontSize: 15
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),

    );
  }




}