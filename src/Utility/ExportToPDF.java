package utility;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class ExportToPDF {
	
	public boolean export(){
		
		Document pdfDoc = new Document();
		
		try {
			
			PdfWriter.getInstance(pdfDoc, 
					new FileOutputStream("C:\\Users\\IT_OJT\\Desktop\\Abalos\\Documents\\CWS Project Files\\test.pdf"));
			
			pdfDoc.open();
			pdfDoc.add(new Paragraph("Hello World"));
			pdfDoc.close();
			
		} catch (DocumentException de) {
			System.out.println("DocumentException IN ExportToPDF - export");
			de.printStackTrace();
		
		} catch (FileNotFoundException fnfe) {
			System.out.println("FileNotFoundException IN ExportToPDF - export");
			fnfe.printStackTrace();
		}
		
		
		return true;
	}

}
