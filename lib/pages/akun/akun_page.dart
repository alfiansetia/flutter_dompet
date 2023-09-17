import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/logout/logout_bloc.dart';
import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/pages/auth/auth_page.dart';

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state.status == LogoutStatus.loaded) {
          AuthLocalDatasource().removeAuthData();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return const AuthPage();
          }), (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Logout Successfully'),
            backgroundColor: Colors.blue,
          ));
        }
        if (state.status == LogoutStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error.message),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        if (state.status == LogoutStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<LogoutBloc>().add(FetchLogoutEvent());
            },
            child: const Text('Logout'),
          ),
        );
      },
    );
  }
}
