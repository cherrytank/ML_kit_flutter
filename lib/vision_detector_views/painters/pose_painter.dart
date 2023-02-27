import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'coordinates_translator.dart';
List<double?> posedata=[];
class PosePainter extends CustomPainter {
  PosePainter(this.poses, this.absoluteImageSize, this.rotation);
  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = Colors.green;

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.yellow;

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.blueAccent;

    final headPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.white30;

    for (final pose in poses) {
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
            Offset(
              translateX(landmark.x, rotation, size, absoluteImageSize),
              translateY(landmark.y, rotation, size, absoluteImageSize),
            ),
            1,
            paint);
      });

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                translateY(joint2.y, rotation, size, absoluteImageSize)),
            paintType);
      }

      //Draw arms
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);

      //Draw Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          rightPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.leftShoulder, headPaint);
      paintLine(PoseLandmarkType.rightHip, PoseLandmarkType.leftHip, headPaint);
      //Draw legs
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);
      //Draw face
      paintLine(PoseLandmarkType.leftEar, PoseLandmarkType.leftEyeOuter, headPaint);
      paintLine(PoseLandmarkType.leftEyeOuter, PoseLandmarkType.leftEye, headPaint);
      paintLine(PoseLandmarkType.leftEyeInner, PoseLandmarkType.nose, headPaint);
      paintLine(PoseLandmarkType.nose, PoseLandmarkType.rightEyeInner, headPaint);
      paintLine(PoseLandmarkType.rightEyeInner, PoseLandmarkType.rightEyeOuter, headPaint);
      paintLine(PoseLandmarkType.rightEyeOuter, PoseLandmarkType.rightEar, headPaint);
      paintLine(PoseLandmarkType.rightMouth, PoseLandmarkType.leftMouth, headPaint);

      //return data
      //print(pose.landmarks[PoseLandmarkType.leftShoulder]?.x);
      posedata=[pose.landmarks[PoseLandmarkType.nose]?.x,pose.landmarks[PoseLandmarkType.nose]?.y,
        pose.landmarks[PoseLandmarkType.leftEyeInner]?.x,pose.landmarks[PoseLandmarkType.leftEyeInner]?.y,
        pose.landmarks[PoseLandmarkType.leftEye]?.x,pose.landmarks[PoseLandmarkType.leftEye]?.y,
        pose.landmarks[PoseLandmarkType.leftEyeOuter]?.x,pose.landmarks[PoseLandmarkType.leftEyeOuter]?.y,
        pose.landmarks[PoseLandmarkType.rightEyeInner]?.x,pose.landmarks[PoseLandmarkType.rightEyeInner]?.y,
        pose.landmarks[PoseLandmarkType.rightEye]?.x,pose.landmarks[PoseLandmarkType.rightEye]?.y,
        pose.landmarks[PoseLandmarkType.rightEyeOuter]?.x,pose.landmarks[PoseLandmarkType.rightEyeOuter]?.y,
        pose.landmarks[PoseLandmarkType.leftEar]?.x,pose.landmarks[PoseLandmarkType.leftEar]?.y,
        pose.landmarks[PoseLandmarkType.rightEar]?.x,pose.landmarks[PoseLandmarkType.rightEar]?.y,
        pose.landmarks[PoseLandmarkType.leftMouth]?.x,pose.landmarks[PoseLandmarkType.leftMouth]?.y,
        pose.landmarks[PoseLandmarkType.rightMouth]?.x,pose.landmarks[PoseLandmarkType.rightMouth]?.y,
        pose.landmarks[PoseLandmarkType.leftShoulder]?.x,pose.landmarks[PoseLandmarkType.leftShoulder]?.y,
        pose.landmarks[PoseLandmarkType.rightShoulder]?.x,pose.landmarks[PoseLandmarkType.rightShoulder]?.y,
        pose.landmarks[PoseLandmarkType.leftElbow]?.x,pose.landmarks[PoseLandmarkType.leftElbow]?.y,
        pose.landmarks[PoseLandmarkType.rightElbow]?.x,pose.landmarks[PoseLandmarkType.rightElbow]?.y,
        pose.landmarks[PoseLandmarkType.leftWrist]?.x,pose.landmarks[PoseLandmarkType.leftWrist]?.y,
        pose.landmarks[PoseLandmarkType.rightWrist]?.x,pose.landmarks[PoseLandmarkType.rightWrist]?.y,
        pose.landmarks[PoseLandmarkType.leftPinky]?.x,pose.landmarks[PoseLandmarkType.leftPinky]?.y,
        pose.landmarks[PoseLandmarkType.rightPinky]?.x,pose.landmarks[PoseLandmarkType.rightPinky]?.y,
        pose.landmarks[PoseLandmarkType.leftIndex]?.x,pose.landmarks[PoseLandmarkType.leftIndex]?.y,
        pose.landmarks[PoseLandmarkType.rightIndex]?.x,pose.landmarks[PoseLandmarkType.rightIndex]?.y,
        pose.landmarks[PoseLandmarkType.leftThumb]?.x,pose.landmarks[PoseLandmarkType.leftThumb]?.y,
        pose.landmarks[PoseLandmarkType.rightThumb]?.x,pose.landmarks[PoseLandmarkType.rightThumb]?.y,
        pose.landmarks[PoseLandmarkType.leftHip]?.x,pose.landmarks[PoseLandmarkType.leftHip]?.y,
        pose.landmarks[PoseLandmarkType.rightHip]?.x,pose.landmarks[PoseLandmarkType.rightHip]?.y,
        pose.landmarks[PoseLandmarkType.leftKnee]?.x,pose.landmarks[PoseLandmarkType.leftKnee]?.y,
        pose.landmarks[PoseLandmarkType.rightKnee]?.x,pose.landmarks[PoseLandmarkType.rightKnee]?.y,
        pose.landmarks[PoseLandmarkType.leftAnkle]?.x,pose.landmarks[PoseLandmarkType.leftAnkle]?.y,
        pose.landmarks[PoseLandmarkType.rightAnkle]?.x,pose.landmarks[PoseLandmarkType.rightAnkle]?.y,
        pose.landmarks[PoseLandmarkType.leftHeel]?.x,pose.landmarks[PoseLandmarkType.leftHeel]?.y,
        pose.landmarks[PoseLandmarkType.rightHeel]?.x,pose.landmarks[PoseLandmarkType.rightHeel]?.y,
        pose.landmarks[PoseLandmarkType.leftFootIndex]?.x,pose.landmarks[PoseLandmarkType.leftFootIndex]?.y,
        pose.landmarks[PoseLandmarkType.rightFootIndex]?.x,pose.landmarks[PoseLandmarkType.rightFootIndex]?.y,
      ];
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}
