import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
/*
 * class to write output to file or screen or mySQL database
 */
public class OutputWriter {
	FileWriter fw;
	String filename;

	public OutputWriter(String filename)  {
		this.filename = filename;
	}

	public void writeToFile(HashMap<String, HashMap<String, String>> data) throws IOException {
		fw = new FileWriter(filename);
		fw.write("Name, City, Interest, phone, age, email\n");
		for(HashMap<String,String> p: data.values()) {
			fw.write(p.get("name")+","+p.get("city")+","+p.get("interest")+","
					+p.get("phone")+","+p.get("age")+","+p.get("email")+"\n");
			System.out.println(p.keySet());
			System.out.println(p.values());
		}
		fw.close();
	}
}
