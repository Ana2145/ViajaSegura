import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viaja_segura_movil/data/cubits/password/password_cubit.dart';
import 'package:viaja_segura_movil/data/repositories/password_repository.dart';
import 'package:viaja_segura_movil/presentation/screens/edit_password_page.dart';

class EditPasswordButton extends StatelessWidget {
  final String email;

  const EditPasswordButton({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => PasswordCubit(PasswordRepository()),
              child: EditPasswordPage(email: email),
            ),
          ),
        );
      },
    );
  }
}
