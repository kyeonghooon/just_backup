package ch01;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class DogJson {

	public static void main(String[] args) {
		Dog dog1 = new Dog("코코", 3, "닥스훈트");
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String dog1Str = gson.toJson(dog1);
		System.out.println(dog1Str);
		
		Dog dogObject = gson.fromJson(dog1Str, Dog.class);
		System.out.println("----------------------------");
		System.out.println(dogObject);
	}

}
