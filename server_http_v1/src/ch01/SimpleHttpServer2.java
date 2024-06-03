package ch01;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.util.Iterator;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

public class SimpleHttpServer2 {

	public static void main(String[] args) {
		// 8080 <- https, 80 <-- http (포트번호 생략 가능하다)
		try {
			// 포트 번호 8080으로 HTTP 서버 생성
			HttpServer httpServer = HttpServer.create(new InetSocketAddress(8080), 0);

			// 서버에대한 설정

			// 프로토콜 정의(경로, 핸들러 처리)
			// 핸들러 처리를 내부 정적 클래스로 사용
			httpServer.createContext("/test", new MyTestHandler());
			httpServer.createContext("/hello", new HelloHandler());
			// 서버 시작
			httpServer.start();
			System.out.println(">> My Http Server started on port 8080");

		} catch (IOException e) {
			e.printStackTrace();
		}
	} // end of main

	// http://localhost:8080/test <- 주소 설계
	static class MyTestHandler implements HttpHandler {

		@Override
		public void handle(HttpExchange exchange) throws IOException {

			// 사용자의 요청 방식(METHOD), GET, POST 알아야 우리가 동작 시킬 수 있다.
			String method = exchange.getRequestMethod();
			System.out.println("method : " + method);

			if ("GET".equalsIgnoreCase(method)) {
				// GET 요청시 여기서 동작
				// System.out.println("여기는 GET 방식으로 호출됨");

				// path: /test 라고 들어오면 어떤 응답처리를 내려 주면된다.
				handleGetRequest(exchange);
			} else if ("POST".equalsIgnoreCase(method)) {
				// POST 요청시 여기서 동작
				// System.out.println("여기는 POST 방식으로 호출됨");
				handlePostRequest(exchange);
			} else {
				// 지원하지 않는 메서드에 대한 응답
				String response = "Unsupported Method : " + method;
				exchange.sendResponseHeaders(405, response.length()); // Method Not Allowed
				OutputStream os = exchange.getResponseBody();
				os.write(response.getBytes());
				os.flush();
				os.close();
			}

		}

		// GET 요청시 동작 만들기
		private void handleGetRequest(HttpExchange exchange) throws IOException {
			String response = """
					<!DOCTYPE html>
					<html lang=ko>
						<head></head>
						<body>
							<h1 style="background-color:red"> Hello path by /test </h1>
						</body>
					</html>
				""";
			byte[] str = response.getBytes();
			exchange.sendResponseHeaders(200, response.length());
			OutputStream os = exchange.getResponseBody();
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os));
			writer.write(response);
			writer.close();
		}

		// POST 요청시 동작 만들기
		private void handlePostRequest(HttpExchange exchange) throws IOException {
			// POST 요청은 HTTP 메세지에 바디 영역이 존재한다.
			String response = """
						<!DOCTYPE html>
						<html lang=ko>
							<head></head>
							<body>
								<h1 style="background-color:red"> Hello path by /test </h1>
							</body>
						</html>
					""";
			// HTTP 응답 메시지 헤더 설정
			exchange.setAttribute("Content-Type", "text/html; charset=UTF-8");
			exchange.sendResponseHeaders(200, response.length());

			// getResponseBody
			OutputStream os = (exchange.getResponseBody());
			os.write(response.getBytes());
			os.close();
		}

	} // end of MyTestHandler

	static class HelloHandler implements HttpHandler {

		@Override
		public void handle(HttpExchange exchange) throws IOException {
			String method = exchange.getRequestMethod();
			System.out.println(" hello method : " + method);
		}

	}
}
