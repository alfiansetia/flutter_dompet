import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi/transaksi_bloc.dart';
import 'package:flutter_dompet/pages/transaksi/transaksi_detail_page.dart';
// import 'package:flutter_dompet/data/models/transaksi.dart';
import 'package:flutter_dompet/pages/transaksi/widgets/transaksi_item_widget.dart';

import '../../utils/color_resources.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(bool reload) async {
    context.read<TransaksiBloc>().add(const TransaksiEvent.getAll());
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    _loadData(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              BlocBuilder<TransaksiBloc, TransaksiState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                    error: (message) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: Text(message),
                          ),
                        ),
                      );
                    },
                    loaded: (model) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Card(
                                child: TransaksiItemWidget(
                                  transaksi: model.data![index],
                                ),
                              );
                            },
                            childCount: model.data!.length,
                          ),
                        ),
                      );
                    },
                    detailLoaded: (model) => TransaksiDetailPage(
                      title: 'Detail',
                      transaksi: model,
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
