import 'dart:io';
import 'package:flutter_provider_straterkit/configs/utils/amount_formatter/amount_formatter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

/// Dynamic PDF receipt generator that accepts parameters
class ReceiptPdfGenerator {
  /// Generate a simple receipt PDF with dynamic data
  static Future<File?> generateSimpleReceipt({
    required String orderId,
    required String customerName,
    required String customerPhone,
    required String retailerName,
    required String retailerAddress,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double vat,
    required double deliveryCharge,
    required double serviceFee,
    required double totalAmount,
    String? deliveryPersonName,
    String? deliveryPersonPhone,
    String? paymentMethod,
    double? customerTip,
  }) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32),
          build: (context) => [
            _buildHeader(),
            pw.SizedBox(height: 20),
            _buildOrderInfo(orderId),
            pw.SizedBox(height: 20),
            _buildCustomerInfo(customerName, customerPhone),
            pw.SizedBox(height: 20),
            _buildRetailerInfo(retailerName, retailerAddress),
            pw.SizedBox(height: 20),
            _buildDeliveryInfo(
              deliveryPersonName: deliveryPersonName,
              deliveryPersonPhone: deliveryPersonPhone,
              paymentMethod: paymentMethod,
            ),
            pw.SizedBox(height: 20),
            _buildItemsTable(items),
            pw.SizedBox(height: 20),
            _buildPriceSummary(
              subtotal: subtotal,
              vat: vat,
              deliveryCharge: deliveryCharge,
              serviceFee: serviceFee,
              totalAmount: totalAmount,
              customerTip: customerTip,
            ),
            pw.SizedBox(height: 30),
            _buildFooter(),
          ],
        ),
      );

      // Save PDF to device
      final output = await _savePdf(pdf, orderId);
      return output;
    } catch (e) {
      print('PDF Generation Error: $e');
      return null;
    }
  }

  // Basic header
  static pw.Widget _buildHeader() {
    return pw.Container(
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#00424D'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'FLUTTER BOOKING',
            style: pw.TextStyle(
              fontSize: 32,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Delivery Receipt',
            style: pw.TextStyle(fontSize: 16, color: PdfColors.white),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildOrderInfo(String orderId) {
    final displayId = orderId.length > 6
        ? orderId.substring(orderId.length - 6)
        : orderId;
    final currentDate = DateFormat(
      'MMM dd, yyyy hh:mm a',
    ).format(DateTime.now());

    return pw.Container(
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Order ID',
                style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                '#$displayId',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Order Date',
                style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                currentDate,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildCustomerInfo(String name, String phone) {
    return pw.Container(
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#F5F5F5'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Customer Information',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Divider(),
          pw.SizedBox(height: 8),
          _buildInfoRow('Name', name),
          pw.SizedBox(height: 6),
          _buildInfoRow('Phone', phone),
        ],
      ),
    );
  }

  static pw.Widget _buildRetailerInfo(String name, String address) {
    return pw.Container(
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#F5F5F5'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Retailer Information',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Divider(),
          pw.SizedBox(height: 8),
          _buildInfoRow('Business Name', name),
          pw.SizedBox(height: 6),
          _buildInfoRow('Address', address),
        ],
      ),
    );
  }

  static pw.Widget _buildDeliveryInfo({
    String? deliveryPersonName,
    String? deliveryPersonPhone,
    String? paymentMethod,
  }) {
    return pw.Container(
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#E8F5E9'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Delivery Information',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#2E7D32'),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Divider(),
          pw.SizedBox(height: 8),
          if (deliveryPersonName != null && deliveryPersonName.isNotEmpty) ...[
            _buildInfoRow('Delivery Person', deliveryPersonName),
            pw.SizedBox(height: 6),
          ],
          if (deliveryPersonPhone != null &&
              deliveryPersonPhone.isNotEmpty) ...[
            _buildInfoRow('Phone', deliveryPersonPhone),
            pw.SizedBox(height: 6),
          ],
          if (paymentMethod != null && paymentMethod.isNotEmpty) ...[
            _buildInfoRow('Payment Type', paymentMethod),
            pw.SizedBox(height: 6),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildItemsTable(List<Map<String, dynamic>> items) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Order Items',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            // Header
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColor.fromHex('#00424D')),
              children: [
                _buildTableHeader('Item'),
                _buildTableHeader('Quantity'),
                _buildTableHeader('Unit Price'),
                _buildTableHeader('Total'),
              ],
            ),
            // Items
            ...items.map((item) {
              final name = item['name']?.toString() ?? 'N/A';
              final quantity = item['quantity']?.toString() ?? '0';
              final unitPrice = item['unitPrice'] ?? 0;
              final total = item['total'] ?? 0;
              final unit = item['unit']?.toString() ?? '';

              return pw.TableRow(
                children: [
                  _buildTableCell(name),
                  _buildTableCell('$quantity $unit'),
                  _buildTableCell(
                    'tk ${AmountFormatter.formatDynamic(unitPrice)}',
                  ),
                  _buildTableCell('tk ${AmountFormatter.formatDynamic(total)}'),
                ],
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildPriceSummary({
    required double subtotal,
    required double vat,
    required double deliveryCharge,
    required double serviceFee,
    required double totalAmount,
    double? customerTip,
  }) {
    return pw.Container(
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300, width: 2),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          _buildPriceRow('Subtotal', subtotal),
          pw.SizedBox(height: 8),
          _buildPriceRow('VAT', vat),
          pw.SizedBox(height: 8),
          _buildPriceRow('Service Fee', serviceFee),
          pw.SizedBox(height: 8),
          _buildPriceRow('Delivery Charge', deliveryCharge),
          pw.SizedBox(height: 8),
          if (customerTip != null && customerTip > 0) ...[
            _buildPriceRow('Customer Tip', customerTip),
            pw.SizedBox(height: 8),
          ],
          pw.Divider(thickness: 2),
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Total Amount',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'tk ${AmountFormatter.formatDynamic(totalAmount)}',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#1E88E5'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter() {
    return pw.Container(
      padding: pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#F5F5F5'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'Thank you for using Flutter Booking!',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'For support, contact us at support@flutterbooking.com',
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Generated on: ${DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.now())}',
            style: pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Helper Methods
  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Text(
            '$label:',
            style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
          ),
        ),
        pw.Expanded(
          flex: 3,
          child: pw.Text(
            value,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTableHeader(String text) {
    return pw.Container(
      padding: pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildTableCell(String text) {
    return pw.Container(
      padding: pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontSize: 10),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  static pw.Widget _buildPriceRow(String label, num amount) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.Text(
          'tk ${AmountFormatter.formatDynamic(amount)}',
          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  static Future<File> _savePdf(pw.Document pdf, String orderId) async {
    try {
      Directory? baseDirectory;

      if (Platform.isAndroid) {
        baseDirectory = Directory('/storage/emulated/0/Download');

        if (!await baseDirectory.exists()) {
          try {
            await baseDirectory.create(recursive: true);
          } catch (e) {
            baseDirectory = await getExternalStorageDirectory();
          }
        }
      } else if (Platform.isIOS) {
        baseDirectory = await getApplicationDocumentsDirectory();
      }

      if (baseDirectory == null) {
        throw Exception('Could not access storage directory');
      }

      // Create "Flutter Booking" subfolder if it doesn't exist
      final Directory bookingFolder = Directory(
        '${baseDirectory.path}/Flutter Booking',
      );
      if (!await bookingFolder.exists()) {
        await bookingFolder.create(recursive: true);
      }

      final String timestamp = DateFormat(
        'yyyyMMdd_HHmmss',
      ).format(DateTime.now());
      final String fileName = 'Grocery_order_${orderId}_$timestamp.pdf';
      final String filePath = '${bookingFolder.path}/$fileName';

      final File file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      return file;
    } catch (e) {
      rethrow;
    }
  }
}
