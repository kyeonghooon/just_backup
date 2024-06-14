package com.tenco.quiz.ver2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tenco.quiz.DBConnectionManger;

public class QuizRespositoryImpl implements QuizRespository{

	public static final String SELCELT_ALL = " select * from quiz ";
	public static final String SELCELT_RANDOM = " select * from quiz order by rand() limit 1 ";
	public static final String INSERT_QUESTION = " insert into quiz(question, answer) values (?, ?) ";
	
	@Override
	public int addQuizQuestion(String question, String answer) throws SQLException {
		
		int resultRowCount = 0;
		
		try (Connection conn = DBConnectionManger.getConnection()){
			PreparedStatement pstmt = conn.prepareStatement(INSERT_QUESTION);
			// 트랜잭션 처리 가능 - 수동모드 커밋 사용 가능
			pstmt.setString(1, question);
			pstmt.setString(2, answer);
			resultRowCount = pstmt.executeUpdate();
		} 
		return resultRowCount;
	}

	@Override
	public List<QuizDTO> viewQuizQuestion() throws SQLException {
		List<QuizDTO> list = new ArrayList<>();
		try (Connection conn = DBConnectionManger.getConnection()){
			PreparedStatement pstmt = conn.prepareStatement(SELCELT_ALL);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(new QuizDTO(rs.getInt("id"), rs.getString("question"), rs.getString("answer")));
			}
		} 
		
		return list;
	}

	@Override
	public QuizDTO playQuizGame() throws SQLException {
		QuizDTO quizDTO = null;
		try (Connection conn = DBConnectionManger.getConnection()){
			PreparedStatement pstmt = conn.prepareStatement(SELCELT_RANDOM);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				quizDTO = new QuizDTO(rs.getInt("id"), rs.getString("question"), rs.getString("answer"));
			}
		}
		return quizDTO;
	}

}
