import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/dompet_form/dompet_form_bloc.dart';

import '../../utils/color_resources.dart';

class DompetDetailPage extends StatelessWidget {
  final String title;
  final int id;
  DompetDetailPage({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    context.read<DompetFormBloc>().add(DetailDompetFormEvent(id: id));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<DompetFormBloc, DompetFormState>(
          builder: (context, state) {
            if (state.status == DompetFormStatus.loaded) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Name: ${state.model.name ?? ''}"),
                    Text("Acc Name: ${state.model.accName ?? ''}"),
                    Text("Acc No: ${state.model.accNumber ?? ''}"),
                    Text("Type: ${state.model.type ?? ''}"),
                    Text("Saldo: ${state.model.saldo ?? '0'}"),
                  ],
                ),
              );
            } else if (state.status == DompetFormStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.error.message),
                    ElevatedButton(
                      onPressed: () async {
                        context
                            .read<DompetFormBloc>()
                            .add(DetailDompetFormEvent(id: id));
                      },
                      child: Text('Refresh'),
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
