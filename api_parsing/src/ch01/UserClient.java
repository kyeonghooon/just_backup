package ch01;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class UserClient {

	public static void main(String[] args) throws IOException{
		String urlString = "https://jsonplaceholder.typicode.com/users";
		
		URL url = new URL(urlString);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		int responseCode = conn.getResponseCode();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String inputLine;
		StringBuilder userJson = new StringBuilder();
		while((inputLine = br.readLine()) != null) {
			userJson.append(inputLine + "\n");
		}
		br.close();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		User[] users = gson.fromJson(userJson.toString(), User[].class);
		System.out.println("HTTP CODE : " + responseCode);
		System.out.println(gson.toJson(users));
	}

}
