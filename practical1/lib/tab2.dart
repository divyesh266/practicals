import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:practical1/models/userdata.dart';

import 'models/user.dart';
import 'models/user_bloc.dart';

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<dynamic>>(
        valueListenable: Hive.box('users').listenable(),
        builder: (BuildContext context, Box<dynamic> userBox, Widget widget) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final UserData user = userBox.getAt(index) as UserData;
              return ListTile(
                  leading: CircleAvatar(
                      child: Image(image: NetworkImage(user.avatarUrl))),
                  title: Text(user.loginName),
                  trailing: IconButton(
                    onPressed: () {
                      final UserData user = userBox.getAt(index) as UserData;
                      final List<User> allUser =
                          BlocProvider.of<UserBloc>(context).allUsers;
                      for (int i = 0; i < allUser.length; i++) {
                        if (user.loginName == allUser[i].loginName) {
                          BlocProvider.of<UserBloc>(context, listen: false)
                              .add(ChangeBookmark(index: i, newValue: false));
                        }
                      }
                      userBox.deleteAt(index);
                    },
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ));
            },
            itemCount: userBox.length,
          );
        });
  }
}
