import 'dart:developer';

import 'package:cubit_test_app01/bloc/user_bloc.dart';
import 'package:cubit_test_app01/bloc/user_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: ((context, state) {
        log(state.toString());
        if (state is UserLoadedState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Users is Loaded')));
        }
      }),
      builder: (context, state) {
        if (state is UserEmptyState) {
          return const Center(
            child: Text(
              'No data received. Press button "Load"',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        if (state is UserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserLoadedState) {
          return CupertinoScrollbar(
            child: ListView.builder(
              itemCount: state.loadedUser.length,
              itemBuilder: (context, index) => Container(
                color: index % 2 == 0 ? Colors.white : Colors.blue[50],
                child: ListTile(
                  leading: Text(
                    'ID: ${state.loadedUser[index].id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.loadedUser[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Email: ${state.loadedUser[index].email}',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        'Phone: ${state.loadedUser[index].phone}',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        if (state is UserErrorState) {
          return const Center(
            child: Text(
              'Error load users',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
