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
                        child: Text("聳肩"),
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
                        child: Text("拐杖撐手"),
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
                        child: Text("撐手"),
                        onPressed: () {
                          global.posenumber = 1;
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
                        child: Text("擦桌動作"),
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
                        child: Text("擦澡動作"),
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
                        child: Text("肩膀前舉"),
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
                        child: Text("手肘前伸"),
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
                        child: Text("肩膀側舉"),
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
                        child: Text("雙手抬舉"),
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
                        child: Text("擦毛巾"),
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
                        child: Text("大腿伸彎"),
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
                        child: Text("躺姿抬腳"),
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
                        child: Text("大腿外展"),
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
                        child: Text("膝蓋彎曲"),
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
                        child: Text("小腿前踢"),
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
                        child: Text("側抬腳式"),
                        onPressed: () {
                          global.posenumber = 18;
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
                        child: Text("站姿抬腳"),
                        onPressed: () {
                          global.posenumber = 19;
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
                        child: Text("跨步動作"),
                        onPressed: () {
                          global.posenumber = 20;
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
                        child: Text("站姿膝彎曲"),
                        onPressed: () {
                          global.posenumber = 21;
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
                        child: Text("坐姿平衡"),
                        onPressed: () {
                          global.posenumber = 23;
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new pose_view()),
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