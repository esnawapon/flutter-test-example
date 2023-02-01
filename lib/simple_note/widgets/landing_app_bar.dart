import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/simple_note/bloc/app_cubit.dart';

class LandingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LandingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: const Key("landing_page_app_bar"),
      title: const Text("Simple Note"),
      actions: [
        BlocSelector<AppCubit, AppState, bool>(
          selector: (state) => state.isLoading,
          builder: (context, isLoading) {
            if (isLoading) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
