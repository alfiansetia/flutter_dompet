// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/transaksi/transaksi_bloc.dart';
// import 'package:flutter_dompet/pages/transaksi/transaksi_add_page.dart';
import 'package:flutter_dompet/pages/transaksi/widgets/transaksi_item_widget.dart';

import '../../utils/color_resources.dart';

class TransaksiPage extends StatefulWidget {
  TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _refreshData();
    _scrollController.addListener(_onScroll);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final bloc = context.read<TransaksiBloc>();

    if (currentScroll >= (maxScroll * 0.9) &&
        bloc.state.status == TransaksiStatus.loaded &&
        !bloc.state.hasMax &&
        !(bloc.state.status == TransaksiStatus.loading)) {
      final nextPage = bloc.state.page + 1;
      bloc.add(FetchAllTransaksiEvent(page: nextPage));
    }
  }

  Future<void> _refreshData([String status = 'success']) async {
    context
        .read<TransaksiBloc>()
        .add(FetchAllTransaksiEvent(page: 1, query: 'status=${status}'));
  }

  Future<void> _getData(String status) async {
    context
        .read<TransaksiBloc>()
        .add(FetchAllTransaksiEvent(page: 1, query: 'status=${status}'));
  }

  Widget _showMessage(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: _refreshData,
            child: Text('Refresh'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
        bottom: TabBar(
          onTap: (value) {
            if (value == 0) {
              _getData('success');
            } else {
              _getData('cancel');
            }
          },
          controller: _tabController,
          tabs: [
            Tab(text: 'Done'),
            Tab(text: 'Cancel'),
          ],
        ),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        controller: _tabController,
        children: [
          RefreshIndicator(
            child: SafeArea(
              child: BlocBuilder<TransaksiBloc, TransaksiState>(
                builder: (context, state) {
                  if (state.status == TransaksiStatus.error) {
                    return _showMessage(state.error.message);
                  } else {
                    final isLoading = state.status == TransaksiStatus.loading;
                    if (isLoading && state.model.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return state.model.isEmpty
                          ? _showMessage('No Data')
                          : ListView.builder(
                              controller: _scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  state.model.length + (isLoading ? 1 : 0),
                              itemBuilder: (BuildContext context, int index) {
                                if (index < state.model.length) {
                                  return Card(
                                    child: TransaksiItemWidget(
                                      transaksi: state.model[index],
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            );
                    }
                  }
                },
              ),
            ),
            onRefresh: () => _refreshData('success'),
          ),
          RefreshIndicator(
            child: SafeArea(
              child: BlocBuilder<TransaksiBloc, TransaksiState>(
                builder: (context, state) {
                  if (state.status == TransaksiStatus.error) {
                    return _showMessage(state.error.message);
                  } else {
                    // if(state.status == TransaksiStatus.loaded && state.sta)
                    final isLoading = state.status == TransaksiStatus.loading;
                    if (isLoading && state.model.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return state.model.isEmpty
                          ? _showMessage('No Data')
                          : ListView.builder(
                              controller: _scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  state.model.length + (isLoading ? 1 : 0),
                              itemBuilder: (BuildContext context, int index) {
                                if (index < state.model.length) {
                                  return Card(
                                    child: TransaksiItemWidget(
                                      transaksi: state.model[index],
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            );
                    }
                  }
                },
              ),
            ),
            onRefresh: () => _refreshData('cancel'),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const TransaksiAddPage(),
      //       ),
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
