package home.menu;

import java.util.ArrayList;

public class MenuDTO {
	private int id;
	private String name;
	private int price;
	private ArrayList<String[]> consumption;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public ArrayList<String[]> getConsumption() {
		return consumption;
	}
	public void setConsumption(ArrayList<String[]> consumption) {
		this.consumption = consumption;
	}
}