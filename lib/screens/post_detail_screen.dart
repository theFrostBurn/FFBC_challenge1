import 'package:flutter/material.dart';
import '../utils/image_helper.dart';
import '../widgets/common_bottom_navigation.dart';

class PostDetailScreen extends StatelessWidget {
  final int postIndex;

  const PostDetailScreen({
    super.key,
    required this.postIndex,
  });

  String _getPostCaption(int index) {
    final captions = [
      "쿠키가 너무 맛있어서 행복해 #cookie #happy",
      "오늘의 쿠키 컬렉션 #cookielover",
      "초코칩이 가득! #chocolate #cookies",
      "새로운 레시피로 만든 쿠키 #baking",
      "쿠키 먹는 중 #nomnom",
      "친구들과 쿠키 파티 #cookieparty",
      "오늘의 쿠키 구움 #freshbaked",
      "쿠키 맛집 발견! #foodie",
      "완벽한 오후 #cookies #milk",
    ];
    return captions[index];
  }

  String _getLikesCount(int index) {
    final likes = [
      "1,234",
      "986",
      "2,567",
      "432",
      "7,654",
      "891",
      "3,210",
      "567",
      "4,321",
    ];
    return likes[index];
  }

  bool _getRandomBookmarkState() {
    return DateTime.now().millisecondsSinceEpoch % 2 == 0;
  }

  @override
  Widget build(BuildContext context) {
    final bool isBookmarked = _getRandomBookmarkState();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cookie Monster',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Icon(Icons.more_horiz, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset(
              ImageHelper.getImagePath('assets/images/posts', postIndex),
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // png 로드 실패시 jpg 시도
                return Image.asset(
                  'assets/images/posts/post${postIndex + 1}.jpg',
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error); // 모두 실패시 에러 아이콘
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(right: 10),
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
                          ),
                        ),
                      ),
                      const Text(
                        'Cookie Monster',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.chat_bubble_outline),
                          SizedBox(width: 12),
                          Icon(Icons.send),
                        ],
                      ),
                      Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_getLikesCount(postIndex)} likes',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'Cookie Monster ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _getPostCaption(postIndex),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '6 minutes ago',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CommonBottomNavigation(),
    );
  }
}
