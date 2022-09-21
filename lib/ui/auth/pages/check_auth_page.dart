import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/auth/auth_bloc.dart';
import '../../home/pages/home_page.dart';
import 'sign_in_page.dart';

class CheckAuthPage extends StatefulWidget {
  const CheckAuthPage({Key? key}) : super(key: key);

  @override
  State<CheckAuthPage> createState() => _CheckAuthPageState();
}

class _CheckAuthPageState extends State<CheckAuthPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context, listen: false).add(VerifyAuth());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        return state.isLoggedIn ? const HomePage() : const SignInPage();
      },
    );
  }
}
