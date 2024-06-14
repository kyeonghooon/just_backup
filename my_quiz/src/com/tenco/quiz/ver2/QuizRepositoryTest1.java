package com.tenco.quiz.ver2;

import java.util.HashSet;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

public class QuizRepositoryTest1 {
	static final int ADD_QUESTION = 1;
	static final int VIEW_QUESTION = 2;
	static final int PLAY_GAME = 3;
	static final int END = 0;
	static int size = 0;
	static Set<Integer> correct = new HashSet<>();
	static boolean check = false;
	
	public static void main(String[] args) {
		
		
		// 실행의 흐름은 직접 만들기
		try (Scanner sc = new Scanner(System.in)){
			QuizRespositoryImpl quizImpl = new QuizRespositoryImpl();
			while (true) {
				System.out.println();
				printMenu();
				int choice = sc.nextInt();
				sc.nextLine();
				switch (choice){
				case ADD_QUESTION :
					System.out.print("문제를 입력하세요. : ");
					String question = sc.nextLine();
					System.out.print("정답을 입력하세요. : ");
					String answer = sc.nextLine();
					quizImpl.addQuizQuestion(question, answer);
					break;
				case VIEW_QUESTION :
					printQuiz(quizImpl.viewQuizQuestion());
					check = true;
					break;
				case PLAY_GAME : 
					if (size == 0) {
						System.out.println("문제 조회를 먼저 해야합니다.");
						break;
					} else if (size == correct.size()) {
						System.out.println("모든 문제를 풀었습니다.");
						break;
					}
					QuizDTO quizDTO;
					do {
						quizDTO = quizImpl.playQuizGame();
					} while (correct.contains(quizDTO.getId()));
					playQuiz(quizDTO, sc);
					break;
				case END :
					return;
				}
			}
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	private static void printMenu() {
		System.out.println("---------------------------------------------");
		System.out.println("1. 퀴즈 문제 추가");
		System.out.println("2. 퀴즈 문제 조회");
		System.out.println("3. 퀴즈 게임 시작");
		System.out.println("0. 종료");
		System.out.print("옵션을 선택하세요 : ");
	}
	private static void printQuiz(List<QuizDTO> list) {
		size = list.size();
		for (QuizDTO quizDTO : list) {
			System.out.println(quizDTO);
		}
	}
	private static void playQuiz(QuizDTO quiz, Scanner sc) {
		System.out.println("문제 : " + quiz.getQuestion());
		System.out.print("정답을 입력하세요 : ");
		String answer = sc.nextLine();
		if (quiz.getAnswer().equalsIgnoreCase(answer)) {
			System.out.println("정답입니다.");
			correct.add(quiz.getId());
		} else {
			System.out.println("오답입니다.");
		}
	}

}
