package ch02;

/**
 * 제네릭이란?<br>
 * 무엇이든 담을 수 있는 제네릭 프로그래밍 -> ver 5.0<br>
 * 
 * 사용하는 이유<br>
 * 우리가 변수를 사용한다고 하면 항상 자료형을 먼저 지정하게 되어있다.<br>
 * 변수의 이름이 같지만 데이터 타입(자료형)이 달라야 한다면<br>
 * 제네릭 프로그래밍을 생각하자.
 */
public class GenericPrinter<T> {

	// T 라는 대체 문자를 사용, E - element, K - key, V - value(사실은 아무 문자나 가능하다)
	// 자료형 매개변수(type parameter)
	// 이 클래스를 사용하는 시점에서 실제 사용될 자료형이 결정된다.

	private T material; // T 대체 문자형으로 변수를 선언

	public T getMaterial() {
		return material;
	}

	public void setMaterial(T material) {
		this.material = material;
	}

	// GenericPrinter<T> -- 참조 변수를 sysout(참조변수) --> 나의 멤버 material의 toString()으로 설계
	@Override
	public String toString() {
		return material.toString();
	}
}
