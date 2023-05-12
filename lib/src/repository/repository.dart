import 'dart:io';

import 'package:demo_project/src/models/addtocart_model.dart';
import 'package:demo_project/src/models/bookService_model.dart';
import 'package:demo_project/src/models/catService_model.dart';
import 'package:demo_project/src/models/changePass_model.dart';
import 'package:demo_project/src/models/changeStatus_model.dart';
import 'package:demo_project/src/models/getAllProdCat.dart';
import 'package:demo_project/src/models/getBooking_model.dart';
import 'package:demo_project/src/models/getCartItem.dart';
import 'package:demo_project/src/models/getProdByCat_model.dart';
import 'package:demo_project/src/models/getService_model.dart';
import 'package:demo_project/src/models/home_model.dart';
import 'package:demo_project/src/models/like_model.dart';
import 'package:demo_project/src/models/login_model.dart';
import 'package:demo_project/src/models/productDetail_model.dart';
import 'package:demo_project/src/models/profile_model.dart';
import 'package:demo_project/src/models/removecart_model.dart';
import 'package:demo_project/src/models/serviceDetail_model.dart';
import 'package:demo_project/src/models/serviceList_model.dart';
import 'package:demo_project/src/models/serviceRating_model.dart';
import 'package:demo_project/src/models/signup_model.dart';
import 'package:demo_project/src/models/store_model.dart';
import 'package:demo_project/src/models/uProfile_model.dart';
import 'package:demo_project/src/models/unLike_model.dart';
import 'package:demo_project/src/provider/addServiceRating_api.dart';
import 'package:demo_project/src/provider/addtocart_api.dart';
import 'package:demo_project/src/provider/bookservice_api.dart';
import 'package:demo_project/src/provider/catService_api.dart';
import 'package:demo_project/src/provider/category_api.dart';
import 'package:demo_project/src/provider/changepass_api.dart';
import 'package:demo_project/src/provider/changestatus_api.dart';
import 'package:demo_project/src/provider/getBooking_api.dart';
import 'package:demo_project/src/provider/getService_api.dart';
import 'package:demo_project/src/provider/getcart_api.dart';
import 'package:demo_project/src/provider/home_api.dart';
import 'package:demo_project/src/provider/like_api.dart';
import 'package:demo_project/src/provider/login_api.dart';
import 'package:demo_project/src/provider/productdetail_api.dart';
import 'package:demo_project/src/provider/profile_api.dart';
import 'package:demo_project/src/provider/removecart_api.dart';
import 'package:demo_project/src/provider/servicedetail_api.dart';
import 'package:demo_project/src/provider/servicelist_api.dart';
import 'package:demo_project/src/provider/signup_api.dart';
import 'package:demo_project/src/provider/store_api.dart';
import 'package:demo_project/src/provider/storedetail_api.dart';
import 'package:demo_project/src/provider/uProfile_api.dart';
import 'package:demo_project/src/provider/unlike_api.dart';

class Repository {
  Future<Loginmodel> loginApiRepository(
      String username, String password, String token) async {
    return await LoginApi().loginApi(username, password, token);
  }

  Future<SignupModel> signupRepository(
    String email,
    String password,
    String username,
  ) async {
    return await SignupApi().signupApi(
      email,
      password,
      username,
    );
  }

  Future<ChangePassModal> changePassRepository(
    String userid,
    String password,
    String npassword,
    String cusername,
  ) async {
    return await ChangePassApi()
        .changepassApi(userid, password, npassword, cusername);
  }

  Future<ServiceListModel> serviceApiRepository() async {
    return await ServiceListApi().serviceListApi();
  }

  Future<ServiceDetailModel> serviceDetailsApiRepository(String id) async {
    return await ServiceDetailApi().serviceDetailApi(id);
  }

  Future<GetProdByCatID> storeApiRepository(String id) async {
    return await StoreApi().storeApi(id);
  }

  Future<GetAllProdCategory> categoryApiRepository() async {
    return await CategoryApi().categoryApi();
  }

  Future<ProfileModel> profileRepository(String userID) async {
    return await ProfileApi().profileApi(userID);
  }

  Future<CategoryServiceModel> catServiceRepository(String id) async {
    return await CatServiceApi().catServiceApi(id);
  }

  Future<StoreModel> storeDetailRepository(String id) async {
    return await StoreDetailApi().storeDetailApi(id);
  }

  Future<UprofileModel> uProfile(
      String email,
      String username,
      String id,
      String mobile,
      String address,
      String city,
      String country,
      File? image) async {
    return await UprofileApi().uProfileApi(
        email, username, id, mobile, address, city, country, image);
  }

  Future<HomeModel> homeApiRepository() async {
    return await HometApi().homeApi();
  }

  Future<ProductDetailModel> productDeatilApiRepository(String id) async {
    return await ProductDetailApi().productDetailApi(id);
  }

  Future<AddToCartModel> addtocartRepository(
      String quantity, String userID, String productID) async {
    return await AddtocartApi().addtocartApi(
      quantity,
      userID,
      productID,
    );
  }

  Future<LikeModel> likeApiRepository(String productid, String userid) async {
    return await LikeApi().likeApi(productid, userid);
  }

  Future<UnLikeModel> unlikeApiRepository(
      String productid, String userid) async {
    return await UnLikeApi().unLikeApi(productid, userid);
  }

  Future<GetCartModel> getCartApiRepository(String id) async {
    return await GetCartApi().getCartApi(id);
  }

  Future<RemoveCartModel> removeCartApiRepository(String id) async {
    return await RemovecartApi().removecartApi(id);
  }

  Future<GetBookingModel> getBookingApiRepository(
      String userid, String status) async {
    return await GetBookingApi().getBookingApi(userid, status);
  }

  Future<ChangeStatusModel> changeStatusApiRepository(
      String id, String status) async {
    return await ChangeStatusApi().changeStatusApi(id, status);
  }

  Future<GetServiceModel> getserviceApiRepository(String id) async {
    return await GetServiceByStoreApi().getServiceApi(id);
  }

  Future<BookServiceModel> bookServiceRepository(
    String userid,
    String serviceid,
    String resid,
    String vid,
    String date,
    String slot,
    String address,
    String notes,
  ) async {
    return await BookServiceApi().bookServiceApi(
        userid, serviceid, resid, vid, date, slot, address, notes);
  }

  Future<ServiceRatingModel> serviceRatingRepository(
    String userid,
    String serviceid,
    String ratings,
    String text,
  ) async {
    return await ServiceRatingApi()
        .serviceRatingApi(userid, serviceid, ratings, text);
  }

  // Future<UpdateProImg> uProfileImg(
  //     String email,
  //     String username,
  //     File image,
  //     String id,
  //     String mobile,
  //     String address,
  //     String city,
  //     String country) async {
  //   return await UprofileImgApi().uProfileimgApi(
  //       email, username, image, id, mobile, address, city, country);
  // }

}
