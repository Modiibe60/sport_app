// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// // Import your other pages
// import 'games_page.dart';
// import 'analytics_page.dart';
// import 'main_bottom/main_navigation_page.dart';
// import 'my_profile.dart';
// import 'live_page.dart';

// // Import the create_live and create_video pages
// import 'create_live_or_video/create_live.dart';
// import 'create_live_or_video/create_video.dart';

// // Import the menu pages
// import 'menu/friends.dart';
// import 'menu/message_chat.dart';
// import 'menu/notific_page.dart';
// import 'menu/search_page.dart';
// import 'menu/team_new_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late VideoPlayerController _controller;
//   int _selectedTabIndex = 0;
//   bool _isLiked = false;
//   int _likeCount = 233800; // Starting likes count
//   bool _isMenuOpen = false; // Menu visibility state

//   // ignore: unused_field
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();

//     // Check if file exists before initializing
//     String videoPath = 'assets/videos/boys.mp4';
//     File videoFile = File(videoPath);

//     if (videoFile.existsSync()) {
//       _controller = VideoPlayerController.file(videoFile);
//     } else {
//       // Fallback to an asset-based video
//       _controller = VideoPlayerController.asset('assets/videos/boys.mp4');
//     }

//     _controller
//       ..initialize().then((_) {
//         setState(() {});
//       })
//       ..setLooping(true)
//       ..play();
//   }

//   @override
//   void dispose() {
//     _controller.pause(); // Ensure the video stops when leaving the page
//     _controller.dispose();
//     super.dispose();
//   }

//   // Navigation for Bottom Tabs
//   void _onTabSelected(int index) {
//     if (index == _selectedTabIndex) return;

//     // Pause the video before navigating
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//     }

//     setState(() {
//       _selectedTabIndex = index;
//     });

//     switch (index) {
//       case 0:
//         break;
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const GamesPage()),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MainNavigationPage()),
//         );
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const AnalyticsPage()),
//         );
//         break;
//       case 4:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const MyProfilePage()),
//         );
//         break;
//     }
//   }

//   // Toggle Like Button
//   void _toggleLike() {
//     setState(() {
//       _isLiked = !_isLiked;
//       _likeCount += _isLiked ? 1 : -1; // Increment/Decrement the like count
//     });
//   }

// // Function to show Create Dialog (Choose between Live & Video)
//   void _showCreateDialog(
//       BuildContext context, List<CameraDescription> cameras) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Create New'),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           content: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // ?? Navigate to Video Creation Page
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.video_library, color: Colors.white),
//                   label: const Text('Record Video'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context); // Close the dialog
//                     if (cameras.isNotEmpty) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               CreateVideoPage(camera: cameras[0]),
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('No available cameras!')),
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 12),

//                 // ?? Navigate to Live Streaming Page
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.live_tv, color: Colors.white),
//                   label: const Text('Go Live'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent,
//                     minimumSize: const Size(double.infinity, 50),
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context); // Close the dialog

//                     if (cameras.isNotEmpty) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               CreateLivePage(camera: cameras[0]),
//                         ),
//                       );
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('No available cameras!')),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

// // Toggle Menu
//   void _toggleMenu() {
//     setState(() {
//       _isMenuOpen = !_isMenuOpen;
//     });
//   }

