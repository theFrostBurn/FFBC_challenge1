import 'package:flutter/material.dart';
import '../utils/image_helper.dart';
import '../widgets/common_bottom_navigation.dart';

class PostDetailScreen extends StatefulWidget {
  final int postIndex;

  const PostDetailScreen({
    super.key,
    required this.postIndex,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool isLiked = false;
  bool isBookmarked = false;
  late int likesCount;

  @override
  void initState() {
    super.initState();
    likesCount = _getInitialLikesCount(widget.postIndex);
  }

  int _getInitialLikesCount(int index) {
    final likes = [1234, 986, 2567, 432, 7654, 891, 3210, 567, 4321];
    return likes[index];
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likesCount += isLiked ? 1 : -1;
    });
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    '${ImageHelper.getImagePath('assets/images/profile/profile', null)}.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        '${ImageHelper.getImagePath('assets/images/profile/profile', null)}.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const Text(
              'Cookie Monster',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.more_horiz, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60),
            ),
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Image.asset(
                  '${ImageHelper.getImagePath('assets/images/posts', widget.postIndex)}.jpg',
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      '${ImageHelper.getImagePath('assets/images/posts', widget.postIndex)}.png',
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: toggleLike,
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.black,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.chat_bubble_outline,
                            size: 30,
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.send,
                            size: 30,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: toggleBookmark,
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$likesCount likes',
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
                          text: _getPostCaption(widget.postIndex),
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
      bottomNavigationBar: CommonBottomNavigation(
        onLikePressed: toggleLike,
      ),
    );
  }

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
}
