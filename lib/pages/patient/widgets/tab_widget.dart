import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:medpad/constants/style.dart';

class TabBarWidget extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> childs;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const TabBarWidget({Key key, this.tabs, this.childs, this.tabBarIndicatorSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TabBar _tabBar = new TabBar(
        automaticIndicatorColorAdjustment: true,
        indicatorColor: primaryColor,
        unselectedLabelColor: secondaryColor,
        labelColor: primaryColor,
        indicatorWeight: 2.0,
        indicatorSize: tabBarIndicatorSize==null ? TabBarIndicatorSize.tab : tabBarIndicatorSize,
        labelPadding: EdgeInsets.symmetric(horizontal: 10),
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
        isScrollable: true,
        physics: BouncingScrollPhysics(),
        overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(.4)),
        tabs: tabs);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: childs.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(_tabBar.preferredSize.height - 44),
                child: Align(alignment: Alignment.topLeft, child: _tabBar)),
          ),
          body: TabBarView(
              children: childs
          ),
        ),
      ),
    );
  }
}
