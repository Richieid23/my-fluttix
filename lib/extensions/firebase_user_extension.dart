part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser(
          {String name = 'No Name',
          List<String> selectedGenres = const [],
          String selectedLanguage = 'English',
          int balance = 50000}) =>
      User(
          id: uid,
          email: email,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);
}
