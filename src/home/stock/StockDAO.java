package home.stock;

import java.sql.*;
import java.util.*;

public class StockDAO {
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
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

	public StockDAO() {
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
	
	public int createStock(StockDTO dto) throws SQLException {
		int res = 0;
		String sql = "insert into T_Stock (source_id, company, warehousing_date, shelf_life, amount) values (?, ?, ?, ?, ?)";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, dto.getSource_id());
			ps.setString(2, dto.getCompany());
			ps.setString(3, dto.getWarehousing_date());
			ps.setString(4, dto.getShelf_life());
			ps.setDouble(5, dto.getAmount());
			res = ps.executeUpdate();
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<StockDTO> readStock() throws SQLException {
		String sql = "select * from T_Stock order by id";
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
	
	public ArrayList<StockDTO> searchStock() throws SQLException {
		try {
			String sql = "";
			ArrayList<Integer> searchValueArr = new ArrayList<Integer>();
			if(searchColumn.equals("source_id")) {
				sql = "select id from T_Source where name like ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, "%" + searchValue + "%");				
				rs = ps.executeQuery();
				while(rs.next()) {
					searchValueArr.add(rs.getInt("id"));
				}
			}
			
			sql = "select * from T_Stock where " + searchColumn;
			
			if (searchColumn.equals("warehousing_date") || searchColumn.equals("shelf_life")) {
				sql += " >= ? order by " + searchColumn;
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(searchValue.replace("-", "")));
			} else if (searchColumn.equals("id")) {
				sql += " = ? order by id";
				ps = con.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(searchValue));				
			} else if (searchColumn.equals("source_id")) {
				sql += " = ?";
				sql += new String(new char[searchValueArr.size() - 1]).replace("\0", " or source_id = ?");
				sql += " order by id";
				ps = con.prepareStatement(sql);
				for(int i = 1 ; i <= searchValueArr.size() ; i++) {
					ps.setInt(i, searchValueArr.get(i - 1));									
				}
			} else {
				sql += " like ?";
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
	
	public int updateStock(StockDTO dto) throws SQLException {
		try {
			String sql = "update T_Stock set source_id = ?, company = ?, warehousing_date = ?, "
					+ "shelf_life = ?, amount = ? where id = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, dto.getSource_id());
			ps.setString(2, dto.getCompany());
			ps.setString(3, dto.getWarehousing_date());
			ps.setString(4, dto.getShelf_life());
			ps.setDouble(5, dto.getAmount());
			ps.setInt(6, dto.getId());
			int res = ps.executeUpdate();
			
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public int deleteStock(int id) throws SQLException {
		int res = 0;
		String sql = "delete from T_Stock where id = ?";
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
	
	public ArrayList<StockDTO> makeArrayList(ResultSet rs) throws SQLException {
		ArrayList<StockDTO> listStock = new ArrayList<StockDTO>();
		while (rs.next()) {
			StockDTO dto = new StockDTO();
			
			dto.setId(rs.getInt("id"));
			dto.setSource_id(rs.getInt("source_id"));
			dto.setCompany(rs.getString("company"));
			dto.setWarehousing_date(rs.getString("warehousing_date"));
			dto.setShelf_life(rs.getString("shelf_life"));
			dto.setAmount(rs.getDouble("amount"));
			
			listStock.add(dto);
		}
		return listStock;
	}
	
}

