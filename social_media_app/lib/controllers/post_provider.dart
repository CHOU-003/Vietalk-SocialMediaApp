import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/models/postModel.dart';
import 'package:social_media_app/repo/post_repository.dart';

class PostProvider extends ChangeNotifier {
  PostProvider() {
    fetchAllPosts();
  }
  
  final PostRepository _postRepository = PostRepository();
  String _postText = '';
  String get postText => _postText;

  void setPostText(String text) {
    _postText = text;
    notifyListeners();
  }

  List<File> _pickImages = [];
  List<File> get pickImages => _pickImages;

  void addImage(File image) {
    _pickImages.add(image);
    notifyListeners();
  }

  void removeImage(File image) {
    _pickImages.remove(image);
    notifyListeners();
  }

  void clearImage() {
    _pickImages.clear();
    notifyListeners();
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
      allowMultiple: true,
    );
    if (result != null) {
      _pickImages =
          result.files
              .where((file) => file.path != null)
              .map((file) => File(file.path!))
              .toList();
      notifyListeners();
    }
  }

  final cloudinary = CloudinaryPublic("dzcvsyspi", "wllqjp7n");
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> savePost() async {
    _isLoading = true;
    notifyListeners();

    List<String> imageUrl = [];
    try {
      List<CloudinaryResponse> imageResponses = await cloudinary.uploadFiles(
        _pickImages
            .map(
              (imageFiles) =>
                  CloudinaryFile.fromFile(imageFiles.path, folder: 'post'),
            )
            .toList(),
      );

      for (var imageResponse in imageResponses) {
        imageUrl.add(imageResponse.secureUrl);
      }
      final response = await _postRepository.savePost(postText, imageUrl);
      _isLoading = false;
      notifyListeners();
      return response.statusCode == 201;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  List<PostModel> _posts = [];
  bool _isPostLoading = false;
  String? _errors;

  List<PostModel> get posts => _posts;
  bool get isPostLoading => _isPostLoading;
  String? get errors => _errors;

  Future<void> fetchAllPosts() async {
    _isPostLoading = true;
    _errors = null;
    notifyListeners();

    try {
      final respose = await _postRepository.getAllPost();
      if (respose.statusCode == 200) {
        final List<dynamic> postJson = json.decode(respose.body)['posts'];

        _posts = postJson.map((json) => PostModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception("Failed to load post.");
      }
    } catch (e) {
      _errors = e.toString();
      _posts = [];
      _isPostLoading = false;
      notifyListeners();
    } finally {
      _isPostLoading = false;
      notifyListeners();
    }
  }
}
