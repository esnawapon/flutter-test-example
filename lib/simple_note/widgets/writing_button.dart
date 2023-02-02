import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_example/simple_note/bloc/app_cubit.dart';
import 'package:flutter_test_example/simple_note/widgets/new_note.dart';

class WritingButton extends StatelessWidget {
  const WritingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return BlocConsumer<AppCubit, AppState>(
      listenWhen: (pre, cur) => pre.status != cur.status,
      listener: (context, state) async {
        if (state.status == AppStatus.writing) {
          await showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .4,
                  child: BlocProvider.value(
                    value: cubit,
                    child: const NewNote(),
                  ),
                ),
              );
            },
          );
          cubit.toggleWriting();
        }
      },
      buildWhen: (pre, cur) => pre.status != cur.status,
      builder: (context, state) {
        if (state.status == AppStatus.writing) {
          return Container();
        }
        return FloatingActionButton(
          key: const Key("writing_button"),
          onPressed: cubit.toggleWriting,
          child: const Icon(Icons.edit),
        );
      },
    );
  }
}
