import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_fonts/google_fonts.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.indigo, brightness: Brightness.dark),
      home: const SDScaffold(),
    );
  }
}

class SDScaffold extends StatefulWidget {
  const SDScaffold({Key? key}) : super(key: key);
  @override
  State<SDScaffold> createState() => _SDScaffoldState();
}

class _SDScaffoldState extends State<SDScaffold> {
  String fileName = "trial.txt", fileContent = "hello to the world, flutter programming", txt = 'No Text Here. Wait and read.';
  Future<void> reqAndWrite() async {
    await Permission.manageExternalStorage.request();
    return writeToFile();
  }

  Future<void> writeToFile() async {
    List<String> paths;
    paths = await ExternalPath.getExternalStorageDirectories();
    File obj = File('${paths[1]}/$fileName');
    obj = await obj.create();
    obj.writeAsString(fileContent);
  }

  Future<void> justRead() async {
    List<String> paths;
    paths = await ExternalPath.getExternalStorageDirectories();
    File obj = File('${paths[1]}/$fileName');
    txt = await obj.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SD Card'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                reqAndWrite();
              },
              child: const Text('Click')),
          Text(txt, style: GoogleFonts.caladea(fontSize: 20),),
          ElevatedButton(
              onPressed: () {
                setState((){
                  justRead();
                });
              },
              child: const Text('Read'))
        ],
      ),
    );
  }
}
