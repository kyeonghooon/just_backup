package http;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class HttpGetClient2 {

	public static void main(String[] args) {
		
		// 자바 기본 코드로 HTTP 요청을 만들어 보자
		
		// HTTP 통신 하기 위한 준비물
		// 서버 주소(경로준비)
		String urlString = "http://localhost:8080/test";
		
		// 1. URL 클래스를 만들어 준다.
		// 2. Connection 객체를 만들어 준다. (URL --> 멤버로 Connection 객체를 뽑을 수 있다.)
		try {
			URL url = new URL(urlString);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			BufferedReader buIn = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			while ((inputLine = buIn.readLine()) != null) {
				System.out.println(inputLine);
			}
			buIn.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
