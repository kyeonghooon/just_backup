package ch01;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Dog {
	private String name;
	private int age;
	private String breed;
	
	@Override
	public String toString() {
		return "{\n"
				+ "  \"name\": \"" + name + "\",\n"
				+ "  \"age\": " + age + ",\n"
				+ "  \"breed\": \"" + breed + "\"\n"
				+ "}";
	}
}
