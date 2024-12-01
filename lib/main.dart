import 'package:flutter/material.dart';
import 'screens/post_detail_screen.dart';
import 'utils/image_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cookie Monster',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Icon(Icons.more_horiz, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      ImageHelper.getImagePath(
                          'assets/images/profile/profile', null),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // png 로드 실패시 jpg 시도
                        return Image.asset(
                          'assets/images/profile/profile.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error); // 모두 실패시 에러 아이콘
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('42', 'posts'),
                      _buildStatColumn('286', 'followers'),
                      _buildStatColumn('312', 'following'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cookie Monster',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Gimmie ALL UR Cookies !!',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'www.cookie-rule-the-world.co.kr',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: const Icon(Icons.grid_on),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child:
                      Icon(Icons.person_pin_outlined, color: Colors.grey[400]),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                          postIndex: index,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Image.asset(
                      ImageHelper.getImagePath('assets/images/posts', index),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/posts/post${index + 1}.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
