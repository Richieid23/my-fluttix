part of 'services.dart';

class UserServices {
  static final CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ''
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    return User(
      id: id,
      email: snapshot.data['email'],
      name: snapshot.data['name'],
      balance: snapshot.data['balance'],
      profilePicture: snapshot.data['profilePicture'],
      selectedGenres: (snapshot.data['selectedGenres'] as List)
          .map((e) => e.toString())
          .toList(),
      selectedLanguage: snapshot.data['selectedLanguage'],
    );
  }
}
