/*
 * An app built for SLS writes to a firebase database
 * This code takes a json file exported from that DB and writes it to a csv
 * so that it can be uploaded to Nation Builder
 */

import org.json.simple.JSONObject;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;
import org.json.simple.parser.JSONParser;
public class Decoder {
	
	public static void main(String[] args) {
		String infile = "/Users/justin/Dropbox/YCP/tech/firebase.json";
		String outfile = "/Users/justin/Dropbox/YCP/tech/firebase.csv";
		JSONParser parser = new JSONParser();
		try {
			Object obj = parser.parse(new FileReader(infile)); // read file
			JSONObject jsonobj = (JSONObject) obj; // convert to json obj
			// convert to something I can handle
			HashMap<String, HashMap<String, String>> map = (HashMap<String, HashMap<String, String>>) jsonobj.get("people");
			System.out.println(map.size());
			OutputWriter ow = new OutputWriter(outfile);
			ow.writeToFile(map);
			
			
		} catch (IOException | ParseException e) {
			e.printStackTrace();
		}
		
	}

}
