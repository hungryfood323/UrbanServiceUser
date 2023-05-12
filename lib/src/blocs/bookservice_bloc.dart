import 'package:demo_project/src/models/bookService_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class BookServiceBloc {
  final _bookServiceBlocController = PublishSubject<BookServiceModel>();

  Stream <BookServiceModel> get bookServiceStream => _bookServiceBlocController.stream;

  Future<BookServiceModel> bookServiceSink(
    String userid,
    String serviceid,
    String resid,
    String vid,
    String date,
    String slot,
    String address,
    String notes,
  ) async {
    return await Repository().bookServiceRepository(
      userid,
      serviceid,
      resid,
      vid,
      date,
      slot,
      address,
      notes
    );
  }

  dispose() {
    _bookServiceBlocController.close();
  }
}

final bookServiceBloc = BookServiceBloc();
