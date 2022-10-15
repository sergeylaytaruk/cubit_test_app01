import 'package:cubit_test_app01/bloc/user_bloc.dart';
import 'package:cubit_test_app01/bloc/user_event.dart';
import 'package:cubit_test_app01/cubit/internet_cubit.dart';
import 'package:cubit_test_app01/services/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cubit_test_app01/widgets/action_buttons.dart';
import 'package:cubit_test_app01/widgets/user_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                UserBloc(userRepository: context.read<UserRepository>())
                  ..add(UserLoadEvent()),
          ),
          BlocProvider(create: (context) => ConnectionCubit()),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<ConnectionCubit, MyConnectionState>(
              builder: (context, state) => state.connected
                  ? const Text('User List (online)')
                  : const Text(
                      'offline!',
                      style: TextStyle(color: Colors.red),
                    ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ActionButtons(),
              Expanded(child: UserList()),
            ],
          ),
        ),
      ),
    );
  }
}
