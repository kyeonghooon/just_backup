package ex_01;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class MultiThreadClient {

	public static void main(String[] args) {
		try (Socket socket = new Socket("192.168.0.129", 7000)) {
			System.out.println("서버에 접속됨");
			Thread writeThread = new Thread(() -> {
				try {
					PrintWriter socketWriter = new PrintWriter(socket.getOutputStream(), true);
					BufferedReader keyboardReader = new BufferedReader(new InputStreamReader(System.in));
					String msg;
					while((msg = keyboardReader.readLine()) != null) {
						socketWriter.println(msg);
						socketWriter.flush();
					} 
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
			Thread readThread = new Thread(() -> {
				try {
					BufferedReader socketReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
					String msg;
					while((msg = socketReader.readLine()) != null) {
						System.out.println("클라이언트 : " + msg);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
			readThread.start();
			writeThread.start();
			readThread.join();
			writeThread.join();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
