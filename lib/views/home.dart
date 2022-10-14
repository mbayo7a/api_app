import 'package:api_app/Services/remote_service.dart';
import 'package:api_app/models/post.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post>? posts;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    //fetch data from api
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 3, 112, 59),
          title: const Text(
            'Posts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[350]),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            posts![index].title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            posts![index].body ?? '',
                          ),
                        ],
                      )),
                    ],
                  ),
                );
              }),
            )));
  }
}
