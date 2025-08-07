import 'package:flutter/material.dart';
import 'package:social_media_app/models/postModel.dart';
import 'package:social_media_app/util/timeVN.dart';
import 'package:social_media_app/views/home/widget/expanded_text.dart';
import 'package:social_media_app/views/home/widget/videourl_preview.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: avatar + username + time
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                    post.createdBy?.username ??
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqekwL2LW2-NBO_FE2f2IjZQnp_1xl-shGcg&s",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${post.createdBy?.username ?? "Unknown"}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        getComparedTime(post.createdAt.toString()),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.grey[600]),
              ],
            ),

            const SizedBox(height: 16),
            // Nội dung văn bản
            ExpandedText(
              text: post.content.toString(),
              postId: post.sId.toString(),
            ),

            // Hình ảnh / video nếu có
            if (post.images?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              _buildImageGallery(post.images!),
            ],

            const SizedBox(height: 12),
            Divider(color: Colors.grey[300]),

            // Action buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery(List<String> urls) {
    if (urls.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _buildMediaWidget(urls[0]),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: urls.length > 4 ? 4 : urls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        final showMoreOverlay = index == 3 && urls.length > 4;
        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _buildMediaWidget(urls[index]),
            ),
            if (showMoreOverlay)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+${urls.length - 4}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMediaWidget(String url) {
    if (url.endsWith('.mp4') || url.endsWith('.avi') || url.endsWith('.mov')) {
      return MediaWidget(url: url);
    } else {
      return Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    }
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionBtn(
          icon: Icons.favorite_border,
          label: 'Like',
          color: Colors.red,
        ),
        _actionBtn(
          icon: Icons.chat_bubble_outline,
          label: 'Comment',
          color: Colors.grey[700],
        ),
        _actionBtn(
          icon: Icons.share_outlined,
          label: 'Share',
          color: Colors.grey[700],
        ),
        _actionBtn(
          icon: Icons.bookmark_border,
          label: 'Save',
          color: Colors.grey[700],
        ),
      ],
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required Color? color,
  }) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
