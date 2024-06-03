package ex_01;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class MultiThreadServer {
	
	public static void main(String[] args) {
		try (
				// 1. 소켓생성, 포트 번호 결합
				ServerSocket serverSocket = new ServerSocket(7000);
				Socket socket = serverSocket.accept();
				){
			System.out.println("클라이언트와 연결됨");
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
			readThread.start();
			writeThread.start();
			readThread.join();
			writeThread.join();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
