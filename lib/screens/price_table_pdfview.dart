// lib/screens/pdf_viewer_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  late WebViewController _webViewController;
  bool isLoading = true;
  bool isDownloading = false;

  // Sample PDF content (HTML)
  final String samplePdfContent = '''
  <!DOCTYPE html>
  <html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: 'Segoe UI', Arial, sans-serif;
        padding: 20px;
        margin: 0;
        background: #f5f5f5;
      }
      .container {
        max-width: 800px;
        margin: 0 auto;
        background: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        overflow: hidden;
      }
      .header {
        background: linear-gradient(135deg, #4CAF50, #45a049);
        padding: 30px;
        text-align: center;
        color: white;
      }
      .title {
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 10px;
      }
      .subtitle {
        font-size: 14px;
        opacity: 0.9;
      }
      .content {
        padding: 20px;
      }
      .details {
        background: #f9f9f9;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
      }
      .row {
        display: flex;
        justify-content: space-between;
        padding: 10px 0;
        border-bottom: 1px solid #e0e0e0;
      }
      .row:last-child {
        border-bottom: none;
      }
      .row-highlight {
        background: #e8f5e9;
        margin-top: 10px;
        padding: 12px;
        border-radius: 8px;
        border-bottom: none;
      }
      .label {
        color: #666;
        font-size: 14px;
      }
      .value {
        font-weight: 600;
        color: #333;
        font-size: 14px;
      }
      .value-highlight {
        color: #4CAF50;
        font-size: 18px;
        font-weight: bold;
      }
      .table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }
      .table th {
        background: #4CAF50;
        color: white;
        padding: 10px;
        font-size: 12px;
        text-align: center;
      }
      .table td {
        padding: 8px;
        text-align: center;
        border-bottom: 1px solid #e0e0e0;
        font-size: 12px;
      }
      .footer {
        background: #f5f5f5;
        padding: 20px;
        text-align: center;
        color: #999;
        font-size: 12px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <div class="title">Solar Energy Solutions</div>
        <div class="subtitle">Quotation Summary</div>
        <div class="subtitle">${DateTime.now().toString().split(' ')[0]}</div>
      </div>
      
      <div class="content">
        <div class="details">
          <div class="row">
            <span class="label">Customer Name:</span>
            <span class="value">Rahul Sharma</span>
          </div>
          <div class="row">
            <span class="label">Mobile Number:</span>
            <span class="value">+91 98765 43210</span>
          </div>
          <div class="row">
            <span class="label">Email ID:</span>
            <span class="value">rahul.sharma@example.com</span>
          </div>
          <div class="row">
            <span class="label">Address:</span>
            <span class="value">Mumbai, Maharashtra</span>
          </div>
        </div>
        
        <div class="details">
          <div class="row">
            <span class="label">Combo Kit:</span>
            <span class="value">Premium Solar Kit</span>
          </div>
          <div class="row">
            <span class="label">System Size:</span>
            <span class="value">5 KW</span>
          </div>
          <div class="row">
            <span class="label">No. of Panels:</span>
            <span class="value">15 Panels</span>
          </div>
          <div class="row">
            <span class="label">Panel Watt:</span>
            <span class="value">540 WP</span>
          </div>
          <div class="row">
            <span class="label">Inverter Brand:</span>
            <span class="value">Growatt</span>
          </div>
        </div>
        
        <table class="table">
          <thead>
            <tr>
              <th>System Size (KW)</th>
              <th>No. of Panels</th>
              <th>Sub Total (₹)</th>
              <th>Subsidy (₹)</th>
              <th>Total (₹)</th>
            </tr>
          </thead>
          <tbody>
            <tr><td>1 KW</td><td>3</td><td>65,000</td><td>5,000</td><td>60,000</td></tr>
            <tr><td>2 KW</td><td>6</td><td>1,30,000</td><td>10,000</td><td>1,20,000</td></tr>
            <tr><td>3 KW</td><td>9</td><td>1,95,000</td><td>15,000</td><td>1,80,000</td></tr>
            <tr><td>4 KW</td><td>12</td><td>2,60,000</td><td>20,000</td><td>2,40,000</td></tr>
            <tr style="background: #e8f5e9;"><td><b>5 KW</b></td><td><b>15</b></td><td><b>3,25,000</b></td><td><b>25,000</b></td><td><b>3,00,000</b></td></tr>
          </tbody>
        </table>
        
        <div class="details" style="margin-top: 20px;">
          <div class="row">
            <span class="label">Sub Total:</span>
            <span class="value">₹3,25,000</span>
          </div>
          <div class="row">
            <span class="label">GST (12%):</span>
            <span class="value">₹39,000</span>
          </div>
          <div class="row">
            <span class="label">Margin:</span>
            <span class="value">₹10,000</span>
          </div>
          <div class="row">
            <span class="label">Subsidy:</span>
            <span class="value">₹25,000</span>
          </div>
          <div class="row row-highlight">
            <span class="label" style="font-weight: bold;">Final Amount:</span>
            <span class="value-highlight">₹3,49,000</span>
          </div>
        </div>
      </div>
      
      <div class="footer">
        <p>Thank you for choosing Solar Energy Solutions!</p>
        <p>For any queries, please contact: support@solar.com | +91 1800 123 4567</p>
        <p style="margin-top: 10px;">This is a system generated quotation, no signature required.</p>
      </div>
    </div>
  </body>
  </html>
  ''';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('data:text/html;charset=utf-8,${Uri.encodeComponent(samplePdfContent)}'));
  }

  Future<void> _downloadAndShare() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        isDownloading = true;
      });

      try {
        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/Solar_Quotation_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File(filePath);

        // Convert HTML to bytes
        await file.writeAsBytes(samplePdfContent.codeUnits);

        await Share.shareXFiles(
          [XFile(filePath)],
          text: 'Check out this Solar Quotation',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF shared successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        setState(() {
          isDownloading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission denied'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _downloadOnly() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
        isDownloading = true;
      });

      try {
        final directory = await getDownloadsDirectory();
        if (directory != null) {
          final filePath = '${directory.path}/Solar_Quotation_${DateTime.now().millisecondsSinceEpoch}.pdf';
          final file = File(filePath);

          await file.writeAsBytes(samplePdfContent.codeUnits);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('PDF downloaded to Downloads folder'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        setState(() {
          isDownloading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission denied'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'PDF Viewer',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [

        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),
          if (isLoading)
            Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
          if (isDownloading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Processing PDF...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _downloadOnly,
                    icon: const Icon(Icons.download, size: 20),
                    label: const Text('Download'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _downloadAndShare,
                    icon: const Icon(Icons.share, size: 20),
                    label: const Text('Share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}