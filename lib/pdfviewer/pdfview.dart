import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer & Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PDFScreen(),
    );
  }
}
class PDFScreen extends StatefulWidget {
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final String pdfUrl = "https://firebasestorage.googleapis.com/v0/b/fir-d8752.appspot.com/o/DocScanner%201%20Dec%202023%2016-34.pdf?alt=media&token=f953ea0f-5e7b-4205-82a2-901f7fa43397"; // Replace with your PDF URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer & Downloader'),
      ),
      body: SfPdfViewer.network(pdfUrl),
      floatingActionButton: FloatingActionButton(
        onPressed: _downloadPDF,
        child: Icon(Icons.download),
        tooltip: 'Download PDF',
      ),
    );
  }

  Future<void> _downloadPDF() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final Dio dio = Dio();
      try {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/downloaded_pdf.pdf');

        await dio.download(
          pdfUrl,
          file.path,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              print("Downloading: ${((received / total) * 100).toStringAsFixed(0)}%");
              // You might want to use a state management solution to update the UI with the progress.
            }
          },
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded to ${file.path}'),
          ),
        );

        // If needed, you can also implement a way to open the downloaded PDF file.
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download the file: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No permission to write in storage'),
        ),
      );
    }
  }
}