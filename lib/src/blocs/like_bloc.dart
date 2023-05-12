import 'package:demo_project/src/models/like_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class LikeBloc {
  final _likeBlocController = PublishSubject<LikeModel>();

  Stream<LikeModel> get likeStream => _likeBlocController.stream;

  Future<LikeModel> likeSink(String productid, String userid) async {
    return await Repository().likeApiRepository(productid, userid);
  }

  dispose() {
    _likeBlocController.close();
  }
}

final likeBloc = LikeBloc();