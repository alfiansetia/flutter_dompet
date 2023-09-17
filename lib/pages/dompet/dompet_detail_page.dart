import 'package:flutter/material.dart';
import 'package:flutter_dompet/data/models/dompet.dart';

import '../../utils/color_resources.dart';

class DompetDetailPage extends StatelessWidget {
  final _scrollController = ScrollController();
  final String title;
  final Dompet dompet;
  DompetDetailPage({super.key, required this.dompet, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              Text('data')
              // BlocBuilder<DompetBloc, DompetState>(
              //   builder: (context, state) {
              //     return state.maybeWhen(
              //       orElse: () {
              //         print('whem');
              //         return const SliverPadding(
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //           sliver: SliverToBoxAdapter(
              //             child: Center(
              //               child: CircularProgressIndicator(),
              //             ),
              //           ),
              //         );
              //       },
              //       loading: () {
              //         print('loadinmg');
              //         return const SliverPadding(
              //           padding: EdgeInsets.symmetric(horizontal: 16),
              //           sliver: SliverToBoxAdapter(
              //             child: Center(
              //               child: CircularProgressIndicator(),
              //             ),
              //           ),
              //         );
              //       },
              //       error: (message) {
              //         return SliverPadding(
              //           padding: const EdgeInsets.symmetric(horizontal: 16),
              //           sliver: SliverToBoxAdapter(
              //             child: Center(
              //               child: Text(message),
              //             ),
              //           ),
              //         );
              //       },
              //       detailLoaded: (model) {
              //         return SliverToBoxAdapter(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text("Name: ${model.name ?? ''}"),
              //               Text("Acc Name: ${model.accName ?? ''}"),
              //               Text("Acc No: ${model.accNumber ?? ''}"),
              //               Text("Type: ${model.type ?? ''}"),
              //               Text("Saldo: ${model.saldo ?? '0'}"),
              //             ],
              //           ),
              //         );
              //       },
              //     );
              //   },
              // )
            ],
          ),
        ],
      )),
    );
  }
}
