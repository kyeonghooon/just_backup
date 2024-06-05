package ch01;

import lombok.ToString;

@ToString
public class Address {
	private String street;
	private String suite;
	private String city;
	private String zipcode;
	private Geo geo;
}
