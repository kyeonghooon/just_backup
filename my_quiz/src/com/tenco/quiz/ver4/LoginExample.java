package com.tenco.quiz.ver4;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginExample {

	// 개발 테스트를 위한 로깅 처리 및 로그
	private static final Logger LOGGER = Logger.getLogger(LoginExample.class.getName()); // com.tenco.quiz.ver4.LoginExample

	public static void main(String[] args) {
		// DataSource를 활용한 Connection 객체를 사용하자.
		
		try (
				// HikariCP가 담김
				Connection conn = DBConnectionManger.getConnection();
				// username, password를 받아서 확인해야 한다.
				Scanner sc = new Scanner(System.in)){
			
			System.out.print("username을 입력하세요 : ");
			String username = sc.nextLine();
			
			System.out.print("password를 입력하세요 : ");
			String password = sc.nextLine();
			int check = authenticateUser(conn, username, password);
			if( check == 2) {
				System.out.println("로그인 성공 ! ");
			} else if ( check == 1){
				System.out.println("로그인 실패 - password가 틀렸습니다. 확인해주세요");
			} else {
				System.out.println("로그인 실패 - 존재하지 않는 username입니다.");
			}
			
		} catch (SQLException e) {
			LOGGER.log(Level.INFO, "MySQL 연결 오류");
			e.printStackTrace();
		}
	}

	private static int authenticateUser(Connection conn, String username, String password) {
		String query1 = " select * from users where username = ? ";
		String query2 = " select * from users where username = ? and password = ? ";
		int result = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query1);
			pstmt.setString(1, username);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			}
			pstmt = conn.prepareStatement(query2);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			if (rs.next()) {
				result = 2;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

} // end of class
