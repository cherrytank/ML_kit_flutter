import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_example/vision_detector_views/pose_transform.dart';
import 'package:google_ml_kit_example/vision_detector_views/pose_view.dart';

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
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     minimumSize: Size(350,50),
                      //     padding: EdgeInsets.all(10.0),
                      //     textStyle: const TextStyle(fontSize: 30)
                      //   ),
                      //   child: Text("shrug_left"),
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       new MaterialPageRoute(builder: (context) => new pose_view()),
                      //     );
                      //   },
                      // ),
                      SizedBox(height: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(350,50),
                            padding: EdgeInsets.all(10.0),
                            textStyle: const TextStyle(fontSize: 30)
                        ),
                        child: Text("shrug_right"),
                        onPressed: () {
                          global.posenumber = 0;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 3;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 2;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 2;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 5;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 6;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 7;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 8;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                          global.posenumber = 9;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                        child: Text("towel_right"),
                        onPressed: () {
                          global.posenumber = 11;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                        child: Text("thigh_stretch_right"),
                        onPressed: () {
                          global.posenumber = 12;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                        child: Text("raise_feet_right"),
                        onPressed: () {
                          global.posenumber = 13;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                        child: Text("thigh_abduction_right"),
                        onPressed: () {
                          global.posenumber = 14;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                        child: Text("bent_knees_right"),
                        onPressed: () {
                          global.posenumber = 15;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                        child: Text("calf_knees_right"),
                        onPressed: () {
                          global.posenumber = 17;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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
                        child: Text("lift_feet_right"),
                        onPressed: () {
                          global.posenumber = 18;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
                          );
                        },
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
            ),
          ),
    );
  }
}