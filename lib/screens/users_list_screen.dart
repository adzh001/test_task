import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:task_andrey/screens/bloc/users_bloc.dart';
import 'package:task_andrey/screens/bloc/users_state.dart';
import 'package:task_andrey/screens/user_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersListScreen extends StatefulWidget {
  UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_onScroll);
  // }

  // @override
  // void dispose() {
  //   _scrollController.removeListener(_onScroll);
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _onScroll() {
  //   if (_isBottom) {
  //     final state = context.read<UsersBloc>().state;
  //     if (state is UsersLoaded && !state.hasReachedMax) {
  //       context.read<UsersBloc>().add(LoadUsersEvent());
  //     }
  //   }
  // }

  // bool get _isBottom {
  //   if (!_scrollController.hasClients) return false;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.offset;
  //   return currentScroll >= (maxScroll * 0.9); // для пагинации
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UsersBloc()..add(LoadUsersEvent()),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text(FlutterI18n.translate(context, "hello"))
          ),
          body: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              if (state is UsersLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UsersLoaded) {
                return ListView.builder(
                  //controller: _scrollController,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.users[index].username),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserDetailScreen(user: state.users[index]),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (state is UsersError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('No users found'));
              }
            },
          ),
        ));
  }
}

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://api.github.com/users'));

  if (response.statusCode == 200) {
    List<dynamic> usersJson = json.decode(response.body);
    return usersJson.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
