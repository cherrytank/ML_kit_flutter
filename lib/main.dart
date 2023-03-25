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
      body: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
                  ListView(
                    children: [
                      SizedBox(height: 10,),
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
                      SizedBox(height: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(350,50),
                            padding: EdgeInsets.all(10.0),
                            textStyle: const TextStyle(fontSize: 30)
                        ),
                        child: Text("crutch_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new crutch_right()),
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
                        child: Text("hold_hands_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new hold_hands_right()),
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
                        child: Text("wipe_table_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new wipe_table_right()),
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
                        child: Text("bath_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new bath_right()),
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
                        child: Text("forward_shoulder_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new forward_shoulder_right()),
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
                        child: Text("forward_elbow_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new forward_elbow_right()),
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
                        child: Text("shoulder_raise_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new shoulder_raise_right()),
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
                        child: Text("heads_raise_right"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new heads_raise_right()),
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