String getComparedTime(String dateTime) {
  try {
    final DateTime time = DateTime.parse(dateTime).toLocal();
    final Duration diff = DateTime.now().difference(time);

    if (diff.inSeconds < 60) {
      return 'Vừa xong';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} phút trước';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} giờ trước';
    } else if (diff.inDays == 1) {
      return 'Hôm qua';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ngày trước';
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks tuần trước';
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return '$months tháng trước';
    } else {
      final years = (diff.inDays / 365).floor();
      return '$years năm trước';
    }
  } catch (e) {
    return 'Không rõ thời gian';
  }
}
