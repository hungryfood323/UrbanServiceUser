import 'package:demo_project/src/models/serviceRating_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ServiceRatingBloc {
  final _serviceRatingBlocController = PublishSubject<ServiceRatingModel>();

  Stream <ServiceRatingModel> get serviceRatingStream => _serviceRatingBlocController.stream;

  Future<ServiceRatingModel> serviceRatingSink(
    String userid,
    String serviceid,
    String ratings,
    String text,
  ) async {
    return await Repository().serviceRatingRepository(
      userid,
      serviceid,
      ratings,
      text
    );
  }

  dispose() {
    _serviceRatingBlocController.close();
  }
}

final serviceRatingBloc = ServiceRatingBloc();
