import 'package:blogapp/src/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  final List<BlogModel> blogs = <BlogModel>[].obs;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  
  Future<void> addBlog(BlogModel blog) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("User is not logged in!");
      return;
    }

    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      await _store.collection("Blogs").doc(id).set({
        'id': id,
        'title': blog.title,
        'description': blog.description,
        'category': blog.category,
        'tags': blog.tags,
        'imageUrl': blog.imageUrl,
      });

      print("Blog added successfully!");
    } catch (e) {
      print("Error while adding blog: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFromFirestore();
  }

  void fetchFromFirestore() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection("Blogs").get();
      print("Total blogs found: ${querySnapshot.docs.length}");
      List<BlogModel> fetchedBlogs = querySnapshot.docs.map((doc) {
        return BlogModel.fromJson(doc.data());
      }).toList();
      blogs.assignAll(fetchedBlogs);
    } catch (e) {
      print("Error fetching blogs: $e");
    }
  }
}
