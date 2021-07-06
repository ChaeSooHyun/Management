package home.source;

import java.sql.*;
import java.util.*;

public class SourceDAO {
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

	public SourceDAO() {
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
	
	public int createSource(SourceDTO dto) throws SQLException {
		int res = 0;
		String sql = "insert into T_Source (name, unit) values (?, ?)";
		
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getUnit());
			res = ps.executeUpdate();
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public ArrayList<SourceDTO> readSource() throws SQLException {
		String sql = "select * from T_Source order by id";
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
	
	public ArrayList<SourceDTO> searchSource() throws SQLException {
		String sql = "select * from T_Source where " + searchColumn;
		try {
			if (searchColumn.equals("id")) {
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
	
	public int updateSource(SourceDTO dto) throws SQLException {
		try {
			String sql = "update T_Source set name = ?, unit = ? where id = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getUnit());
			ps.setInt(3, dto.getId());
			int res = ps.executeUpdate();
			
			return res;
		} finally {
			if (ps != null) ps.close();
			if (con != null) con.close();
		}
	}
	
	public int deleteSource(int id) throws SQLException {
		int res = 0;
		String sql = "delete from T_Source where id = ?";
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
	
	public ArrayList<SourceDTO> makeArrayList(ResultSet rs) throws SQLException {
		ArrayList<SourceDTO> listSource = new ArrayList<SourceDTO>();
		while (rs.next()) {
			SourceDTO dto = new SourceDTO();
			
			dto.setId(rs.getInt("id"));
			dto.setName(rs.getString("name"));
			dto.setUnit(rs.getString("unit"));
			
			listSource.add(dto);
		}
		return listSource;
	}
	
}
