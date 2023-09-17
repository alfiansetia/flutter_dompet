import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi/transaksi_bloc.dart';
import 'package:flutter_dompet/data/models/transaksi.dart';

import '../../utils/color_resources.dart';

class TransaksiDetailPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final String title;
  final Transaksi transaksi;
  TransaksiDetailPage(
      {super.key, required this.transaksi, required this.title});

  @override
  Widget build(BuildContext context) {
    // context
    //     .read<TransaksiBloc>()
    //     .add(FetchShowTransaksiEvent(id: transaksi.id.toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // backgroundColor: ColorResources.getHomeBg(context),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: BlocBuilder<TransaksiBloc, TransaksiState>(
                  builder: (context, state) {
                    print(state.model.toString());
                    if (state.status == TransaksiStatus.loading) {
                      return CircularProgressIndicator();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: ${transaksi.date ?? ''}"),
                        Text("From: ${transaksi.from?.name ?? ''}"),
                        Text("To: ${transaksi.to?.name ?? ''}"),
                        Text("Amount: ${transaksi.amount ?? ''}"),
                        Text("Cost: ${transaksi.cost ?? ''}"),
                        Text("Status: ${transaksi.status ?? ''}"),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
