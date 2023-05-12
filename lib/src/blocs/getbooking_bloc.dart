import 'package:demo_project/src/models/getBooking_model.dart';

import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';


class GetBookingBloc {
   final _getBookingController = PublishSubject<GetBookingModel>();

  Stream <GetBookingModel> get getBookingStream => _getBookingController.stream;

  Future getBookingSink(String userid, String status) async {
    GetBookingModel getBookingModal = await Repository().getBookingApiRepository(userid,status);
    _getBookingController.sink.add(getBookingModal);
  }

  dispose() {
    _getBookingController.close();
  }
}

final getBookingBloc = GetBookingBloc();