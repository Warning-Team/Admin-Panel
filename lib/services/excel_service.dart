import 'dart:io';

import 'package:admin_panel/controllers/cilents_controller.dart';
import 'package:admin_panel/models/request.dart';
import 'package:admin_panel/utils/extentions/datetime_reformat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ExcelService {
  static Future<void> createExcelFile(
      QuerySnapshot<Map<String, dynamic>> requests) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];
      sheetObject.appendRow([
        TextCellValue("id"),
        TextCellValue("description"),
        TextCellValue("stir"),
        TextCellValue("images"),
        TextCellValue("date")
      ]);
      for (var requestQuery in requests.docs) {
        final request = Request.fromQuery(requestQuery);
        String stir = await CilentsController.getClinetStirById(request.cId);

        String images = request.imageUrls.join('\n');
        sheetObject.appendRow(
          [
            TextCellValue(request.id.toString()),
            TextCellValue(request.description),
            TextCellValue(stir),  
            TextCellValue(images),
            TextCellValue(request.date.toFormattedDate()),
          ],
        );
      }
      final directory =  Directory("storage/emulated/0/documents"); //
      if (directory == null) {
        throw Exception('Could not get the external storage directory');
      }
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final path = "${directory.path}/requests_$timestamp.xlsx";
      final file = File(path);
      await file.create(recursive: true);
      await file.writeAsBytes(excel.encode()!);

      // Uncomment if you want to open the file automatically
      // final result = await OpenFile.open(path);
    } catch (e) {
      print('Error creating Excel file: $e');
    }
  }
}
