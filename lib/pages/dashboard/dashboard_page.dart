import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dompet/bloc/navigation/navigation_bloc.dart';
import 'package:flutter_dompet/pages/akun/akun_page.dart';
import 'package:flutter_dompet/pages/dompet/dompet_page.dart';
import 'package:flutter_dompet/pages/home/home_page.dart';
import 'package:flutter_dompet/pages/transaksi/transaksi_page.dart';
import 'package:flutter_dompet/utils/images.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final PageController _pageController = PageController();
  List<Widget> _screens = [
    HomePage(),
    TransaksiPage(),
    const DompetListPage(),
    const AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, index) {
          return BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).textTheme.bodyLarge!.color,
            showUnselectedLabels: true,
            currentIndex: context.read<NavigationBloc>().state.index,
            type: BottomNavigationBarType.fixed,
            items: _getBottomWidget(false),
            onTap: (int index) {
              context
                  .read<NavigationBloc>()
                  .add(NavigationSetEvent(index: index));
            },
          );
        },
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                _screens[context.read<NavigationBloc>().state.index],
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _barItem(String icon, String? label, int index) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: index == context.read<NavigationBloc>().state.index
            ? Theme.of(context).primaryColor
            : Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
        height: 25,
        width: 25,
      ),
      label: label,
    );
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> list = [];
    list.add(_barItem(Images.homeImage, 'Home', 0));
    list.add(_barItem(Images.shoppingImage, 'Trx', 1));
    list.add(_barItem(Images.moreImage, 'Dompet', 2));
    list.add(_barItem(Images.wishlist, 'Akun', 3));
    return list;
  }
}
