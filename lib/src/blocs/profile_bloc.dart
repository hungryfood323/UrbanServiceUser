import 'package:demo_project/src/models/profile_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc {
  final _profile = PublishSubject<ProfileModel>();

  Stream <ProfileModel> get profileStream => _profile.stream;

  Future profileSink(String userID) async {
    ProfileModel profileModal = await Repository().profileRepository(userID);
    _profile.sink.add(profileModal);
  }

  dispose() {
    _profile.close();
  }
}

final profileBloc = ProfileBloc();
