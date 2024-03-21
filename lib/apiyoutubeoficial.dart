import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ApiYoutube extends StatefulWidget {
  const ApiYoutube({super.key});

  @override
  State<ApiYoutube> createState() => _ApiYoutubeState();
}

class _ApiYoutubeState extends State<ApiYoutube> {
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

  final dio = Dio();

  Future<void> downloadVideo() async {
    final url =
        'https://rr1---sn-xouxacv-a2cl.googlevideo.com/videoplayback?expire=1695812362&ei=qrYTZcClDo3ewgTwgoPAAw&ip=2800%3Acd0%3A7a1c%3Ad800%3A82a%3A6508%3A56d4%3Ae8e1&id=o-AAiOfHeBuAYJsxpK8BYAcPQwLBEwPOy0xO1wiWezMVds&itag=160&aitags=133%2C134%2C135%2C136%2C137%2C160%2C242%2C243%2C244%2C247%2C248%2C278%2C394%2C395%2C396%2C397%2C398%2C399&source=youtube&requiressl=yes&mh=Hn&mm=31%2C29&mn=sn-xouxacv-a2cl%2Csn-nja7snll&ms=au%2Crdu&mv=m&mvi=1&pcm2cms=yes&pl=44&initcwndbps=768750&spc=UWF9f4cWxVF9L575W6xsiN_LOj9Ls2qhmRvHCuQQVA&vprv=1&svpuc=1&mime=video%2Fmp4&ns=JGvm-pwwZ8rJ0O2whd_ggr8P&gir=yes&clen=767115&dur=155.899&lmt=1630014406802124&mt=1695790372&fvip=5&keepalive=yes&fexp=24007246&beids=24350017&c=WEB&txp=5432432&n=8QsuR-k9Hl-CjF9Ec&sparams=expire%2Cei%2Cip%2Cid%2Caitags%2Csource%2Crequiressl%2Cspc%2Cvprv%2Csvpuc%2Cmime%2Cns%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAP4smXRjvZIfMKymxSjOXRE9uGdNaOFDFavcCUfYEx6wAiEAksOeBDbL71c_8GAA0qEZ8GCrpF_6yobW8un6K-hk738%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpcm2cms%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRAIgJ2kaOl9YHeT2pxe5Lpt1D6MQ2_OpZDwdmhWBeSZEfhkCIHwTSFPVzI5xSzh93_of4jKVvADRdwf26Ln01w_GuiXx';
    final savePath = '/storage/emulated/0/Download/goku.mp4';
    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Video descargado en $savePath'),
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al descargar el video'),
      ));
    }
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Descargas')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  downloadVideo();
                  //print(await getVideoInfo("8LuWMYXW6nw"));
                  _controller.text = await getVideoInfo("3dNmAnBO31Y");
                },
                child: Text("Descargar"),
              ),
            ),
            TextField(
              maxLines: 1000000,
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingrese el link del video',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
