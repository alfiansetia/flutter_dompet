import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/dompet/dompet_bloc.dart';
import 'package:flutter_dompet/pages/home/widgets/dompet_item_widget.dart';
import 'package:flutter_dompet/utils/color_resources.dart';

class DompetListPage extends StatefulWidget {
  const DompetListPage({super.key});

  @override
  State<DompetListPage> createState() => _DompetListPageState();
}

class _DompetListPageState extends State<DompetListPage> {
  Future<void> _refreshData() async {
    context.read<DompetBloc>().add(const FetchAllDompetEvent());
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dompet'),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      // resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        child: SafeArea(
          child: BlocBuilder<DompetBloc, DompetState>(
            builder: (context, state) {
              if (state.status == DompetStatus.error) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.error.message),
                      ElevatedButton(
                        onPressed: _refreshData,
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                );
              } else if (state.status == DompetStatus.loaded) {
                return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.model.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: DompetItemWidget(
                        dompet: state.model[index],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        onRefresh: () => _refreshData(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
