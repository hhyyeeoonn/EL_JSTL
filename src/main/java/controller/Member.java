package controller;

public class Member {
	private int age;
	private String id;
	
	public Member() {}
	public Member(int age, String id) {
		this.age = age;
		this.id = id;
	}
	
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
