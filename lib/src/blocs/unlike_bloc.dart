import 'package:demo_project/src/models/unLike_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UnLikeBloc {
  final _unlikeBlocController = PublishSubject<UnLikeModel>();

  Stream<UnLikeModel> get unlikeStream => _unlikeBlocController.stream;

  Future<UnLikeModel> unlikeSink(String productid, String userid) async {
    return await Repository().unlikeApiRepository(productid, userid);
  }

  dispose() {
    _unlikeBlocController.close();
  }
}

final unLikeBloc = UnLikeBloc();
