import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapi_retrofit/controllers/post_controller.dart';
import 'package:restapi_retrofit/models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PostController _postController;
  @override
  void initState() {
    _postController = Provider.of<PostController>(context, listen: false);
    _postController.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("API Call With Retrofit"),
      ),
      body: Consumer<PostController>(
        builder: (context, postController, _) {
          if (postController.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                itemCount: postController.posts.length,
                itemBuilder: (context, index) {
                  final PostModel post = postController.posts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          post.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          post.body,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
