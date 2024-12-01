class ImageHelper {
  static String getImagePath(String basePath, int? index) {
    // 게시물 이미지인 경우 (index가 있는 경우)
    if (index != null) {
      return '$basePath/post${index + 1}.png'; // 우선 png로 시도
    }

    // 단일 이미지인 경우 (프로필 이미지 등)
    return '$basePath.png'; // 우선 png로 시도
  }
}
