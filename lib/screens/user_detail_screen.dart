import 'dart:ffi';

import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 220, 214, 212),
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(user.username), 
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.network(
            user.avatarUrl,
            width: 270,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            user.username,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.url,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.received_events_url,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.events_url,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.repos_url,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.organizations_url,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.subscriptions_url,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.gravatar_id,
            style: const TextStyle(fontSize: 17),
          ),
          Text(
            user.html_url,
            style: const TextStyle(fontSize: 17),
          ),
        ]),
      ),
    );
  }
}

class User {
  final String username;
  final String avatarUrl;
  final String type;
  final String received_events_url;
  final bool site_admin;
  final String events_url;
  final String repos_url;
  final String organizations_url;
  final String subscriptions_url;
  final String starred_url;
  final String gists_url;
  final String following_url;
  final String followers_url;
  final String html_url;
  final String url;
  final String gravatar_id;
  final String node_id;
  final int id;

  User(
      {required this.username,
      required this.avatarUrl,
      required this.events_url,
      required this.followers_url,
      required this.following_url,
      required this.gists_url,
      required this.gravatar_id,
      required this.html_url,
      required this.id,
      required this.node_id,
      required this.organizations_url,
      required this.received_events_url,
      required this.repos_url,
      required this.site_admin,
      required this.starred_url,
      required this.subscriptions_url,
      required this.type,
      required this.url});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['login'],
      avatarUrl: json['avatar_url'],
      type: json['type'],
      events_url: json['events_url'],
      followers_url: json['followers_url'],
      following_url: json['following_url'],
      gists_url: json['gists_url'],
      gravatar_id: json['gravatar_id'],
      html_url: json['html_url'],
      node_id: json['node_id'],
      organizations_url: json['organizations_url'],
      received_events_url: json['received_events_url'],
      repos_url: json['repos_url'],
      site_admin: json['site_admin'] as bool,
      starred_url: json['starred_url'],
      subscriptions_url: json['subscriptions_url'],
      url: json['url'],
      id: json['id'],
    );
  }
}
