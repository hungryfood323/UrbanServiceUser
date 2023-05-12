import 'package:demo_project/src/models/home_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';


class HomeBloc {
   final _homeBlocController = PublishSubject<HomeModel>();

  Stream <HomeModel> get homeStream => _homeBlocController.stream;

  Future homeSink() async {
    HomeModel homeModal =
        await Repository().homeApiRepository();
    _homeBlocController.sink.add(homeModal);
  }

  dispose() {
    _homeBlocController.close();
  }
}

final homeBloc = HomeBloc();
