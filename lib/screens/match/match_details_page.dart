import 'package:flutter/material.dart';
import 'package:my_flutter_app/screens/match/tabs/details_tab.dart';

import 'package:my_flutter_app/screens/match/tabs/lineups_tab.dart';
import 'package:my_flutter_app/screens/match/tabs/stats_tab.dart';
import 'package:my_flutter_app/screens/match/tabs/overview_tab.dart';

class MatchDetailsPage extends StatelessWidget {
  final String matchTitle;
  final String matchSubtitle;

  const MatchDetailsPage({
    super.key,
    required this.matchTitle,
    required this.matchSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Match Details - $matchTitle"),
          backgroundColor: Colors.black,
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Details"),
              Tab(text: "Lineups"),
              Tab(text: "Stats"),
              Tab(text: "Overview"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DetailsTab(),
            LineupsTab(),
            StatsTab(),
            OverviewTab(),
          ],
        ),
      ),
    );
  }
}
