package home.stock;

public class StockDTO {
	private int id;
	private int source_id;
	private String company;
	private String warehousing_date;
	private String shelf_life;
	private double amount;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSource_id() {
		return source_id;
	}
	public void setSource_id(int source_id) {
		this.source_id = source_id;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getWarehousing_date() {
		return warehousing_date;
	}
	public void setWarehousing_date(String warehousing_date) {
		this.warehousing_date = warehousing_date;
	}
	public String getShelf_life() {
		return shelf_life;
	}
	public void setShelf_life(String shelf_life) {
		this.shelf_life = shelf_life;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = (double) Math.round(amount * 1000) / 1000;
	}
	
	
}
