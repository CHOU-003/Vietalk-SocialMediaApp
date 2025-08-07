import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/post_provider.dart';
import 'package:social_media_app/models/postModel.dart';
// import 'package:social_media_app/util/timeVN.dart';
import 'package:social_media_app/views/home/widget/feed_item.dart';
import 'package:social_media_app/views/home/widget/stories.dart';

// ignore: must_be_immutable
class HomeFeedScreen extends StatelessWidget {
  HomeFeedScreen({super.key});
  // Sample list of images
  List<String> profileImages = [
    'https://nld.mediacdn.vn/zoom/520_520/291774122806476800/2024/12/3/atsh-rhyder-tiet-muc-anh-biet-1432-3443-1725150956-17332171351591581723181-0-0-575-920-crop-17332172396811033045071.jpg', // Quang Anh Rhyder
    'https://yt3.googleusercontent.com/c-Z7mIlntSpG6VyQ5ZqaPggqkZRhaySr-H5ZEazFN2iR1pP4eD1UGekwu0y--c4CSVhJJ1A4QT8=s900-c-k-c0x00ffffff-no-rj', // Sơn Tùng MTP
    'https://kenh14cdn.com/203336854389633024/2021/9/28/photo-1-16327924714391747144525.jpg', // Chipu
    'https://lh7-rt.googleusercontent.com/docsz/AD_4nXfZMIPirb2yeBihl98_YOeh64cU2mov_xlmLwbo8WiCh8ps7W1mI1eN82zTSNG1ddlunZUcc32WQ5kVHe6TYiD7jcktatUPHE_Z-yijXJHJeXN8oLpBkmUi-YQVRpH2bHLLxy0GJQ?key=M-4bFVUbXhCC9w3WA9uxd-zW', // MONO
    'https://lh7-rt.googleusercontent.com/docsz/AD_4nXfs0q7Ga9gQNPBXP7GD80EP-JZtjZnrpqsVzK7YLlXOuHlcvjuTDM1Nt248TFOUbKSZS3--DZWQRRnWcTpzsM6B-Rcwi4SgkCG-fEe83WFjZj4RRIcdfqxWMkQqdf1zV_9r0xvw?key=yR0l_mCv-KVWym13ilh8Pb9l', // Quang Hùng MasterD
  ];

  List<String> statusImages = [
    'https://toquoc.mediacdn.vn/280518851207290880/2023/6/30/35303983515425468262735321947006534092504900n-1688086774366726250564.jpeg',
    'https://cdn-www.vinid.net/613774c6-lieu-nhac-cua-son-tung-m-tp-con-gay-suc-hut-voi-khan-gia.jpg',
    'https://cdn.tcdulichtphcm.vn/upload/3-2023/images/2023-07-17/1689567856-chipu-ty-ty-dap-gio-re-song-4-2-1.jpg',
    'https://thoidai.com.vn/stores/news_dataimages/2024/092024/08/14/vie-channel-atsh-tiet-muc-troi-em-lai-quang-hung-masterd-120240908145815.jpg?rt=20240908145819',
    'https://media-cdn-v2.laodong.vn/storage/newsportal/2024/12/27/1441523/Duong-Domic.jpg',
    'https://img.chelseafc.com/image/upload/f_auto,w_1440,c_fill,g_faces,q_90/restricted/2025/Estevao%20Willian/Estevao_arrival_pictures_2.jpg',
    'https://bloganchoi.com/wp-content/uploads/2024/07/hao-quang-lyrics-anh-trai-say-hi-2-696x523.jpg',
    // Add more status image URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(statusImages.length + 1, (index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: FirstImageWithCircleOverlay(),
                        );
                      } else {
                        int adjustedIndex = index - 1;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stories(
                            profileImage:
                                profileImages[adjustedIndex %
                                            profileImages.length]
                                        .isEmpty
                                    ? null
                                    : profileImages[adjustedIndex %
                                        profileImages.length],
                            statusImage:
                                statusImages[adjustedIndex %
                                    statusImages.length],
                          ),
                        );
                      }
                    }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Consumer<PostProvider>(
                  builder: (context, postProvider, _) {
                    List<PostModel> posts = postProvider.posts;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        PostModel post = posts[index];
                        return FeedItem(post: post);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
