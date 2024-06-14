package com.tenco.quiz;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

public class QuizGame {

	// 준비물
	private static final String URL = "jdbc:mysql://localhost:3306/quizdb?serverTimezone=Asia/Seoul";
	private static final String USER = "root";
	private static final String PASSWORD = "asd123";

	public static void main(String[] args) {

		// JDBC 드라이버 로드 <-- 인터페이스 <-- 구현 클래스 필요
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return;
		}

		try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD); //
				Scanner sc = new Scanner(System.in)) {
			while (true) {
				System.out.println();
				System.out.println("---------------------------------------------");
				System.out.println("1. 퀴즈 문제 추가");
				System.out.println("2. 퀴즈 문제 조회");
				System.out.println("3. 퀴즈 게임 시작");
				System.out.println("4. 종료");
				System.out.print("옵션을 선택하세요 : ");

				int choice = sc.nextInt(); // 블로킹
				sc.nextLine(); // 버그 방지용
				switch (choice) {
				case 1:
					// 퀴즈 문제 추가 --> 함수로 만들기
					addQuizQuestion(conn, sc);
					break;
				case 2:
					// 퀴즈 문제 조회 --> 함수로 만들기
					viewQuizQuestion(conn);
					break;
				case 3:
					// 퀴즈 게임 시작 --> 함수로 만들기
					playQuizGame(conn, sc);
					break;
				case 4:
					// 종료
					return;
				default:
					System.out.println("잘못된 선택입니다. 다시 시도하세요");
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	} // end of main

	
	private static void playQuizGame(Connection conn, Scanner sc) {
		// String sql = " select * from quiz order by rand() limit 1";
		String sql = " select * from quiz";
		try (PreparedStatement ptmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE)) {
			ResultSet resultSet = ptmt.executeQuery();
			resultSet.last();
			int last = resultSet.getInt("id");
			List<Integer> correct = new ArrayList<>(last); // 맞춘문제 row를 저장
			while (true) {
				int questionId; // 문제 row
				// 랜덤으로 문제 row를 뽑고 맞춘 문제라면 다시 뽑기
				while(true) {
					questionId = new Random().nextInt(last) + 1;
					if(!correct.contains(questionId)) {
						break;
					}
				}
				resultSet.absolute(questionId);
				System.out.println("퀴즈 문제 : " + resultSet.getString("question"));
				System.out.println("당신의 답 : ");
				String userAnswer = sc.nextLine();
				if(userAnswer.equalsIgnoreCase(resultSet.getString("answer"))) {
					System.out.println("정답입니다.");
					correct.add(questionId);
					if (correct.size() == last) {
						System.out.println("모든 문제를 풀었습니다.");
						return;
					}
				} else if (userAnswer.equals("")){
					System.out.println("퀴즈 게임 종료");
					return;
				} else {
					System.out.println("오답입니다.");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	// 퀴즈를 추가하는 함수 만들기
	public static void addQuizQuestion(Connection conn, Scanner sc) {
		System.out.print("퀴즈 문제를 입력하세요 : ");
		String question = sc.nextLine();
		System.out.print("퀴즈 정답을 입력하세요 : ");
		String answer = sc.nextLine();
		
		String sql = " insert into quiz(question, answer) values (?, ?) ";
		try (PreparedStatement ptmt = conn.prepareStatement(sql)){
			ptmt.setString(1, question);
			ptmt.setString(2, answer);
			int rowsInsertedCount = ptmt.executeUpdate();
			System.out.println("추가된 행의 수 : " + rowsInsertedCount);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	private static void viewQuizQuestion(Connection conn) {
		System.out.println("");
		String sql = " select * from quiz ";
		try (PreparedStatement ptmt = conn.prepareStatement(sql)){
			ResultSet resultSet = ptmt.executeQuery();
			
			while (resultSet.next()) {
				System.out.println("문제 ID : " + resultSet.getInt("id"));
				System.out.println("문제 : " + resultSet.getString("question"));
				System.out.println("정답 : " + resultSet.getString("answer"));
				if (!resultSet.isLast()) {
					System.out.println("---------------------------------------------");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
