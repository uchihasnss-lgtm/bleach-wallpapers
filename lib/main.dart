import 'package:flutter/material.dart';

void main() {
  runApp(const BleachWallpapersApp());
}

class BleachWallpapersApp extends StatelessWidget {
  const BleachWallpapersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bleach Wallpapers',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF1738),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final categories = const [
    ('Ichigo', Icons.flash_on),
    ('Bankai', Icons.whatshot),
    ('Aizen', Icons.visibility),
    ('Rukia', Icons.ac_unit),
    ('Urahara', Icons.auto_awesome),
    ('Captains', Icons.shield),
    ('Espada', Icons.dangerous),
    ('Yhwach', Icons.dark_mode),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _home(),
      _simplePage('Categories'),
      _simplePage('Favorites'),
      _simplePage('Settings'),
    ];

    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF090909),
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _home() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu, size: 28),
              const Spacer(),
              const Text(
                'BLEACH',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1.2),
              ),
              const Text(
                ' WALLPAPERS',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFFF1738)),
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          const SizedBox(height: 18),
          _featuredCard(),
          const SizedBox(height: 24),
          _sectionTitle('Categories'),
          const SizedBox(height: 12),
          SizedBox(
            height: 102,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) => _categoryCard(categories[i].$1, categories[i].$2),
            ),
          ),
          const SizedBox(height: 26),
          _sectionTitle('Latest Wallpapers'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .63,
            ),
            itemBuilder: (_, i) => _wallpaperCard(i),
          ),
        ],
      ),
    );
  }

  Widget _featuredCard() {
    return Container(
      height: 205,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4B0710), Color(0xFF111111), Color(0xFF030303)],
        ),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      padding: const EdgeInsets.all(18),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: 0,
            bottom: 0,
            child: Icon(Icons.flash_on, size: 180, color: Colors.red.withValues(alpha: .15)),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('FEATURED', style: TextStyle(color: Color(0xFFFF1738), fontWeight: FontWeight.bold)),
              SizedBox(height: 7),
              Text('Ichigo Kurosaki', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              Text('Bankai • Tensa Zangetsu', style: TextStyle(color: Colors.white70)),
              SizedBox(height: 12),
              Text('Wallpaper preview', style: TextStyle(fontSize: 12, color: Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const Spacer(),
          const Text('See All', style: TextStyle(color: Colors.white54)),
        ],
      );

  Widget _categoryCard(String name, IconData icon) {
    return Container(
      width: 82,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF292929)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFFF3048), size: 30),
          const SizedBox(height: 7),
          Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _wallpaperCard(int i) {
    final names = ['Ichigo', 'Bankai', 'Aizen', 'Rukia', 'Urahara', 'Yhwach'];
    final icons = [Icons.flash_on, Icons.whatshot, Icons.visibility, Icons.ac_unit, Icons.auto_awesome, Icons.dark_mode];
    return GestureDetector(
      onTap: () => _showPreview(names[i]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: i.isEven
                ? const [Color(0xFF4A0710), Color(0xFF0D0D0D)]
                : const [Color(0xFF071C3A), Color(0xFF0D0D0D)],
          ),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icons[i], size: 52, color: i.isEven ? const Color(0xFFFF3048) : const Color(0xFF5C9DFF)),
            const SizedBox(height: 10),
            Text(names[i], style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 3),
            const Text('4K • HD', style: TextStyle(fontSize: 10, color: Colors.white54)),
          ],
        ),
      ),
    );
  }

  Widget _simplePage(String title) {
    return Center(
      child: Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
    );
  }

  void _showPreview(String name) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101010),
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.image, size: 70, color: Color(0xFFFF1738)),
            const SizedBox(height: 12),
            Text('$name Wallpaper', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('This is the starter preview. Real licensed/original wallpaper images can be added next.'),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text('Download'))),
                const SizedBox(width: 10),
                Expanded(child: FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.wallpaper), label: const Text('Set Wallpaper'))),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
