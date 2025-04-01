import 'package:flutter/material.dart';
import 'package:viaja_segura_movil/presentation/widgets/organisms/user_profile_form.dart';
import 'package:viaja_segura_movil/presentation/widgets/templates/profile_template.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileTemplate(
      title: 'Profile',
      child: UserProfileForm(),
    );
  }
}
