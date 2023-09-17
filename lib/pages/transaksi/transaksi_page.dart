import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi/transaksi_bloc.dart';
import 'package:flutter_dompet/pages/transaksi/transaksi_detail_page.dart';
import 'package:flutter_dompet/pages/transaksi/widgets/transaksi_item_widget.dart';

import '../../utils/color_resources.dart';

class TransaksiPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TransaksiBloc>().add(const FetchAllTransaksiEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              BlocConsumer<TransaksiBloc, TransaksiState>(
                listener: (context, state) {
                  if (state.status == TransaksiStatus.detailLoaded) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransaksiDetailPage(
                            transaksi: state.detail, title: "detail"),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == TransaksiStatus.loading) {
                    return const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  if (state.status == TransaksiStatus.loaded) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Card(
                              child: TransaksiItemWidget(
                                transaksi: state.model.data![index],
                              ),
                            );
                          },
                          childCount: state.model.data!.length,
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.error.message),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      )),
    );
  }
}
