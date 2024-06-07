package ch02;

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
	
	@ToString
	public class Address {
		private String street;
		private String suite;
		private String city;
		private String zipcode;
		private Geo geo;
		
		@ToString
		public class Geo {
			private String lat;
			private String Ing;
		}
	}
	
	@ToString
	public class Company {
		private String name;
		private String catchPhrase;
		private String bs;
	}
}
