import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';

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
  int posecounter = 0;
  int poseTarget  = 10; //目標次數設定
  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Text("目前次數:$posecounter  目標次數:$poseTarget",textAlign: TextAlign.center,
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
