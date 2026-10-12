import 'package:flutter/foundation.dart';
import '../../models/user_profile.dart';
import '../mock/mock_user.dart';

/// In-memory state store for user profile during the active session.
/// Keeps mock data separate from presentation widgets and allows UI updates to reflect across screens.
class UserProfileStore extends ChangeNotifier {
  UserProfileStore._() : _currentUser = mockCurrentUser;

  static final UserProfileStore instance = UserProfileStore._();

  UserProfile _currentUser;

  UserProfile get currentUser => _currentUser;

  void updateProfile(UserProfile updatedProfile) {
    _currentUser = updatedProfile;
    notifyListeners();
  }

  void reset() {
    _currentUser = mockCurrentUser;
    notifyListeners();
  }
}
