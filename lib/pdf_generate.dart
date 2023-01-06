import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'filehandling api.dart';

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = pw.Document();
    final netimage = await networkImage(
        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");

    // final iconImage =
    //     (await rootBundle.load('assets/icon.png')).buffer.asUint8List();

    final tableHeaders = [
      'Description',
      'Quantity',
      'Unit Price',
      'VAT',
      'Total',
    ];

    final tableData = [
      [
        'Coffee',
        '7',
        '\$ 5',
        '1 %',
        '\$ 35',
      ],
      [
        'Blue Berries',
        '5',
        '\$ 10',
        '2 %',
        '\$ 50',
      ],
      [
        'Water',
        '1',
        '\$ 3',
        '1.5 %',
        '\$ 3',
      ],
      [
        'Apple',
        '6',
        '\$ 8',
        '2 %',
        '\$ 48',
      ],
      [
        'Lunch',
        '3',
        '\$ 90',
        '12 %',
        '\$ 270',
      ],
      [
        'Drinks',
        '2',
        '\$ 15',
        '0.5 %',
        '\$ 30',
      ],
      [
        'Lemon',
        '4',
        '\$ 7',
        '0.5 %',
        '\$ 28',
      ],
    ];

    pdf.addPage(pw.MultiPage(
      // header: (context) {
      //   return pw.Text(
      //     'Flutter Approach',
      //     style: pw.TextStyle(
      //       fontWeight: pw.FontWeight.bold,
      //       fontSize: 15.0,
      //     ),
      //   );
      // },
      build: (context) {
        return [
          pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.max,
              children: [
                pw.Flexible(
                  flex: 2,
                  child: pw.Column(children: [
                    pw.Container(
                        width: 200,
                        color: PdfColors.blue,
                        height: 500,
                        child: pw.Column(children: [
                          pw.SizedBox(height: 10 * PdfPageFormat.mm),
                          pw.Image(
                            netimage,
                            height: 72,
                            width: 72,
                          ),
                        ]))
                  ]),
                ),
                pw.SizedBox(width: 10 * PdfPageFormat.mm),
                pw.Flexible(
                  flex: 4,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        // pw.Row(
                        //   children: [
                        pw.SizedBox(width: 1 * PdfPageFormat.mm),
                        pw.SizedBox(width: 1 * PdfPageFormat.mm),
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          mainAxisSize: pw.MainAxisSize.min,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'ABOUT ME',
                              style: pw.TextStyle(
                                fontSize: 17.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              'am a flutter developer based on banglore. Solving problems is what I always get excited at. Coding really satisfies my wish. This is why I became determined to becoming a software engineer at a young age itself.',
                            ),
                            pw.SizedBox(height: 10 * PdfPageFormat.mm),
                            pw.Text(
                              'SKILLS',
                              style: pw.TextStyle(
                                fontSize: 17.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              'am a flutter developer based on banglore. Solving problems is what I always get excited at. Coding really satisfies my wish. This is why I became determined to becoming a software engineer at a young age itself.',
                            ),
                          ],
                        ),
                        // pw.Column(
                        //   mainAxisSize: pw.MainAxisSize.min,
                        //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                        //   children: [
                        //     pw.Text(
                        //       'John Doe',
                        //       style: pw.TextStyle(
                        //         fontSize: 15.5,
                        //         fontWeight: pw.FontWeight.bold,
                        //       ),
                        //     ),
                        //     pw.Text(
                        //       'john@gmail.com',
                        //     ),
                        //     pw.Text(
                        //       DateTime.now().toString(),
                        //     ),
                        //   ],
                        // ),
                        //   ],
                        // ),
                        pw.SizedBox(height: 1 * PdfPageFormat.mm),
                        pw.SizedBox(height: 1 * PdfPageFormat.mm),
                        pw.Text(
                          'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
                          textAlign: pw.TextAlign.justify,
                        ),
                        pw.SizedBox(height: 5 * PdfPageFormat.mm),
                      ]),
                ),
              ]),
          pw.SizedBox(height: 10 * PdfPageFormat.mm),

          ///
          /// PDF Table Create
          ///
          ///
          //

          pw.Table.fromTextArray(
          
            headers: tableHeaders,
            data: tableData,
            border: pw.TableBorder.all(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellHeight: 30.0,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
              4: pw.Alignment.centerRight,
            },
          ),
          pw.Divider(),
        ];
      },
    ));

    return FileHandleApi.saveDocument(name: 'resume.pdf', pdf: pdf)
        .then((value) async => await FileHandleApi.openFile(value));
  }
}
