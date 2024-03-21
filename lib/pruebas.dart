import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

class PruebasScreen extends StatefulWidget {
  const PruebasScreen({super.key});

  @override
  State<PruebasScreen> createState() => _PruebasScreenState();
}

class _PruebasScreenState extends State<PruebasScreen> {
  void Y2Mate() async {
    final headers = {
      'authority': 'srvcdn1.2convert.me',
      'accept': '*/*',
      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'origin': 'null',
      'referer': 'https://en1.y2mate.is/',
      'sec-ch-ua':
          '"Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'cross-site',
      'user-agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36',
      'x-csrf-token': 'NGlQEnBukWPByjOUvNFAOzQH3OK582HEfoJnvrDd',
      'Accept-Encoding': 'gzip',
    };

    final url = Uri.parse(
        'https://srvcdn1.2convert.me/api/json?url=https://www.youtube.com/watch?v=NYwHQFl_viU');

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.get error: statusCode= $status');

    print(res.body);
  }

  void SaveTheVideo() async {
    final headers = {
      'authority': 'api.w03.savethevideo.com',
      'accept': 'application/json',
      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
      'origin': 'https://www.savethevideo.com',
      'referer': 'https://www.savethevideo.com/',
      'sec-ch-ua':
          '"Chromium";v="116", "Not)A;Brand";v="24", "Google Chrome";v="116"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-site',
      'user-agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36',
      'Accept-Encoding': 'gzip',
    };

    final url = Uri.parse(
        'https://api.w03.savethevideo.com//tasks/aa6631c9-5c07-4083-bd1b-50b79b6072c3');

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.get error: statusCode= $status');

    print(res.body);
  }

  void Fvdownloader() async {
    final headers = {
      'authority': 'fvdownloader.net',
      'accept': 'application/json, text/javascript, */*; q=0.01',
      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie':
          'PHPSESSID=3qv318peidvebtpilbp99cnlq7; _ga=GA1.1.2033063965.1695156017; _ga_5JPP6DDGFQ=GS1.1.1695156016.1.0.1695156029.0.0.0',
      'origin': 'https://fvdownloader.net',
      'referer': 'https://fvdownloader.net/',
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
      'query': 'https://www.facebook.com/watch?v=253380160029296',
    };

    final url = Uri.parse('https://fvdownloader.net/req');

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.post error: statusCode= $status');

    print(res.body);
  }

  void descargar() async {
    final headers = {
      'authority': 'getmyfb.com',
      'accept': '*/*',
      'accept-language': 'es-BO,es-419;q=0.9,es;q=0.8,en;q=0.7',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'cookie':
          '_gid=GA1.2.1830833648.1695169042; PHPSESSID=7lfud51d0k5d9ur44575k5iipq; _gat_UA-3524196-5=1; _token=GDBTUflOVtV9k4e2135n; _ga=GA1.2.1674082432.1695169042; _ga_96G5RB4BBD=GS1.1.1695169041.1.1.1695169161.0.0.0',
      'hx-current-url': 'https://getmyfb.com/es',
      'hx-request': 'true',
      'hx-target': 'target',
      'hx-trigger': 'form',
      'origin': 'https://getmyfb.com',
      'referer': 'https://getmyfb.com/es',
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

    final data = {
      'id': 'https://www.facebook.com/100002409030078/videos/1065572408134588/',
      'locale': 'es',
    };

    final url = Uri.parse('https://getmyfb.com/process');

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.post error: statusCode= $status');

    print(res.body);
    // Analizar el HTML de la respuesta
    final document = htmlParser.parse(res.body);
    final linkElement = document.querySelector('a.results-list-item');

    if (linkElement != null) {
      final downloadLink = linkElement.attributes['href'];
      print('Enlace de descarga: $downloadLink');
    } else {
      print('No se encontró el enlace de descarga en la respuesta HTML.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pruebas')),
      body: Column(
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                descargar();
              },
              child: Text('Descargar'),
            ),
          )
        ],
      ),
    );
  }
}
