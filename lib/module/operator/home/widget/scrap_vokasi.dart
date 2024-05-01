// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as parser;
// import 'package:html/dom.dart' as dom;

// class ScrapVokasi extends StatefulWidget {
//   @override
//   _ScrapVokasiState createState() => _ScrapVokasiState();
// }

// class _ScrapVokasiState extends State<ScrapVokasi> {
//   List<Map<String, String>> articles = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDataVokasi();
//   }

//   Future<void> fetchDataVokasi() async {
//     final response =
//         await http.get(Uri.parse('https://vokasi.unesa.ac.id/archive'));

//     if (response.statusCode == 200) {
//       final document = parser.parse(response.body);
//       final elements = document.querySelectorAll('.blog-carousel .headline');

//       for (final element in elements) {
//         final title = element.querySelector('h2 a')?.text;
//         final link = element.querySelector('h2 a')?.attributes['href'];
//         final date = element.querySelector('.news-text strong')?.text;
//         final imageUrl =
//             element.querySelector('.news-text img')?.attributes['src'];
//         final content = element.querySelector('.news-text p')?.text;

//         if (title != null &&
//             link != null &&
//             date != null &&
//             imageUrl != null &&
//             content != null) {
//           articles.add({
//             'title': title,
//             'link': link,
//             'date': date,
//             'imageUrl': imageUrl,
//             'content': content,
//           });
//           // Print title, link, and imageUrl
//           print('Title: $title');
//           print('Link: $link');
//           print('ImageUrl: $imageUrl');
//         }
//       }

//       setState(() {}); // Update state to trigger UI rebuild
//     } else {
//       print('Failed to load data: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       // Wrap the ListView with SingleChildScrollView
//       child: Column(
//         children: [
//           ListView.builder(
//             shrinkWrap:
//                 true, // Ensure that ListView only occupies the space it needs
//             itemCount: articles.length,
//             itemBuilder: (context, index) {
//               final article = articles[index];
//               return Card(
//                 margin: EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () {
//                     // Handle tap event, for example, open the article in a web view
//                   },
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.network(
//                         article['imageUrl']!,
//                         width: double.infinity,
//                         height: 200,
//                         fit: BoxFit.cover,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               article['title']!,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             SizedBox(height: 8.0),
//                             Text(
//                               article['date']!,
//                               style: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             SizedBox(height: 8.0),
//                             Text(
//                               article['content']!,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
