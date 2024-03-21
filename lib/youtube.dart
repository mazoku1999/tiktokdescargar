import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;
import 'dart:convert';

import 'package:toast/toast.dart';

class YoutubeDescargasScreen extends StatefulWidget {
  const YoutubeDescargasScreen({super.key});

  @override
  State<YoutubeDescargasScreen> createState() => _YoutubeDescargasScreenState();
}

class _YoutubeDescargasScreenState extends State<YoutubeDescargasScreen> {
  String? titulo = '';
  String stado = '';
  String duracion = '';

  List<Map<String, dynamic>> lista = [];
  Map<String, dynamic> informacion = {};
  void ObtenerInformacion(String video) async {
    final headers = {
      'authority': 'www.y2mate.com',
      'accept': '*/*',
      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie':
          '_gid=GA1.2.631724283.1695087540; _gat_gtag_UA_84863187_21=1; _ga_K8CD7CY0TZ=GS1.1.1695087539.3.1.1695087549.0.0.0; _ga=GA1.2.1398145108.1693712580',
      'origin': 'https://www.y2mate.com',
      'referer': 'https://www.y2mate.com/en848',
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
      'k_query': video,
      'k_page': 'home',
      'hl': 'en',
      'q_auto': '0',
    };

    final url = Uri.parse('https://www.y2mate.com/mates/analyzeV2/ajax');

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.post error: statusCode= $status');

    Map<String, dynamic>? jsonData = json.decode(res.body);
    //print(jsonData['links']['mp4']);
    final List<Map<String, dynamic>> videoQualities = jsonData?['links']?['mp4']
            .values
            .toList()
            .cast<Map<String, dynamic>>() ??
        [];
    //print(videoQualities[0]['q']);
    setState(() {
      titulo = jsonData?['title'] ?? '';
      stado = jsonData?['status'] ?? '';
      duracion = jsonData?['t'].toString() ?? '';
      lista = videoQualities;
      informacion = jsonData ?? {};
    });
  }

  void ObtenerEnlace(String key, String id) async {
    final headers = {
      'authority': 'www.y2mate.com',
      'accept': '*/*',
      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
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
      'vid': id,
      'k': key,
    };

    final url = Uri.parse('https://www.y2mate.com/mates/convertV2/index');

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.post error: statusCode= $status');

    //print(res.body);
    Map<String, dynamic> jsonData = json.decode(res.body);
    print(jsonData['dlink']);
    descargarTiktok(jsonData['dlink']);
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

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Descargas')),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Ingrese el link del video',
            ),
            onChanged: (value) {
              try {
                ObtenerInformacion(value);
              } catch (e) {
                Toast.show("Error al obtener la información",
                    duration: Toast.lengthLong, gravity: Toast.bottom);
              }
            },
          ),
          TextButton(
            onPressed: () {
              ObtenerInformacion(_controller.text);
            },
            child: Text('Descargar'),
          ),
          Text(titulo!.isEmpty ? 'Datos Incorrectos' : titulo!),
          //Text(duracion),
          Expanded(
            child: ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            ObtenerEnlace(
                                lista[index]['k'], informacion['vid']);
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Calidad: " + lista[index]['q']),
                                Text("Tamaño: " + lista[index]['size']),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
