import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/post_provider.dart';
import 'package:social_media_app/views/home/widget/image_preview.dart';
import 'package:social_media_app/views/home/widget/video_preview.dart';

class PostCreationScreen extends StatelessWidget {
  const PostCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          "Create Post",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<PostProvider>(
                builder: (context, postprovider, _) {
                  return TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: "Your putlines",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => postprovider.setPostText(value),
                  );
                },
              ),
              SizedBox(height: 16),
              Consumer<PostProvider>(
                builder: (context, postprovider, _) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      postprovider.pickImage();
                    },
                    label: Text("Pick image and Videos"),
                    icon: Icon(Icons.photo_library),
                  );
                },
              ),
              SizedBox(height: 16),
              Consumer<PostProvider>(
                builder: (context, postprovider, _) {
                  return postprovider.pickImages.isNotEmpty
                      ? Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children:
                            postprovider.pickImages.map((file) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  file.path.endsWith('.mp4')
                                      ? VideoPreview(file: file)
                                      : ImagePreview(file: file),
                                  IconButton(
                                    onPressed: () {
                                      postprovider.removeImage(file);
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      )
                      : Text("No image seclected.");
                },
              ),
              SizedBox(height: 16),
              Consumer<PostProvider>(
                builder: (context, postprovider, _) {
                  return postprovider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                        onPressed: () async {
                          bool success = await postprovider.savePost();
                          if (success) {
                            postprovider.setPostText('');
                            postprovider.clearImage();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Post Saved Successfully."),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to save Post.")),
                            );
                          }
                        },
                        child: Text('Post/Save'),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
