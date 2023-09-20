import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/dompet/dompet_bloc.dart';
import 'package:flutter_dompet/bloc/dompet_form/dompet_form_bloc.dart';
import 'package:flutter_dompet/bloc/login/login_bloc.dart';
import 'package:flutter_dompet/bloc/logout/logout_bloc.dart';
import 'package:flutter_dompet/bloc/navigation/navigation_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi/transaksi_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi_form/transaksi_form_bloc.dart';
import 'package:flutter_dompet/data/datasources/auth_local_datasoutce.dart';
import 'package:flutter_dompet/pages/auth/auth_page.dart';
import 'package:flutter_dompet/pages/dashboard/dashboard_page.dart';
import 'package:flutter_dompet/utils/light_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => DompetBloc(),
        ),
        BlocProvider(
          create: (context) => DompetFormBloc(),
        ),
        BlocProvider(
          create: (context) => TransaksiBloc(),
        ),
        BlocProvider(
          create: (context) => TransaksiFormBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: light,
          home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!) {
                return DashboardPage();
              } else {
                return const AuthPage();
              }
            },
          )),
    );
  }
}
