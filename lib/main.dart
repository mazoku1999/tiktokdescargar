import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'package:permission_handler/permission_handler.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:tiktokdescargar/pruebas.dart';
import 'package:tiktokdescargar/youtube.dart';

import 'apiyoutubeoficial.dart';
import 'diodescarga.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/api',
      routes: {
        '/descargar': (context) => Descargar(),
        '/youtube': (context) => YoutubeDescargasScreen(),
        '/pruebas': (context) => PruebasScreen(),
        '/dio': (context) => DioPruebas(),
        '/api': (context) => ApiYoutube(),
      },
    );
  }
}

class Descargar extends StatefulWidget {
  const Descargar({
    super.key,
  });

  @override
  State<Descargar> createState() => _DescargarState();
}

class _DescargarState extends State<Descargar> {
  void descargar(String urlVideo) async {
    final headers = {
      'authority': 'ssstik.io',
      'accept': '*/*',
      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie':
          '_gid=GA1.2.1610617466.1695025708; __cflb=0H28v8EEysMCvTTqtuFFMWyYEmbm6aBgDEHD3sB5rrH; _ga=GA1.2.562759264.1695025708; _gat_UA-3524196-6=1; _ga_ZSF3D6YSLC=GS1.1.1695025708.1.1.1695025780.0.0.0',
      'hx-current-url': 'https://ssstik.io/es',
      'hx-request': 'true',
      'hx-target': 'target',
      'hx-trigger': '_gcaptcha_pt',
      'origin': 'https://ssstik.io',
      'referer': 'https://ssstik.io/es',
      'sec-ch-ua':
          '"Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36',
      'Accept-Encoding': 'gzip',
    };

    final params = {
      'url': 'dl',
    };

    final data = {
      'id': urlVideo,
      'locale': 'es',
      'tt': 'SG9NZ04y',
    };

    final url =
        Uri.parse('https://ssstik.io/abc').replace(queryParameters: params);

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.post error: statusCode= $status');

    print(res.body);
    // Analizar el HTML de la respuesta
    final document = htmlParser.parse(res.body);
    final linkElement = document.querySelector('a.download_link');

    if (linkElement != null) {
      final downloadLink = linkElement.attributes['href'];
      print('Enlace de descarga: $downloadLink');
      descargarTiktok(downloadLink ?? "");
    } else {
      print('No se encontró el enlace de descarga en la respuesta HTML.');
    }
  }

  void descargarTiktok(String url) async {
    // We didn't ask for permission yet or the permission has been denied before, but not permanently.
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: "/storage/emulated/0/Download",
      showNotification: true, // muestra la notificación de descarga
      openFileFromNotification:
          true, // abre el archivo descargado al hacer clic en la notificación
    );
  }

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  TextEditingController url = TextEditingController();
  String ga = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: url,
                decoration: InputDecoration(
                  hintText: "Ingrese el link del video",
                ),
              ),
              TextButton(
                  onPressed: () async {
                    final headers = {
                      'authority': 'www.y2mate.com',
                      'accept': '*/*',
                      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
                      'content-type':
                          'application/x-www-form-urlencoded; charset=UTF-8',
                      'cookie':
                          '_gid=GA1.2.631724283.1695087540; _ga=GA1.2.1398145108.1693712580; _ga_K8CD7CY0TZ=GS1.1.1695087539.3.1.1695087552.0.0.0',
                      'origin': 'https://www.y2mate.com',
                      'referer': 'https://www.y2mate.com/youtube/5R1RGl4WQP8',
                      'sec-ch-ua':
                          '"Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"',
                      'sec-ch-ua-mobile': '?0',
                      'sec-ch-ua-platform': '"macOS"',
                      'sec-fetch-dest': 'empty',
                      'sec-fetch-mode': 'cors',
                      'sec-fetch-site': 'same-origin',
                      'user-agent':
                          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36',
                      'x-requested-with': 'XMLHttpRequest',
                      'Accept-Encoding': 'gzip',
                    };

                    final data = {
                      'vid': '5R1RGl4WQP8',
                      'k':
                          'joFFCNezlMGnbMav6qaEosOrAl7j4qp2hNgqkwxyUfMcutx3garybZ4dYP9Z0YeyRcIFpmk=',
                    };

                    final url = Uri.parse(
                        'https://www.y2mate.com/mates/convertV2/index');

                    final res =
                        await http.post(url, headers: headers, body: data);
                    final status = res.statusCode;
                    if (status != 200)
                      throw Exception('http.post error: statusCode= $status');

                    //print(res.body);
                    Map<String, dynamic> jsonData = json.decode(res.body);
                    print(jsonData['dlink']);
                    descargarTiktok(jsonData['dlink']);
                    // setState(() {
                    //   ga = jsonData['url'][0]['url'];
                    //   print(ga);
                    // });

                    // setState(() {
                    //   ga = res.body;
                    // });
                    //print(res.body);
                    // final headers = {
                    //   'authority': 'api.ssyoutube.com',
                    //   'accept': 'application/json, text/plain, */*',
                    //   'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
                    //   'content-type': 'application/json',
                    //   'origin': 'https://ssyoutube.com',
                    //   'referer': 'https://ssyoutube.com/',
                    //   'sec-ch-ua':
                    //       '"Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"',
                    //   'sec-ch-ua-mobile': '?0',
                    //   'sec-ch-ua-platform': '"macOS"',
                    //   'sec-fetch-dest': 'empty',
                    //   'sec-fetch-mode': 'cors',
                    //   'sec-fetch-site': 'same-site',
                    //   'user-agent':
                    //       'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36',
                    //   'x-requested-with': 'XMLHttpRequest',
                    //   'Accept-Encoding': 'gzip',
                    // };

                    // final data =
                    //     '{"url":"https://www.facebook.com/watch?v=415989823482781","ts":1695074501971,"_ts":1695031115901,"_tsc":0,"_s":"fac4878b6be549c9ef96e59f4275a94aa4e126b4ce88ed7ee4cbc7082c67a222"}';

                    // final url =
                    //     Uri.parse('https://api.ssyoutube.com/api/convert');

                    // final res =
                    //     await http.post(url, headers: headers, body: data);
                    // //parsear respuesta body a json

                    // final status = res.statusCode;
                    // if (status != 200)
                    // throw Exception('http.post error: statusCode= $status');
                    // Map<String, dynamic> jsonData = json.decode(res.body);
                    // //print(jsonData['url']);
                    // setState(() {
                    //   ga = jsonData['url'][0]['url'];
                    //   print(ga);
                    // });
                    //print(res.body);
                  },
                  child: Text("Descargar")),
              TextField(
                maxLines: 10000000,
                //mostrar ga
                controller: TextEditingController(text: ga),
              )
            ],
          ),
        ),
      ),
    );
  }
}
