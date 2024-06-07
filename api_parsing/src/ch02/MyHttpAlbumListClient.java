package ch02;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

/**
 * JSON Array 형태를 파싱 해보자.
 */
public class MyHttpAlbumListClient {

	public static void main(String[] args) {
		
		// 순수 자바코드에서 HTTP 통신
		// 1. 서버 주소 경로
		// 2. URL 클래스
		// 3. url.openConnection() <--- 스트림 I/O
		try {
			URL url = new URL("https://jsonplaceholder.typicode.com/albums/");
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("content-type", "application/json");
			
			// 응답 코드 확인
			int responseCode = conn.getResponseCode();
			System.out.println("response code : " + responseCode);
			
			// HTTP 응답 메시지에 데이터를 추출 [] -- Stream -- []
			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			StringBuffer bufferStr = new StringBuffer();
			while ((inputLine = in.readLine()) != null) {
				bufferStr.append(inputLine);
			}
			in.close();
			
			System.out.println(bufferStr.toString());
			System.err.println("---------------------------");
			// gson lib 활용
			// Gson gson = new Gson();
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			// 하나의 JSON Object 형태 파싱
			// Album albumDTO =  gson.fromJson(bufferStr.toString(), Album.class);
			
			// [{...},{...},{...}]
			// Type 이라는 데이터 타입을 활용할 수 있다.
			Type albumType = new TypeToken<List<Album>>(){}.getType();
			List<Album> albumList = gson.fromJson(bufferStr.toString(), albumType);
			System.out.println(albumList.size());
			for (Album album : albumList) {
				System.out.println(album.toString());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	} // end of main

}
