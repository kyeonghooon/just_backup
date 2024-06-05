package ch01;

public class Todo {
	private int userId;
	private int id;
	private String title;
	private boolean completed;
	
	@Override
	public String toString() {
		return "{\n"
				+ "  \"userId\": " + userId + ",\n"
				+ "  \"id\": " + id + ",\n"
				+ "  \"title\": \"" + title + "\",\n"
				+ "  \"completed\"" + completed + "\n"
				+ "}";
	}
}
