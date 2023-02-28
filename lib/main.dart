import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_example/vision_detector_views/pose_detector_view_A.dart';
import 'vision_detector_views/face_detector_view.dart';
import 'vision_detector_views/pose_detector_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
                  ExpansionTile(
                    title: const Text('APIs'),
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(350,50),
                          padding: EdgeInsets.all(10.0),
                          textStyle: const TextStyle(fontSize: 30)
                        ),
                        child: Text("Pose Detection_A"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new PoseDetectorView_A()),
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