import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:talkr_demo/service/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:talkr_demo/widgets/progress.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          "Post",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Lato",
            // fontStyle: FontStyle.italic,
            fontSize: 20.0,
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                ),
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg', 'mp4', 'mp3'],
                  );
                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No file selected"),
                      ),
                    );
                    return null;
                  }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;

                  storage
                      .uploadFile(path, fileName)
                      .then((value) => print("Done"));
                },
                child: Text(
                  "Upload Somthing",
                  style: TextStyle(
                      color: Colors.white, backgroundColor: Colors.white),
                ),
              ),
            ),
            // FutureBuilder(
            //     future: storage.listFiles(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<firebase_storage.ListResult> snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done &&
            //           snapshot.hasData) {
            //         return Container(
            //           padding: const EdgeInsets.symmetric(horizontal: 20),
            //           height: 50,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             shrinkWrap: true,
            //             itemCount: snapshot.data!.items.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: ElevatedButton(
            //                   onPressed: () {},
            //                   child: Text(snapshot.data!.items[index].name),
            //                 ),
            //               );
            //             },
            //           ),
            //         );
            //       }
            //       if (snapshot.connectionState == ConnectionState.waiting ||
            //           !snapshot.hasData) {
            //         return CircularProgressIndicator();
            //       }
            //       return Container();
            //     }),
          ],
        ),
      ),
    );
  }
}
