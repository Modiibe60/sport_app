import 'package:flutter/material.dart';

class TeamNewPage extends StatefulWidget {
  const TeamNewPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TeamNewPageState createState() => _TeamNewPageState();
}

class _TeamNewPageState extends State<TeamNewPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Team",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle team addition
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.redAccent,
          tabs: [
            Tab(text: "Teams"),
            Tab(text: "Team Making"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTeamsTab(),
          _buildTeamMakingTab(),
          _buildMembersTab(),
        ],
      ),
    );
  }

  Widget _buildTeamsTab() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: List.generate(5, (index) {
        return Card(
          color: Colors.grey[900],
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/team_avatar.png'), // Replace with your asset
            ),
            title: Text(
              'Team ${index + 1}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Rank ${index + 1}',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.chat, color: Colors.white),
                  onPressed: () {
                    // Handle chat action
                  },
                ),
                IconButton(
                  icon: Icon(Icons.info, color: Colors.white),
                  onPressed: () {
                    // Handle team info
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTeamMakingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Handle image change
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/team_avatar.png'), // Replace with your asset
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.camera_alt, color: Colors.redAccent),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter the team name",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixIcon: ElevatedButton(
                onPressed: () {
                  // Handle verification
                },
                child: Text("Verify"),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Write a brief about the team...",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle team creation
            },
            child: Text("Create Team"),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[900],
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/member_avatar.png'), // Replace with your asset
            ),
            title: Text(
              'Member ${index + 1}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              index % 2 == 0 ? "Now" : "Last login: 2 hours ago",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Handle member details
            },
          ),
        );
      },
    );
  }
}
