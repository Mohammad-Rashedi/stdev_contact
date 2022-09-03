

import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:stdev_contact/model/network/requestAndResponseModels/contactsMain/GetContactsListResponse.dart';
import 'package:stdev_contact/model/network/requestAndResponseModels/newAndEdit/RequestCreateNewContact.dart';
import 'package:stdev_contact/model/network/requestAndResponseModels/newAndEdit/ResponseCreateNewContact.dart';
import 'package:stdev_contact/model/network/requestAndResponseModels/newAndEdit/ResponseDeleteContact.dart';
import 'package:stdev_contact/model/network/requestAndResponseModels/newAndEdit/ResponseUpdateContact.dart';

import 'networlUrlConstants.dart';

part 'retApi.g.dart';

@RestApi(baseUrl: NetworkURLConstants.baseURL)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;


  @GET("contacts")
  @Headers({
    "x-api-key": "62e3e6d11894fe7edea71921"
    })
  Future<List<GetContactsListResponse>> getContactsList();

  @POST("contacts")
  @Headers({
    "x-api-key": "62e3e6d11894fe7edea71921"
  })
  Future<ResponseCreateNewContact> createNewContact(@Body() RequestCreateNewContact requestCreateNewContact);

  @PUT("contacts/{objectId}")
  @Headers({
    "x-api-key": "62e3e6d11894fe7edea71921"
  })
  Future<ResponseUpdateContact> updateContact(@Path("objectId") String objectId, @Body() RequestCreateNewContact requestCreateNewContact);


  @DELETE("contacts/{objectId}")
  @Headers({
    "x-api-key": "62e3e6d11894fe7edea71921"
  })
  Future<ResponseDeleteContact> deleteContact(@Path("objectId") String objectId);




}