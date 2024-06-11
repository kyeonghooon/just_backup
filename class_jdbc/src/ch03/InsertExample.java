package ch03;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertExample {

	public static void main(String[] args) {
		String url = "jdbc:mysql://localhost:3306/mydb2?serverTimezone=Asia/Seoul";
		String user = "root";
		String password = "asd123";
		
		// Connection 객체를 얻어서 insert 구문을 직접 만들어 보세요.
		// mydb2 사용, employee 테이블에 값을 넣는 코드를 작성하세요
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url, user, password);
			
			String query = "INSERT INTO employee VALUES (?, ?, ?, ?, now())";
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, 8);
			preparedStatement.setString(2, "강감찬");
			preparedStatement.setString(3, "마케팅부");
			preparedStatement.setString(4, "3400000.00");
			
			int rowCount = preparedStatement.executeUpdate();
			System.out.println("rowCount : " + rowCount);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