//  @override
// Widget build(BuildContext context) {
//   return WillPopScope(
//     onWillPop: () async {
//       if (_selectedTabIndex != 0) {
//         // If not on home page, go back to home instead of exiting
//         setState(() {
//           _selectedTabIndex = 0;
//         });
//         return false; // Prevents exiting the app
//       }
//       return true; // Allows exit if already on home
//     },
//     child: Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.create, color: Colors.white),
//                   onPressed: () async {
//                     // Fetch available cameras
//                     List<CameraDescription> cameras = await availableCameras();
//                     _showCreateDialog(context, cameras);
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.menu, color: Colors.white),
//                   onPressed: _toggleMenu,
//                 ),
//               ],
//             ),
//           ),
//         ],
//         leading: IconButton(
//           icon: const Icon(Icons.live_tv, color: Colors.blue),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const LivePage()),
//             );
//           },
//         ),
//       ),
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           Center(
//             child: _controller.value.isInitialized
//                 ? _buildVideoPlayer()
//                 : const Center(child: CircularProgressIndicator()),
//           ),
//           _buildActionButtons(),
//           if (_isMenuOpen) _buildMenuPositioned(),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         selectedTabIndex: _selectedTabIndex,
//         onTabSelected: _onTabSelected,
//       ),
//     ),
//   );
// }

// // ?? Build Video Player UI
//   Widget _buildVideoPlayer() {
//     return SizedBox.expand(
//       child: FittedBox(
//         fit: BoxFit.cover,
//         child: SizedBox(
//           width: _controller.value.size.width,
//           height: _controller.value.size.height,
//           child: VideoPlayer(_controller),
//         ),
//       ),
//     );
//   }

// // ?? Floating Action Buttons for Likes, Comments, and Downloads
//   Widget _buildActionButtons() {
//     return Positioned(
//       right: 16,
//       top: 200,
//       child: Column(
//         children: [
//           _buildActionButton(
//             Icons.favorite,
//             _likeCount.toString(),
//             _toggleLike,
//             isSelected: _isLiked,
//           ),
//           const SizedBox(height: 16),
//           _buildActionButton(Icons.comment, '45.4K', _showCommentDialog),
//           const SizedBox(height: 16),
//           _buildActionButton(Icons.download_sharp, '19K', () {}),
//         ],
//       ),
//     );
//   }

// // ??? Floating Menu
//   Widget _buildMenuPositioned() {
//     return Positioned(
//       right: 16,
//       top: 60,
//       child: _buildMenu(),
//     );
//   }

// // ?? Helper for Action Buttons
//   Widget _buildActionButton(
//     IconData icon,
//     String label,
//     VoidCallback onPressed, {
//     bool isSelected = false,
//   }) {
//     return Column(
//       children: [
//         IconButton(
//           icon: Icon(icon, color: isSelected ? Colors.red : Colors.white),
//           onPressed: onPressed,
//         ),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white, fontSize: 12),
//         ),
//       ],
//     );
//   }

//   Widget _buildMenu() {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildMenuItem(Icons.message, 'Message', const DirectMessagesPage()),
//           _buildMenuItem(
//               Icons.notifications, 'Notifications', const NotificationPage()),
//           _buildMenuItem(Icons.search, 'Search', const SearchPage()),
//           _buildMenuItem(Icons.group, 'Friends', const FriendsPage()),
//           _buildMenuItem(Icons.flag_sharp, 'Team', const TeamNewPage()),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem(IconData icon, String label, Widget targetPage) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => targetPage),
//           );
//         },
//         child: Row(
//           children: [
//             Icon(icon, color: Colors.white),
//             const SizedBox(width: 8.0),
//             Text(
//               label,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Show Comment Dialog to enable comment feature
//   void _showCommentDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Write a Comment'),
//           content: TextField(
//             decoration: const InputDecoration(hintText: 'Enter your comment'),
//             autofocus: true,
//           ),
//           actions: [
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: const Text('Post'),
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Comment Posted')),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class CustomBottomNavigationBar extends StatelessWidget {
//   final int selectedTabIndex;
//   final Function(int) onTabSelected;

//   const CustomBottomNavigationBar({
//     super.key,
//     required this.selectedTabIndex,
//     required this.onTabSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildNavIcon(Icons.video_library, 0, selectedTabIndex == 0),
//             _buildNavIcon(Icons.videogame_asset, 1, selectedTabIndex == 1),
//             _buildNavIcon(Icons.dashboard, 2, selectedTabIndex == 2,
//                 isSpecial: true),
//             _buildNavIcon(Icons.pie_chart, 3, selectedTabIndex == 3),
//             _buildNavIcon(Icons.person, 4, selectedTabIndex == 4),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavIcon(IconData icon, int index, bool isSelected,
//       {bool isSpecial = false}) {
//     return Container(
//       height: isSpecial ? 60 : 50,
//       width: isSpecial ? 60 : 50,
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.blue : Colors.transparent,
//         shape: BoxShape.circle,
//         border: isSpecial
//             ? Border.all(color: Colors.black, width: 4)
//             : Border.all(color: Colors.transparent),
//       ),
//       child: IconButton(
//         icon: Icon(icon, color: Colors.white),
//         onPressed: () => onTabSelected(index),
//       ),
//     );
//   }
// }
