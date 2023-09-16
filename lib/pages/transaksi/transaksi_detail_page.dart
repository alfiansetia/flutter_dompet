import 'package:flutter/material.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date: ${transaksi.date ?? ''}"),
                    Text("From: ${transaksi.from?.name ?? ''}"),
                    Text("To: ${transaksi.to?.name ?? ''}"),
                    Text("Amount: ${transaksi.amount ?? ''}"),
                    Text("Cost: ${transaksi.cost ?? ''}"),
                    Text("Status: ${transaksi.status ?? ''}"),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
