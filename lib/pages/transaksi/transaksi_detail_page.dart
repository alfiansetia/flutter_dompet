import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi_form/transaksi_form_bloc.dart';
import 'package:flutter_dompet/utils/price_ext.dart';

import '../../utils/color_resources.dart';

class TransaksiDetailPage extends StatelessWidget {
  final String title;
  final int id;
  TransaksiDetailPage({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    context.read<TransaksiFormBloc>().add(DetailTransaksiFormEvent(id: id));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<TransaksiFormBloc, TransaksiFormState>(
          builder: (context, state) {
            if (state.status == TransaksiFormStatus.loaded) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Date: ${state.model.date ?? ''}"),
                    Text("From: ${state.model.from?.name ?? ''}"),
                    Text("To: ${state.model.to?.name ?? ''}"),
                    Text('Amount:' +
                        '${(state.model.amount ?? '0')}'.formatPrice()),
                    Text(
                        'Cost:' + '${(state.model.cost ?? '0')}'.formatPrice()),
                    Text('Revenue:' +
                        '${(state.model.revenue ?? '0')}'.formatPrice()),
                    Text("Status: ${state.model.status ?? ''}"),
                    Text("User: ${state.model.user!.name ?? ''}"),
                    Expanded(
                      child: Image.network(state.model.image!),
                    )
                  ],
                ),
              );
            } else if (state.status == TransaksiFormStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.error.message),
                    ElevatedButton(
                      onPressed: () async {
                        context
                            .read<TransaksiFormBloc>()
                            .add(DetailTransaksiFormEvent(id: id));
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
