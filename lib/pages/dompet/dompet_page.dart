import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/dompet/dompet_bloc.dart';
import 'package:flutter_dompet/pages/dompet/dompet_detail_page.dart';
import 'package:flutter_dompet/pages/home/widgets/dompet_item_widget.dart';
import 'package:flutter_dompet/utils/color_resources.dart';

class DompetListPage extends StatefulWidget {
  const DompetListPage({super.key});

  @override
  State<DompetListPage> createState() => _DompetListPageState();
}

class _DompetListPageState extends State<DompetListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<DompetBloc>().add(const DompetEvent.getAll(limit: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dompet'),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              BlocBuilder<DompetBloc, DompetState>(
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
                    loading: () {
                      return const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
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
                                child: DompetItemWidget(
                                  dompet: model.data![index],
                                ),
                              );
                            },
                            childCount: model.data!.length,
                          ),
                        ),
                      );
                    },
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
