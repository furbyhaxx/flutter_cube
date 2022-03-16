import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Position {
  final double x;
  final double y;
  final double z;

  Position([this.x = 0, this.y = 0, this.z = 0]);

  Position copyWith({double? x, double? y, double? z}) {
    return Position(x ?? this.x, y ?? this.y, z ?? this.z);
  }
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Scene _scene;
  double _ambient = 0.1;
  double _diffuse = 0.8;
  double _specular = 0.5;
  double _shininess = 0.0;

  Vector3 cameraPosition = Vector3(0, 0, 5);
  Vector3 cameraTarget = Vector3(0, 0, 0);

  Object? _groundPlane;
  Object? _cube;

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    scene.camera.position.x = cameraPosition.x;
    scene.camera.position.y = cameraPosition.y;
    scene.camera.position.z = cameraPosition.z;
    scene.camera.target.x = cameraTarget.x;
    scene.camera.target.y = cameraTarget.y;
    scene.camera.target.z = cameraTarget.z;

    _cube = Object(
        scale: Vector3(1.0, 1.0, 1.0),
        backfaceCulling: false,
        // fileName: 'assets/workspace/w20.obj',
        fileName: 'assets/workspace/w20_ascii.stl',
    );
    scene.light.position.setFrom(Vector3(0, 10, 10));
    scene.light.setColor(Colors.white, _ambient, _diffuse, _specular);
    // _bunny = Object(position: Vector3(0, -1.0, 0), scale: Vector3(10.0, 10.0, 10.0), lighting: true, fileName: 'assets/bunny/bunny.obj');
    // scene.world.add(_bunny!);
    scene.world.add(_cube!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Cube(
                onSceneCreated: _onSceneCreated,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
                height: 125,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
