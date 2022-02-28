part of 'models.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguage;
  final int balance;

  const User(
      {@required this.id,
      @required this.email,
      this.name,
      this.profilePicture,
      this.selectedGenres,
      this.selectedLanguage,
      this.balance});

  User copyWith({String name, String profilePicture, int balance}) => User(
      id: id,
      email: email,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      selectedGenres: selectedGenres,
      selectedLanguage: selectedLanguage,
      balance: balance ?? this.balance);

  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  @override
  List<Object> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedLanguage,
        balance
      ];
}
