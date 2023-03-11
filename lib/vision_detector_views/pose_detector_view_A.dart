import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';
import 'package:flutter_animate/flutter_animate.dart';

//左肩聳肩復健頁面
Detector Det = new Detector(); //初始化

class PoseDetectorView_A extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView_A> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  final periodicTimer = Timer.periodic(
    //觸發偵測timer
    const Duration(seconds: 1),
    (timer) {
      Det.poseDetector(); //偵測目標是否完成動作
      Det.posetargetdone(); //偵測目標是否完成指定次數
    },
  );

  @override
  void dispose() async {
    Det.endD();
    periodicTimer.cancel();
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Det.getendDetector()) {
      //退回上一頁
      Navigator.pop(context);
    }
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        CameraView(
          //相機view
          title: 'Pose Detector_A',
          customPaint: _customPaint,
          text: _text,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ),
        Positioned(
          //開始前提醒視窗
          bottom: 100.0,
          child: Container(
            width: 1000,
            padding: EdgeInsets.all(Det.remindpaddingsize),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(200, 18, 255, 247),
                Color.fromARGB(200, 0, 236, 188)
              ]),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(
              "上半身拍攝於畫面框線內\n並維持鏡頭穩定\n準備完成請按「Start」",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Det.remindtextsize,
                color: Colors.white,
                height: 1.2,
                inherit: false,
              ),
            ),
          ),
        ).animate().fade().slide(),
        Positioned(
            //復健按鈕
            bottom: 15.0,
            left: 20,
            child: Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 18, 255, 247),
                  Color.fromARGB(255, 0, 236, 188)
                ]),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.all(15),
                ),
                child: Text("Start!",
                    style: TextStyle(
                      fontSize: Det.buttomtextsize,
                      color: Colors.white,
                    )),
                onPressed: () {
                  Det.startD();
                  Det.setStandpoint();
                },
              ),
            )).animate().fade().slide(),
        Positioned(
          //計數器UI
          bottom: 10,
          right: -10,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(250, 18, 255, 247),
                Color.fromARGB(250, 0, 236, 188)
              ]),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(0),
              ),
            ),
            width: Det.counterUIsize,
            height: 90,
            child: Text(
              "次數\n${Det.getcounter()}/${Det.getTarget()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                height: 1.2,
                inherit: false,
              ),
            ),
          ),
        ).animate().fade().slide(),
        Positioned(
          //計時器UI
          bottom: 10,
          left: -10,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(250, 18, 255, 247),
                Color.fromARGB(250, 0, 236, 188)
              ]),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(0),
                right: Radius.circular(20),
              ),
            ),
            width: Det.counterUIsize,
            height: 90,
            child: Text(
              "秒數\n${Det.getposetimecounter()}/${Det.getposetimeTarget()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                height: 1.2,
                inherit: false,
              ),
            ),
          ).animate().fade().slide(),
        ).animate().fade().slide(),
        Positioned(
          bottom: 80,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: new BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(150, 18, 255, 247),
                Color.fromARGB(150, 0, 236, 188)
              ]),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(30),
                right: Radius.circular(30),
              ),
            ),
            width: 220,
            height: Det.counterUIsize,
            child: Text(
              "${Det.orderText}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                height: 1.2,
                inherit: false,
              ),
            ),
          ),
        )
            .animate(
                delay: 1000.ms, onPlay: (controller) => controller.repeat())
            .scaleXY(
              end: 0.2,
              curve: Curves.easeInOutCubic,
            ),

      ],
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

class Detector {
  int posetimecounter = 0; //復健動作持續秒數
  int posetimeTarget = 5; //復健動作持續秒數目標
  int posecounter = 0; //復健動作實作次數
  int poseTarget = 10; //目標次數設定
  bool startdDetector = false; //偵測
  bool endDetector = false; //跳轉
  bool DetectorED = false;
  double? Standpoint_X = 0;
  double? Standpoint_Y = 0;
  double? Standpoint_bodymind = 0;
  double remindtextsize = 25;
  double remindpaddingsize = 10;
  double buttomtextsize = 35;
  double Targetwidth = 0;
  double Targetheight = 0;
  double counterUIsize = 0;
  String orderText = "請提起左肩";

  void startD() {
    //開始辨識
    this.startdDetector = true;
    print("startdDetector be true");
    buttomtextsize = 0;
    remindtextsize = 0;
    remindpaddingsize = 0;
    counterUIsize = 100;
    Targetwidth = 360;
    Targetheight = 110;
  }

  void endD() {
    //退出頁面
    this.posecounter = 0;
    this.startdDetector = false;
    this.endDetector = false;
    this.posetimecounter = 0; //復健動作持續秒數
    this.posecounter = 0; //復健動作實作次數
    this.startdDetector = false; //偵測
    this.endDetector = false; //跳轉
    this.DetectorED = false;
    this.Standpoint_X = 0;
    this.Standpoint_Y = 0;
    this.remindtextsize = 25;
    this.remindpaddingsize = 10;
    this.buttomtextsize = 35;
    this.Targetwidth = 0;
    this.Targetheight = 0;
    this.counterUIsize = 0;
    this.orderText = " ";
  }

  int getcounter() {
    return this.posecounter;
  }

  int getTarget() {
    return this.poseTarget;
  }

  bool getendDetector() {
    return this.endDetector;
  }

  int getposetimecounter() {
    return this.posetimecounter;
  }

  int getposetimeTarget() {
    return this.posetimeTarget;
  }

  double getStandpoint() {
    return this.Standpoint_Y!;
  }

  void poseDetector() {
    //偵測判定
    if (this.startdDetector) {
      DetectorED = true;
      print(posedata[23]!);
      print(this.Standpoint_Y!);
      this.orderText = "抬起左肩";
      if (this.posetimecounter == this.posetimeTarget) {
        //秒數達成
        this.startdDetector = false;
        this.posecounter++;
        this.posetimecounter = 0;
        this.orderText = "達標!";
      }
      if (posedata[23]! < (this.Standpoint_Y!) && this.startdDetector) {
        //每秒目標
        this.posetimecounter++;
        print(this.posetimecounter);
        this.orderText = "請保持住!";
      } else {
        //沒有保持
        this.posetimecounter = 0;
      }
      if((((posedata[22]!+posedata[24]!)/2)-this.Standpoint_bodymind!)<20){

      }
    } else if (DetectorED) {
      //預防空值被訪問
      if (posedata[23]! > (this.Standpoint_Y!)) {
        //確認復歸
        this.startdDetector = true;
      } else {
        this.orderText = "請復歸動作";
      }
    }
  }

  void setStandpoint() {
    //設定基準點(左上角為(0,0)向右下)
    this.Standpoint_X = posedata[22]! - 50;
    this.Standpoint_Y = posedata[23]! - 50;
    this.Standpoint_bodymind = (posedata[22]!+posedata[24]!)/2;
  }

  void posetargetdone() {
    //完成任務後復歸
    if (this.posecounter == this.poseTarget) {
      this.posecounter = 0;
      this.startdDetector = false;
      this.endDetector = true;
    }
  }
}
