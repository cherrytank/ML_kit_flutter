import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
import '../assembly.dart';

//右拐杖復健頁面
class crutch_right extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<crutch_right> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  Detector_crutch_right Det = new Detector_crutch_right();//建立偵測系統
  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    Det.timerbool = false;//關閉timer
    cameramode_front =false;//覆歸攝影機設定
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Det.endDetector) {
      //退回上一頁
      print("back page");
      Navigator.pop(context);
    }
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        CameraView(
          //相機view
          title: 'Pose',
          customPaint: _customPaint,
          text: _text,
          onImage: (inputImage) {
            processImage(inputImage);
          },
        ),
        Positioned(
          //人形立牌
          top: 120,
          child:Image(
            height: Det.fakepreson,
            image: AssetImage("assets/picture/b.png"),)
          ).animate().slide(duration: 500.ms),
        Positioned(
          //倒數計時
            top: 180,
            child:Container(
              height: 120,
              width: 100,
              child: Text(
                "${Det.mathText}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontSize: 100,
                  color: Colors.amber,
                  inherit: false,
                ),
              ),
            )
        ),
        Positioned(
          //開始前提醒視窗
          bottom: 100.0,
          child: Container(
            width: 1000,
            padding: EdgeInsets.all(Det.remindpaddingsize),
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              color: Color.fromARGB(132, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(
              "上身攝於畫面內並微面左\n並維持鏡頭穩定\n準備完成請按「Start」",
              textAlign: TextAlign.center,
              style: TextStyle(
                backgroundColor: Colors.transparent,
                fontSize: Det.remindtextsize,
                color: Colors.black,
                height: 1.2,
                inherit: false,
              ),
            ),
          ),
        ).animate().slide(duration: 500.ms),
        Positioned(
            //復健按鈕
            bottom: 15.0,
            child: Container(
              height: Det.buttomsize,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                  padding: EdgeInsets.all(15),
                  backgroundColor: Color.fromARGB(250, 255, 190, 52),
                ),
                child: Text("Start!",
                    style: TextStyle(
                      fontSize: Det.buttomtextsize,
                      color: Colors.white,
                    )),
                onPressed: () {
                  Det.startd();
                },
              ),
            )).animate().slide(duration: 500.ms),
        Positioned(
          //計數器UI
          bottom: 10,
          right: -10,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color.fromARGB(250, 65, 64, 64),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20),
                right: Radius.circular(0),
              ),
            ),
            width: Det.counterUIsize,
            height: 90,
            child: Text(
              "次數\n${Det.posecounter}/${Det.poseTarget}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(250, 255, 190, 52),
                height: 1.2,
                inherit: false,
              ),
            ),
          ),
        ),
        Positioned(
          //計時器UI
          bottom: 10,
          left: -10,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color.fromARGB(250, 65, 64, 64),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(0),
                right: Radius.circular(20),
              ),
            ),
            width: Det.counterUIsize,
            height: 90,
            child: Text(
              "秒數\n${Det.posetimecounter}/${Det.posetimeTarget}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(250, 255, 190, 52),
                height: 1.2,
                inherit: false,
              ),
            ),
          ),
        ),
        Positioned(//提醒視窗
          bottom: 100,
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: new BoxDecoration(
              color: Color.fromARGB(218, 255, 190, 52),
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
                fontSize: 28,
                color: Colors.white,
                height: 1.2,
                inherit: false,
              ),
            ),
          ),
        )
            .animate(
                onPlay: (controller) => controller.repeat())
            .scaleXY(end: 0.2,duration: 2.seconds),

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

