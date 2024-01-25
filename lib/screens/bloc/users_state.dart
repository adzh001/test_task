import 'package:task_andrey/screens/user_detail_screen.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  final bool hasReachedMax;

  UsersLoaded({required this.users, this.hasReachedMax = false});
}

class UsersError extends UsersState {
  final String message;
  UsersError({required this.message});
}
