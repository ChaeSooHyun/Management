package home.menu;

import java.sql.*;
import java.util.*;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class MenuDAO {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	ResultSet rs2;
	String url, user, pass;
	
	private String searchColumn, searchValue;
	
	public String getSearchColumn() {
		return searchColumn;
	}

	public void setSearchColumn(String searchColumn) {
		this.searchColumn = searchColumn;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public MenuDAO() {
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			url = "jdbc:mariadb://localhost:3306/bigbot";
			user = "bigbot";
			pass = "qlrqht88588588**";
			con = DriverManager.getConnection(url, user, pass);
		} catch (Exception e) {
			System.out.println("에러 발생");
			if(rs!=null)try {rs.close();} catch (Exception e2) {}
			if(ps!=null)try {ps.close();} catch (Exception e2) {}
			if(con!=null)try {con.close();} catch (Exception e2) {}
		}
	}
	
	public int createMenu(MenuDTO dto) throws SQLException {
		int res = 0;
		String sql = "insert into T_Menu (name, price, consumption) values (?, ?, ?)";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setInt(2, dto.getPrice());
			ps.setString(3, consumptionToJson(dto.getConsumption()));
			res = ps.executeUpdate();
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<MenuDTO> readMenu() throws SQLException {
		String sql = "select * from T_Menu order by id";
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			return makeArrayList(rs);
		} finally {
			if (rs != null) rs.close();
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<MenuDTO> searchMenu() throws SQLException {
		String sql = "select * from T_Menu where " + searchColumn;
		
		try {
			if (searchColumn.equals("id") || searchColumn.equals("price")) {
				sql += " = ? order by id";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(searchValue));				
			} else {
				sql += " like ? order by id";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%" + searchValue + "%");
			}
			rs = ps.executeQuery();
			
			return makeArrayList(rs);
		} finally {
			if (rs != null) rs.close();
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public int updateMenu(MenuDTO dto) throws SQLException {
		int res = 0;
		String sql = "update T_Menu set name = ?, price = ?, consumption = ? where id = ?";
		System.out.println(dto.getName() +  dto.getPrice() + consumptionToJson(dto.getConsumption()));
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setInt(2, dto.getPrice());
			ps.setString(3, consumptionToJson(dto.getConsumption()));
			ps.setInt(4, dto.getId());
			res = ps.executeUpdate();
			
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public int deleteMenu(int id) throws SQLException {
		int res = 0;
		String sql = "delete from T_Menu where id = ?";
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			res = ps.executeUpdate();
			
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<MenuDTO> makeArrayList(ResultSet rs) throws SQLException {
		ArrayList<MenuDTO> listMenu = new ArrayList<MenuDTO>();
		
		while (rs.next()) {
			MenuDTO dto = new MenuDTO();
			
			dto.setId(rs.getInt("id"));
			dto.setName(rs.getString("name"));
			dto.setPrice(rs.getInt("price"));
			dto.setConsumption(jsonToConsumption(rs.getString("consumption")));
			
			listMenu.add(dto);
		}
		return listMenu;
	}
	
	public String consumptionToJson(ArrayList<String[]> consumption) {
		String json = "{ \"use\" : [ ";
		
		for(String[] use : consumption) {
			json += "{ \"source_id\" : " + Integer.parseInt(use[0]);
			json += ", \"amount\" : " + Double.parseDouble(use[1]) + " }, ";
		}
		
		return json.substring(0, json.length() - 2) + " ] }";
	}
	
	public ArrayList<String[]> jsonToConsumption(String json) {
		ArrayList<String[]> consumption = new ArrayList<String[]>(); 
		try {
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObj = (JSONObject) jsonParser.parse(json);
            JSONArray useArray = (JSONArray) jsonObj.get("use");

            for(int i=0 ; i<useArray.size() ; i++){
                JSONObject tempObj = (JSONObject) useArray.get(i);
                String source_id =  Long.toString((long)tempObj.get("source_id"));
                Double amount_D =  (double) Math.round((double) tempObj.get("amount") * 1000) / 1000;
                String amount_S = Double.toString(amount_D);
                String[] tempArr = {source_id, amount_S};
                consumption.add(tempArr);
            }
        } catch (ParseException e) {	
        	
        }
		
		return consumption;
	}
}
