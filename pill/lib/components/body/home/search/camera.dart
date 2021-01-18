import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:pill/components/body/home/search/photo_main.dart';
import 'package:pill/components/loading.dart';
import 'package:pill/model/provider.dart';
import 'package:pill/utility/palette.dart';
import 'package:pill/utility/textify.dart';
import 'package:provider/provider.dart';

// 사용자가 주어진 카메라를 사용하여 사진을 찍을 수 있는 화면
class Camera extends StatefulWidget {
  bool isFront;

  Camera({Key key, this.isFront}) : super(key: key);

  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  List<CameraDescription> cameras;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _setupCameras();
    // // 카메라의 현재 출력물을 보여주기 위해 CameraController를 생성합니다.
    // _controller = CameraController(
    //   // 이용 가능한 카메라 목록에서 특정 카메라를 가져옵니다.
    //   firstCamera,
    //   // 적용할 해상도를 지정합니다.
    //   ResolutionPreset.medium,
    // );

    // // 다음으로 controller를 초기화합니다. 초기화 메서드는 Future를 반환합니다.
    // _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _setupCameras() async {
    try {
      // initialize cameras.
      cameras = await availableCameras();
      // initialize camera controllers.
      _controller = new CameraController(cameras[0], ResolutionPreset.high);

      _initializeControllerFuture = _controller.initialize();
    } on CameraException catch (_) {
      // do something on error.
      print("setup cameras error!");
    }
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

// @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // App state changed before we got the chance to initialize.
//     if (_controller == null || !_controller.value.isInitialized) {
//       return;
//     }
//     if (state == AppLifecycleState.inactive) {
//       _controller?.dispose();
//     } else if (state == AppLifecycleState.resumed) {
//       if (_controller != null) {
//         onNewCameraSelected(_controller.description);
//       }
//     }
//   }

  @override
  void dispose() {
    // 위젯의 생명주기 종료시 컨트롤러 역시 해제시켜줍니다.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.key,
        // appBar: AppBar(title: Text('사진 촬영')),
        // 카메라 프리뷰를 보여주기 전에 컨트롤러 초기화를 기다려야 합니다. 컨트롤러 초기화가
        // 완료될 때까지 FutureBuilder를 사용하여 로딩 스피너를 보여주세요.
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Future가 완료되면, 프리뷰를 보여줍니다.
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      Expanded(
                          flex: 6,
                          child: Stack(
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width,
                                  child: CameraPreview(_controller)),
                              Positioned(
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  color: colorThemeGreen,
                                  dashPattern: [12, 6],
                                  radius: Radius.circular(20),
                                  strokeWidth: 5.0,
                                  child: SizedBox(width: 150, height: 150),
                                ),
                                left: MediaQuery.of(context).size.width * 0.5 -
                                    75,
                                top: MediaQuery.of(context).size.width * 0.5 -
                                    75,
                              )
                            ],
                          )),
                      Expanded(
                        flex: 2,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/icons/camera-outline-white.png'),
                                        size: 30,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05),
                                          primary: colorThemeGreen,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      // onPressed 콜백을 제공합니다.
                                      onPressed: () async {
                                        // try / catch 블럭에서 사진을 촬영합니다. 만약 뭔가 잘못된다면 에러에
                                        // 대응할 수 있습니다.
                                        try {
                                          // 카메라 초기화가 완료됐는지 확인합니다.
                                          await _initializeControllerFuture;

                                          // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
                                          // final path = join(
                                          //   // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
                                          //   // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
                                          //   // (await getApplicationDocumentsDirectory())
                                          //   (await getTemporaryDirectory()).path,
                                          //   '${DateTime.now()}.png',
                                          // );
                                          // 위에 있는 path로는 불러올 수 없음 : 경로가 안맞음
                                          var savedPath;
                                          // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
                                          await _controller.takePicture().then(
                                              (XFile file) =>
                                                  savedPath = file.path);

                                          // 사진을 촬영하면, 새로운 화면으로 넘어갑니다.
                                          PhotoSearchImageStore storage = Provider.of<PhotoSearchImageStore>(context, listen: false);
                                          storage.store(savedPath, widget.isFront ? 0 : 1);
                                          Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PhotoSearch()));
                                        } catch (e) {
                                          // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
                                          print(e);
                                        }
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: makeBoldTitleWithSize(
                                          "촬영하기", 14.0, TextAlign.center),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                            ]),
                      )
                    ],
                  );
                } else {
                  // 그렇지 않다면, 진행 표시기를 보여줍니다.
                  return loadingPage(context);
                }
              },
            )));
  }
}

// 사용자가 촬영한 사진을 보여주는 위젯
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: makeAppTitle('사진 확인하기')),
        // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
        // 경로로 `Image.file`을 생성하세요.
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.2,
                horizontal: MediaQuery.of(context).size.width * 0.1),
            /*
              나중에 사진 크기를 정해야함 !
              TODO: 모델링에 적합한 사진 크기를 물어볼 것
           */
            child: Image.file(File(imagePath)),
          ),
        ));
  }
}
