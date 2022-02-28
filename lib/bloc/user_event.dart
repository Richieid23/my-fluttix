part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final String id;

  const LoadUser(this.id);
}

class SignOut extends UserEvent {}

class UpdateData extends UserEvent {
  final String name;
  final String profilePicture;

  const UpdateData({this.name, this.profilePicture});
}
