package home.sold;

public class SoldDTO {
	private int id;
	private int menu_id;
	private int volume;
	private String sold_date;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(int menu_id) {
		this.menu_id = menu_id;
	}
	public int getVolume() {
		return volume;
	}
	public void setVolume(int volume) {
		this.volume = volume;
	}
	public String getSold_date() {
		return sold_date;
	}
	public void setSold_date(String sold_date) {
		this.sold_date = sold_date;
	}
}
