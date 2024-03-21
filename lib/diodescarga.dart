import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DioPruebas extends StatefulWidget {
  const DioPruebas({super.key});

  @override
  State<DioPruebas> createState() => _DioPruebasState();
}

class _DioPruebasState extends State<DioPruebas> {
  void downloadVideo(String url, String savePath) async {
    Dio dio = Dio();

    try {
      await dio.download(url, savePath);
      print('Video descargado con éxito en $savePath');
    } catch (error) {
      print('Error al descargar el video: $error');
    }
  }

  double _progress = 0.0;
  bool _downloading = false;

  void downloadVideoGa(String url, String savePath) async {
    Dio dio = Dio();
    try {
      setState(() {
        _downloading = true;
        _progress = 0.0;
      });

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );

      setState(() {
        _downloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Descarga completa. Video guardado en $savePath'),
        ),
      );
    } catch (error) {
      setState(() {
        _downloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al descargar el video: $error'),
        ),
      );
    }
  }

  Future<String> getVideoInfo(String videoId) async {
    final url =
        'https://www.youtube.com/youtubei/v1/player?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "context": {
        "client": {
          "hl": "en",
          "clientName": "WEB",
          "clientVersion": "2.20210721.00.00",
          "clientFormFactor": "UNKNOWN_FORM_FACTOR",
          "clientScreen": "WATCH",
          "mainAppWebInfo": {"graftUrl": "/watch?v=$videoId"}
        },
        "user": {"lockedSafetyMode": false},
        "request": {
          "useSsl": true,
          "internalExperimentFlags": [],
          "consistencyTokenJars": []
        }
      },
      "videoId": videoId,
      "playbackContext": {
        "contentPlaybackContext": {
          "vis": 0,
          "splay": false,
          "autoCaptionsDefaultOn": false,
          "autonavState": "STATE_NONE",
          "html5Preference": "HTML5_PREF_WANTS",
          "lactMilliseconds": "-1"
        }
      },
      "racyCheckOk": false,
      "contentCheckOk": false
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch video info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pruebas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _downloading
                  ? null
                  : () {
                      String videoUrl =
                          'https://dt144.dlsnap09.xyz/download?file=YmIwNzhiMmYzNzM2MzAwMmY5YzQ0NGFjN2QxZjU3ZTcxNGI1NjkxZjJkZDY5YmZkNDdjNTIxNmNiNTI1YmY3ZV8xMDgwcC5tcDTimK94Mm1hdGUuY29tLU1vbiBMYWZlcnRlIC0gVHUgRmFsdGEgRGUgUXVlcmVyIChFbiBWaXZvKeKYrzEwODBw';
                      String savePath =
                          '/storage/emulated/0/Download/videcapo.mp4';
                      downloadVideoGa(videoUrl, savePath);
                    },
              child: Text('Descargar Video'),
            ),
            SizedBox(height: 20.0),
            if (_downloading)
              CircularProgressIndicator(value: _progress)
            else
              LinearProgressIndicator(value: _progress),
            SizedBox(height: 20.0),
            Text(
                'Progreso de descarga: ${(100 * _progress).toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }
}
