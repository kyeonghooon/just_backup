package ch01;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class Employee {
	private int id;
	private String name;
	private String department;
	private String salary;
	private String hire_date;
}
