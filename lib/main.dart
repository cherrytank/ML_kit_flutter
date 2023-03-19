import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'vision_detector_views/detector_views.dart';

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
                        child: Text("shrug_left"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new shrug_left()),
                          );
                        },
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(350,50),
                            padding: EdgeInsets.all(10.0),
                            textStyle: const TextStyle(fontSize: 30)
                        ),
                        child: Text("shrug_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new shrug_right()),
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