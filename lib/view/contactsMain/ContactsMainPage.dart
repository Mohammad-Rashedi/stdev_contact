
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stdev_contact/view/contactsMain/widgets/BottomSheetContactsInfoMainView.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:stdev_contact/view/login/LoginPage.dart';
import '../../di/di.dart';
import '../../model/network/requestAndResponseModels/contactsMain/GetContactsListResponse.dart';
import '../../utils/snackBarHelper.dart';
import '../../values/MyColors.dart';
import '../ContactsNewAndEdit/ContactsNewAndEditPage.dart';
import 'bloc/ContactsMainBloc.dart';

class ContactsMainPage extends StatefulWidget {

  @override
  ContactsMainPageState createState() => ContactsMainPageState();
}

class ContactsMainPageState extends State<ContactsMainPage> {

  List<GetContactsListResponse> contactsListResponse = [];
  SnackBarHelper snackBarHelper = getIt();
  BuildContext? myContext;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => ContactsMainBloc(initialContactsMainState()),
      child: BlocBuilder<ContactsMainBloc , ContactsMainState>(
        builder: (context, state) {
          myContext = context;
          return BlocListener<ContactsMainBloc , ContactsMainState>(
            listener: (context, state){

              if (state is loadedSuccessfullyContactsMainState) {
                contactsListResponse = state.contactsListResponse;
              }
              if (state is deleteErrorContactsMainState) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar(state.errorMessage));
              }
              if (state is deleteSuccessContactsMainState) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showSuccessSnackBar(state.successMessage));
              }
              if (state is noInternetContactsMainState) {
                ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("No Internet connection."));
              }
            },
            child: WillPopScope(
              onWillPop: () async {
                MoveToBackground.moveTaskToBack();
                return false;
              },
              child: Scaffold (
                  backgroundColor: MyColors.MainBackgroundColor,
                  appBar:
                  AppBar(
                    backgroundColor: MyColors.AppBarBackgroundColor,
                    centerTitle: true,
                    automaticallyImplyLeading: false,
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
                      "Contacts",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: MyColors.AppBarTextColor,
                          fontFamily: "Roboto",
                          fontSize: 20
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconButton(
                          onPressed: () {
                            if (state is loadingContactsMainState){
                             ScaffoldMessenger.of(context).showSnackBar(snackBarHelper.showErrorSnackBar("Please wait"));
                            } else {
                              onRefresh(context);
                            }
                          }, icon: new Image.asset(
                            'assets/images/refresh_icon.png',
                          color: MyColors.AppBarTextColor,
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<ContactsMainBloc>(myContext!).add(logOutContactsMainEvent());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => LoginPage()));
                          }, icon: new Image.asset(
                            'assets/images/logout_icon.png',
                          color: MyColors.AppBarTextColor,
                        ),
                        ),
                      ),
                    ],
                  ),

                  body: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                    child:
                    (state is loadingContactsMainState || state is deleteSuccessContactsMainState)?
                    SpinKitFadingCircle(
                      color:  MyColors.LoadingSpinkitColor,
                      size: 20.0,
                    )
                        :
                    (state is loadedNotFoundContactsMainState)?
                    Center(child: Text("No contact found",
                      style: TextStyle(
                          color: MyColors.ContactsErrorTextColor,
                          fontFamily: "Roboto",
                          fontSize: 15
                      ),))
                        :
                    (state is loadedSuccessfullyContactsMainState || state is noInternetContactsMainState)?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: contactsListResponse.length
                              ,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    showBottomSheetContactsInfo(context, contactsListResponse[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                                    child: Card(
                                      elevation: 5,
                                      color: MyColors.White,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: MyColors.SetStatusNotSentListBorderColor, width: 1),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          )),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/contact_item_background.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: MyColors.ContactsImageBorderColor,
                                                  radius: 31.0,
                                                  child: CircleAvatar(
                                                    backgroundColor: MyColors.ContactsImageBackgroundColor,
                                                    radius: 30.0,
                                                    child:
                                                    // todo handle this
                                                    // (contactsListResponse.picture == null)?
                                                    // Image.asset('assets/images/no_image_Profile.png')
                                                    // :
                                                    Image.asset('assets/images/no_image_Profile.png'),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            "Name:",
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
                                                            width: 170,
                                                            child: Text(
                                                              "${contactsListResponse[index].firstName}",
                                                              overflow: TextOverflow.ellipsis,
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
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            "Phone:",
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
                                                            width: 170,
                                                            child: Text(
                                                              "${contactsListResponse[index].phone}",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                  color: MyColors.ContactsTextFieldColor,
                                                                  fontFamily: "Roboto",
                                                                  fontSize: 15
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ],
                    )
                        :
                    (state is loadedErrorContactsMainState)?
                    Center(child: Text("${state.errorMessage}",
                      style: TextStyle(
                          color: MyColors.ContactsErrorTextColor,
                          fontFamily: "Roboto",
                          fontSize: 15
                      ),))
                        :
                    SpinKitFadingCircle(
                      color:  MyColors.LoadingSpinkitColor,
                      size: 20.0,
                    ),
                  ),
                  floatingActionButton: GestureDetector(
                    onTap: () {
                      goToNewContactPage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/fab_add_background.png"),),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      width: 50.0,
                      height: 50.0,
                      child: new IconButton(
                        splashColor: MyColors.Transparent,
                        highlightColor: MyColors.Transparent,
                        hoverColor: MyColors.Transparent,
                        icon: new Image.asset('assets/images/add_icon.png',width: 20.0,height: 20.0,
                          color: MyColors.White,),
                        onPressed: (){
                          goToNewContactPage();
                        },
                      ),
                    ),
                  )
              ),
            ),
          );
        },
      ),

    );

  }

  void onRefresh(BuildContext context){

    BlocProvider.of<ContactsMainBloc>(context).add(onRefreshContactsMainEvent());
  }

  showBottomSheetContactsInfo(BuildContext context1, GetContactsListResponse contact){

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColors.Transparent,
        context: context1,
        builder: (BuildContext context1) {
          return  StatefulBuilder(
              builder: (context1, StateSetter setState) {
                return BottomSheetContactsInfoMainView(editContact, showDeleteContactDialog, context1, contact);
              }
          );
        }
    ).then((value) => {
    });
  }

  editContact(BuildContext context, GetContactsListResponse contact){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactsNewAndEditPage(contact)));
  }

  showDeleteContactDialog(BuildContext context1, GetContactsListResponse contact){

    showDialog(context: context1,
        builder: (BuildContext context1){
          return AlertDialog(
            title: Text("Delete Contact",
                  style: TextStyle(
                      color: MyColors
                          .DeleteDialogTitleColor,
                      fontFamily: "Roboto",
                      fontSize: 16
                  ),
                ),
            content: Text(" Do you want to delete this contact?",
                  style: TextStyle(
                      color: MyColors
                          .DeleteDialogTextColor,
                      fontFamily: "Roboto",
                      fontSize: 14
                  ),),
            actions: [
              TextButton(
                child: Text("Cancel",
                  style: TextStyle(
                      color: MyColors
                          .DeleteDialogCancelButtonColor,
                      fontFamily: "Roboto",
                      fontSize: 14
                  ),),
                onPressed:  () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text("Delete",
                  style: TextStyle(
                      color: MyColors
                          .DeleteDialogDeleteButtonColor,
                      fontFamily: "Roboto",
                      fontSize: 14
                  ),
                ),
                onPressed:  () {
                  deleteContact(context1, contact.id!);
                },
              )
            ],
          );
        });
  }

  void deleteContact(BuildContext context1, String id) {

    BlocProvider.of<ContactsMainBloc>(myContext!).add(deleteContactsMainEvent(id));
    Navigator.pop(context1);
    Navigator.pop(context1);
  }

  void goToNewContactPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactsNewAndEditPage.newContact()));
  }
}