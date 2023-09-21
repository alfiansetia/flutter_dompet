import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/dompet/dompet_bloc.dart';
import 'package:flutter_dompet/bloc/navigation/navigation_bloc.dart';
import 'package:flutter_dompet/pages/home/widgets/banner_widget.dart';
import 'package:flutter_dompet/pages/home/widgets/dompet_item_widget.dart';

import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../base_widgets/title_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadData(bool reload) async {
    context.read<DompetBloc>().add(const FetchAllDompetEvent());
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
        title: Text('Home'),
      ),
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.homePagePadding,
                      Dimensions.paddingSizeSmall,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      const SizedBox(height: Dimensions.homePagePadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: TitleRow(
                          title: 'Dompets',
                          onTap: () {
                            context
                                .read<NavigationBloc>()
                                .add(NavigationSetEvent(index: 2));
                          },
                        ),
                      ),
                      const SizedBox(height: Dimensions.homePagePadding),
                    ],
                  ),
                ),
                BlocBuilder<DompetBloc, DompetState>(
                  builder: (context, state) {
                    if (state.status == DompetStatus.error) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Text(state.error.message),
                        ),
                      );
                    } else if (state.status == DompetStatus.loaded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height:
                              100, // Sesuaikan tinggi card sesuai kebutuhan Anda
                          child: ListView.builder(
                            scrollDirection:
                                Axis.horizontal, // Atur scroll ke horizontal
                            itemCount: state.model.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width:
                                    250, // Sesuaikan lebar card sesuai kebutuhan Anda
                                child: Card(
                                  child: DompetItemWidget(
                                    dompet: state.model[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
                BannerWidget(),
              ],
            ),
          ),
        ),
        onRefresh: () => _loadData(true),
      ),
    );
  }
}
