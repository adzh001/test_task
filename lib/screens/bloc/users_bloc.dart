import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:task_andrey/screens/bloc/users_state.dart';
import 'package:task_andrey/screens/user_detail_screen.dart';
import 'package:task_andrey/screens/users_list_screen.dart';

part 'users_event.dart';

// class UsersBloc extends Bloc<UsersEvent, UsersState> {
//   UsersBloc() : super(UsersInitial()) {
//     int currentPage = 1;
//     bool hasReachedMax = false;
//     List<User> currentUsers = [];
//     on<LoadUsersEvent>((event, emit) async {
//       if (hasReachedMax) return;
//       if (currentPage == 1) emit(UsersLoading());

//       try {
//         List<User> newUsers = await fetchUsers(currentPage);
//         final allUsers = List<User>.from(currentUsers)
//           ..addAll(newUsers); // Объединение старых и новых пользователей
//         bool isMax = newUsers.length < 10;
//         emit(UsersLoaded(
//             users: allUsers,
//             hasReachedMax:
//                 isMax)); // Обновление состояния с новым полным списком пользователей
//         if (!isMax) {
//           currentPage++;
//         } else {
//           hasReachedMax = true;
//         }
//         currentUsers = allUsers; // Обновление текущего списка пользователей
//       } catch (e) {
//         emit(UsersError(message: e.toString()));
//       }
//     });
//   }
// }
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<LoadUsersEvent>((event, emit) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        emit(UsersError(message: "No Internet Connection"));
        return;
      }

      emit(UsersLoading());
      try {
        List<User> users = await fetchUsers();
        emit(UsersLoaded(users: users));
      } catch (e) {
        emit(UsersError(message: e.toString()));
      }
    });
  }
}
