
import 'package:flutter/material.dart';
/*import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sfiasset/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';*/

class LeavingDocument extends StatefulWidget {
  static String routName = "/Report_leaving_pdf";
  const LeavingDocument({Key? key}) : super(key: key);

  @override
  State<LeavingDocument> createState() => _LeavingDocumentState();
}


class _LeavingDocumentState extends State<LeavingDocument> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Create PDF'),
          onPressed: (){},
        ),
      ),
    );
  }

/*  Future<void>_createPDF()async{
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString('test',
        PdfStandardFont(PdfFontFamily.helvetica, 30));
    List<int> bytes = document.save() as List<int>;
    document.dispose();
    
    saveAndLaunchFile(bytes, 'Output.pdf');
  }*/

  /*Future<void> generatePdf() async {
     //Create the PDF document
    PdfDocument document = PdfDocument();//Add a page
    PdfPage page = document.pages.add();
    //Set the font
     PdfFont font = await getFont(GoogleFonts.mali());
    //Draw a text
    page.graphics.drawString('สวัสดีคับ', font,
     brush: PdfBrushes.black, bounds: Rect.fromLTWH(0, 0, 200, 30));
     //Save the document
     List<int> bytes = document.save() as List<int>;
     //Dispose the document
     document.dispose();

    saveAndLaunchFile(bytes, 'Output.pdf');
    }*/


/*  Future<PdfFont> getFont(TextStyle style) async {
    //Get the external storage directory
    Directory directory = await getApplicationSupportDirectory();
    //Create an empty file to write the font data
    File file = File('${directory.path}/${style.fontFamily}.ttf');
    List<int>? fontBytes;
    //Check if entity with the path exists
    if (file.existsSync()) {
      fontBytes = await file.readAsBytes();
    }
    if (fontBytes != null && fontBytes.isNotEmpty) {
      //Return the google font
      return PdfTrueTypeFont(fontBytes, 12);
    } else {
      //Return the default font
      return PdfStandardFont(PdfFontFamily.helvetica, 12);
    }
  }*/
}


