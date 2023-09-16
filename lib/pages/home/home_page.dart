import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/dompet/dompet_bloc.dart';
import 'package:flutter_dompet/pages/dompet/dompet_page.dart';
import 'package:flutter_dompet/pages/home/widgets/dompet_item_widget.dart';

import '../../utils/color_resources.dart';
import '../../utils/custom_themes.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../base_widgets/title_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(bool reload) async {
    context.read<DompetBloc>().add(const DompetEvent.getAll(limit: 3));
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    context.read<DompetBloc>().add(const DompetEvent.getAll(limit: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).highlightColor,
                title: Image.asset(Images.logoPjg, height: 35),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Stack(clipBehavior: Clip.none, children: [
                        Image.asset(
                          Images.cartArrowDownImage,
                          height: Dimensions.iconSizeDefault,
                          width: Dimensions.iconSizeDefault,
                          color: ColorResources.getPrimary(context),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: CircleAvatar(
                            radius: 7,
                            backgroundColor: ColorResources.red,
                            child: Text(
                              '10',
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeExtraSmall,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Dimensions.homePagePadding,
                      Dimensions.paddingSizeSmall,
                      Dimensions.paddingSizeDefault,
                      Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      // const BannerWidget(),
                      const SizedBox(height: Dimensions.homePagePadding),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeExtraExtraSmall,
                            vertical: Dimensions.paddingSizeExtraSmall),
                        child: TitleRow(
                          title: 'Dompets',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DompetListPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: Dimensions.homePagePadding),
                    ],
                  ),
                ),
              ),
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
                    // refreshed: () {
                    //   _loadData(true);

                    //   return const SliverPadding(
                    //     padding: EdgeInsets.symmetric(horizontal: 16),
                    //     sliver: SliverToBoxAdapter(
                    //       child: Center(
                    //         child: CircularProgressIndicator(),
                    //       ),
                    //     ),
                    //   );
                    // },
                    loaded: (model) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                          child: SizedBox(
                            height:
                                100, // Sesuaikan tinggi card sesuai kebutuhan Anda
                            child: ListView.builder(
                              scrollDirection:
                                  Axis.horizontal, // Atur scroll ke horizontal
                              itemCount: model.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  width:
                                      250, // Sesuaikan lebar card sesuai kebutuhan Anda
                                  child: Card(
                                    child: DompetItemWidget(
                                      dompet: model.data![index],
                                    ),
                                  ),
                                );
                              },
                            ),
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
