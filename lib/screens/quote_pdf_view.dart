import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:public_file_saver/public_file_saver.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../appColors.dart';

class QuoteViewScreen extends StatefulWidget {
  final String webUrl;
  final String pdfUrl;
  final String quoteNumber;

  const QuoteViewScreen({
    super.key,
    required this.webUrl,
    required this.pdfUrl,
    required this.quoteNumber,
  });

  @override
  State<QuoteViewScreen> createState() => _QuoteViewScreenState();
}

class _QuoteViewScreenState extends State<QuoteViewScreen> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => _isLoading = true),
          onPageFinished: (url) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.webUrl));
  }


  Future<void> _downloadPDF() async {
    // 1. Request storage permission for Android (only once)
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission required to download PDF')),
        );
        return;
      }
    }

    // 2. Determine the save directory
    Directory saveDir;
    if (Platform.isAndroid) {
      // Android: use the external public Downloads directory
      saveDir = Directory('/storage/emulated/0/Download');
      if (!await saveDir.exists()) {
        // Fallback for some devices
        saveDir = await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory();
      }
    } else {
      // iOS: use app's documents folder (no public Downloads)
      saveDir = await getApplicationDocumentsDirectory();
    }

    final fileName = 'Quote_${widget.quoteNumber.replaceAll('#', '')}.pdf';
    final savePath = '${saveDir.path}/$fileName';

    // 3. Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Downloading Pdf...'),
          ],
        ),
      ),
    );

    try {
      // 4. Download the PDF using Dio
      await Dio().download(widget.pdfUrl, savePath);

      // 5. Dismiss dialog
      if (mounted) Navigator.pop(context);

      // 6. Open the downloaded file
      final result = await OpenFile.open(savePath);
      if (result.type != ResultType.done) {
        throw Exception('Could not open PDF');
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }

  Future<void> _sharePDF() async {
    try {
      Dio dio = Dio();
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      String fileName = 'Quote_${widget.quoteNumber.replaceAll('#', '')}.pdf';
      String savePath = '${directory!.path}/$fileName';

      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      await dio.download(widget.pdfUrl, savePath);
      if (mounted) Navigator.pop(context);

      await Share.shareXFiles([XFile(savePath)], text: 'Solar Quote ${widget.quoteNumber}');
    } catch (e) {
      if (mounted) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Share failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote Pdf'),
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 50),
            child: Container(
              color: Colors.white.withOpacity(0.1), // semi-transparent overlay
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, -2)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _sharePDF,
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _downloadPDF,
                icon: const Icon(Icons.download),
                label: const Text('Download'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryBlue,
                  side: BorderSide(color: AppColors.primaryBlue),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}