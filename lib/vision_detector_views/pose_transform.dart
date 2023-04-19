import 'body_view/assembly.dart';
import 'detector_views.dart';

class global{
      static late int posenumber;
      static late Detector_default Det;
      static void pose_tranform(){
          switch(global.posenumber){
            case 0:
              global.Det = Detector_shrug_right();
              break;
            case 1:
              global.Det = Detector_hold_hands_right();
              break;
            case 2:
              global.Det = Detector_wipe_table_right();
              break;
            case 3:
              global.Det = Detector_crutch_right();
              break;
            // case 4:
            //   global.Det = ;
            //   break;
            case 5:
              global.Det = Detector_bath_right();
              break;
            case 6:
              global.Det = Detector_forward_shoulder_right();
              break;
            case 7:
              global.Det = Detector_forward_elbow_right();
              break;
            case 8:
              global.Det = Detector_shoulder_raise_right();
              break;
            case 9:
              global.Det = Detector_heads_raise_right();
              break;
            // case 10:
            //   global.Det = ;
            //   break;
            case 11:
              global.Det = Detector_towel_right();
              break;
            case 12:
              global.Det = Detector_thigh_stretch_right();
              break;
            case 13:
              global.Det = Detector_raise_feet_right();
              break;
            case 14:
              global.Det = Detector_thigh_abduction_right();
              break;
            case 15:
              global.Det = Detector_bent_knees_right();
              break;
            // case 16:
            //   global.Det = ;
            //   break;
            case 17:
              global.Det = Detector_calf_knees_right();
              break;
            case 18:
              global.Det = Detector_lift_feet_right();
              break;
            // case 19:
            //   global.Det = ;
            //   break;
            // case 20:
            //   global.Det = ;
            //   break;
            // case 21:
            //   global.Det = ;
            //   break;
            // case 22:
            //   global.Det = ;
            //   break;
            // case 23:
            //   global.Det = ;
            //   break;
          }
      }
}




