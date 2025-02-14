import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _selectedTabIndex = 0;

  final List<String> _recentSearches = ["Liverpool", "Banha", "Zamalek"];
  final List<String> _tabs = ["All", "Matches", "Teams", "Leagues", "Players"];

  late TabController _tabController;

  final List<Map<String, String>> _allMatches = [
    {"title": "Liverpool vs Aston Villa", "score": "3 - 1", "status": "FT"},
    {"title": "Arsenal vs Chelsea", "score": "2 - 2", "status": "FT"},
    {"title": "Liverpool vs Arsenal", "score": "2 - 0", "status": "FT"},
  ];

  final List<Map<String, String>> _allTeams = [
    {"name": "Liverpool", "country": "England"},
    {"name": "Aston Villa", "country": "England"},
    {"name": "Real Madrid", "country": "Spain"},
  ];

  final List<Map<String, String>> _allLeagues = [
    {"name": "Premier League", "country": "England"},
    {"name": "La Liga", "country": "Spain"},
    {"name": "Serie A", "country": "Italy"},
  ];

  final List<Map<String, String>> _allPlayers = [
    {"name": "Mohamed Salah", "team": "Liverpool"},
    {"name": "Lionel Messi", "team": "PSG"},
    {"name": "Cristiano Ronaldo", "team": "Al-Nassr"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, String>> _filterResults(
      List<Map<String, String>> items, String query) {
    return items
        .where((item) => item.values
            .any((value) => value.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Search",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            if (_searchQuery.isEmpty) _buildRecentSearches() else _buildTabs(),
            const SizedBox(height: 16),
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: "Type to search",
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[850],
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = "";
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Searches",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _recentSearches.clear();
                });
              },
              child: const Text(
                "Clear All",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _recentSearches.map((term) {
            return Chip(
              label: Text(term, style: const TextStyle(color: Colors.white)),
              backgroundColor: Colors.grey[850],
              deleteIcon: const Icon(Icons.close, color: Colors.grey),
              onDeleted: () {
                setState(() {
                  _recentSearches.remove(term);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return TabBar(
      controller: _tabController,
      onTap: (index) {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      isScrollable: true,
      indicatorColor: Colors.blue,
      indicatorWeight: 3,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      tabs: _tabs
          .map((tab) => Tab(
                text: tab,
              ))
          .toList(),
    );
  }

  Widget _buildResults() {
    List<Map<String, String>> results;
    if (_selectedTabIndex == 1) {
      results = _filterResults(_allMatches, _searchQuery);
    } else if (_selectedTabIndex == 2) {
      results = _filterResults(_allTeams, _searchQuery);
    } else if (_selectedTabIndex == 3) {
      results = _filterResults(_allLeagues, _searchQuery);
    } else if (_selectedTabIndex == 4) {
      results = _filterResults(_allPlayers, _searchQuery);
    } else {
      results = _filterResults(
        [..._allMatches, ..._allTeams, ..._allLeagues, ..._allPlayers],
        _searchQuery,
      );
    }

    if (results.isEmpty) {
      return const Center(
        child: Text(
          "No results found.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        if (result.containsKey("score")) {
          return _buildMatchCard(result);
        } else {
          return _buildListTile(result["name"]!,
              result[result.containsKey("team") ? "team" : "country"]!);
        }
      },
    );
  }

  Widget _buildMatchCard(Map<String, String> match) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.sports_soccer, color: Colors.white),
        title: Text(
          match["title"]!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          match["status"]!,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              match["score"]!,
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.star_border, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.star, color: Colors.blue),
        title: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.star_border, color: Colors.white),
      ),
    );
  }
}
