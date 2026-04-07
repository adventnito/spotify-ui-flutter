import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// root app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify UI',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

// halaman utama
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              buildRecentGrid(),

              const SizedBox(height: 20),

              buildSection(title: "Good evening", data: goodEveningItems),

              const SizedBox(height: 20),

              buildSection(
                title: "Your top mixes",
                data: topMixItems,
                big: true,
              ),

              const SizedBox(height: 20),

              buildSection(
                title: "Recently played",
                data: recentItems,
                big: true,
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNav(),
    );
  }

  // ================= HEADER =================
  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Good evening",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              headerIcon(Icons.notifications),
              const SizedBox(width: 8),
              headerIcon(Icons.history),
              const SizedBox(width: 8),
              headerIcon(Icons.settings),
            ],
          ),
        ],
      ),
    );
  }

  // icon kecil atas
  Widget headerIcon(IconData icon) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, size: 18),
    );
  }

  // ================= GRID ATAS =================
  Widget buildRecentGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 4,
        ),
        itemCount: recentShortcuts.length,
        itemBuilder: (context, i) {
          return buildRecentItem(recentShortcuts[i]);
        },
      ),
    );
  }

  Widget buildRecentItem(Map item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF282828),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            color: item["color"],
            child: Icon(item["icon"], color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item["name"],
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION =================
  Widget buildSection({
    required String title,
    required List<Map<String, dynamic>> data,
    bool big = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "See all",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(
          height: big ? 200 : 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: data.length,
            itemBuilder: (context, i) {
              return big ? buildBigCard(data[i]) : buildSmallCard(data[i]);
            },
          ),
        ),
      ],
    );
  }

  // card besar
  Widget buildBigCard(Map item) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: item["color"],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Icon(item["icon"], size: 40)),
          ),
          const SizedBox(height: 8),
          Text(item["name"], style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // card kecil
  Widget buildSmallCard(Map item) {
    return Container(
      width: 60,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: item["color"],
              shape: BoxShape.circle,
            ),
            child: Icon(item["icon"]),
          ),
          const SizedBox(height: 6),
          Text(
            item["name"],
            style: const TextStyle(fontSize: 11, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM NAV =================
  Widget buildBottomNav() {
    return Container(
      height: 70,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.library_music),
          Icon(Icons.star),
        ],
      ),
    );
  }
}

// ================= DATA =================

final List<Map> recentShortcuts = [
  {"name": "Liked Songs", "color": Colors.purple, "icon": Icons.favorite},
  {"name": "Daily Mix 1", "color": Colors.green, "icon": Icons.music_note},
  {"name": "Top Charts", "color": Colors.red, "icon": Icons.trending_up},
  {"name": "Chill Vibes", "color": Colors.blue, "icon": Icons.waves},
];

final List<Map<String, dynamic>> goodEveningItems = [
  {"name": "Chill", "color": Colors.blue, "icon": Icons.nightlight},
  {"name": "Focus", "color": Colors.green, "icon": Icons.flash_on},
  {"name": "Sleep", "color": Colors.purple, "icon": Icons.bed},
  {"name": "Jazz", "color": Colors.orange, "icon": Icons.music_video},
];

final List<Map<String, dynamic>> topMixItems = [
  {"name": "Daily Mix 1", "color": Colors.blue, "icon": Icons.music_note},
  {"name": "Daily Mix 2", "color": Colors.pink, "icon": Icons.music_note},
  {"name": "Daily Mix 3", "color": Colors.orange, "icon": Icons.graphic_eq},
];

final List<Map<String, dynamic>> recentItems = [
  {"name": "RnB Mix", "color": Colors.blueGrey, "icon": Icons.radio},
  {"name": "Liked Songs", "color": Colors.purple, "icon": Icons.favorite},
  {"name": "Top 50", "color": Colors.green, "icon": Icons.public},
];