class Detector_crutch_right {
  int posetimecounter = 0; //復健動作持續秒數
  int posetimeTarget = 5; //復健動作持續秒數目標
  int posecounter = 0; //復健動作實作次數
  int poseTarget = 10; //目標次數設定
  bool startdDetector = false; //偵測
  bool endDetector = false; //跳轉
  bool DetectorED = false;
  bool timerbool=true;//倒數計時器
  double? Standpoint_X = 0;
  double? Standpoint_Y = 0;
  double? Standpoint_bodymind_x = 0;//身體終點
  double? Standpoint_bodymind_y = 0;//身體終點
  double remindtextsize = 25;//提醒視窗
  double remindpaddingsize = 10;//提醒視窗
  double buttomtextsize = 35;//開始復健按鈕
  double buttomsize = 80;//開始復健按鈕
  double Targetwidth = 0;
  double Targetheight = 0;
  double counterUIsize = 0;//開始後UI介面
  double fakepreson = 0;//虛擬假人
  String orderText = "請前伸右臂";//目標提醒
  String mathText = "";//倒數文字

  void startd(){//倒數計時
      int counter = 5;
      buttomtextsize = 0;
      buttomsize = 0;
      Timer.periodic(//觸發偵測timer
        const Duration(seconds: 1),
            (timer) {
          mathText = "${counter--}";
          if(counter<0){
            print("cancel timer");
            timer.cancel();
            mathText = " ";
            startD();
          }
        },
      );
  }

  void startD() {
    //開始辨識
    this.startdDetector = true;
    print("startdDetector be true");
    setStandpoint();
    settimer();
    remindtextsize = 0;
    remindpaddingsize = 0;
    counterUIsize = 100;
    Targetwidth = 360;
    Targetheight = 110;
    fakepreson = 0;
  }

  void poseDetector() {
    //偵測判定
    if (this.startdDetector) {
      DetectorED = true;
      this.orderText = "請前伸右臂";
      if (this.posetimecounter == this.posetimeTarget) {
        //秒數達成
        this.startdDetector = false;
        this.posecounter++;
        this.posetimecounter = 0;
        this.orderText = "達標!";
      }
      if (angle(posedata[24]!,posedata[25]!,posedata[28]!,posedata[29]!,posedata[32]!,posedata[33]!)>130
          && posedata[33]!<(posedata[49]!)
        &&this.startdDetector) {
        //每秒目標
        this.posetimecounter++;
        print(this.posetimecounter);
        this.orderText = "請保持住!";
      } else {
        //沒有保持
        this.posetimecounter = 0;
      }
    } else if (DetectorED) {
      //預防空值被訪問
      if (angle(posedata[24]!,posedata[25]!,posedata[28]!,posedata[29]!,posedata[32]!,posedata[33]!)<130) {
        //確認復歸
        this.startdDetector = true;
      } else {
        this.orderText = "請縮回手臂";
      }
    }
  }

  void setStandpoint() {
    //設定基準點(左上角為(0,0)向右下)
    this.Standpoint_X = posedata[22]! - 20;
    this.Standpoint_Y = posedata[23]! - 20;
    this.Standpoint_bodymind_x = (posedata[22]!+posedata[24]!)/2;
    this.Standpoint_bodymind_y = (posedata[23]!+posedata[25]!)/2;
  }

  void posetargetdone() {
    //完成任務後發出退出信號
    if (this.posecounter == this.poseTarget) {
      this.endDetector = true;
    }
  }

  double distance(double x1,double y1,double x2,double y2){
    return sqrt(pow((x1-x2).abs(),2)+pow((y1-y2).abs(),2));
  }

  double angle(double x1,double y1,double x2,double y2,double x3,double y3){
    double vx1= x1-x2;
    double vy1= y1-y2;
    double vx2= x3-x2;
    double vy2= y3-y2;
    double porduct = vx1*vx2+vy1*vy2;
    double result = acos(porduct/(distance(x1, y1, x2, y2)*distance(x3, y3, x2, y2)))*57.3;
    print(result);
    return result;
  }

  void settimer(){
      Timer.periodic(//觸發偵測timer
        const Duration(seconds: 1),
            (timer) {
          poseDetector(); //偵測目標是否完成動作
          posetargetdone(); //偵測目標是否完成指定次數
          if(!this.timerbool){
            print("cancel timer");
            timer.cancel();
          }
        },
      );
  }
}
