package ch01;

import lombok.ToString;

@ToString
public class User {
	private int id;
	private String name;
	private String username;
	private String email;
	private String phone;
	private String website;
	private Address address;
	private Company company;
}
