import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';


//左肩復健頁面
Detector Det = Detector();//初始化
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
  double remindtextsize = 25;
  double remindpaddingsize = 10;
  double Targetwidth = 0;
  double Targeheight = 0;
  int poseTarget  = 10; //目標次數設定_也要設定Det的
  final periodicTimer = Timer.periodic(//觸發偵測timer
    const Duration(seconds: 3),
        (timer) {
      Det.poseDetector();
      Det.posetargetdone();
    },
  );
  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(Det.getendDetector()){//退回上一頁
      Navigator.pop(context);
    }
    return Stack(
        alignment:Alignment.center ,
        fit: StackFit.expand,
        children: <Widget>[
          CameraView(//相機view
          title: 'Pose Detector_A',
            customPaint: _customPaint,
            text: _text,
            onImage: (inputImage) {
              processImage(inputImage);
            },
          ),
          Positioned(//開始前提醒視窗
            bottom: 100.0,
            child:Container(
              padding: EdgeInsets.all(remindpaddingsize),
              alignment:Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child:
              Text("請將全身拍攝於畫面框線內\n並維持鏡頭穩定\n準備完成請按「開始復健」",textAlign: TextAlign.center,
              style: TextStyle(fontSize: remindtextsize,color: Colors.black,height: 1.2,inherit: false,),
              ),
            ),
          ),
          Positioned(//復健按鈕
            bottom: 20.0,
            left: 20,
            child:
            ElevatedButton (
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                textStyle: const TextStyle(fontSize: 30)
              ),
              child: Text("開始復健"),
              onPressed: () {
                remindtextsize=0;
                remindpaddingsize=0;
                Targetwidth = 360;
                Targeheight = 80;
                Det.startD();
                Det.setStandpoint();
              },
            ),
          ),
          Positioned(//計數器UI
            bottom: 10.0,
            left: 20,
              child: Container(
                width: Targetwidth,
                height: Targeheight,
                padding: EdgeInsets.all(10),
                alignment:Alignment.center,
                decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                child:
                Text("目前次數: ${Det.getcounter()}  目標次數:$poseTarget",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30,color: Colors.black,height: 1.2,inherit: false,),
                ),
              ),
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

class Detector{
  int posecounter = 0;//復健動作實作次數
  int poseTarget  = 10;
  bool startdDetector = false;//偵測
  bool endDetector = false;
  double? Standpoint_X=0;
  double? Standpoint_Y=0;

  void startD(){//開始辨識
    this.startdDetector = true;
    print("startdDetector be true");
  }

  int getcounter(){
    return this.posecounter;
  }

  bool getendDetector(){
    return this.endDetector;
  }

  void poseDetector(){//偵測判定
    if(this.startdDetector){
      print(posedata[23]!);
      print(this.Standpoint_Y!);
      if(posedata[23]! < (this.Standpoint_Y!)){
        this.posecounter++;
      }
    }
  }
  void setStandpoint(){//設定基準點(左上角為(0,0)向右下)
    this.Standpoint_X = posedata[22]!-100;
    this.Standpoint_Y = posedata[23]!-100;
  }
  void posetargetdone(){//完成任務後復歸
    if(this.posecounter == this.poseTarget){
      this.posecounter = 0;
      this.startdDetector = false;
      this.endDetector = true;
    }
  }
}



