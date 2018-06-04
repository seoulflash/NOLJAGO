package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GoodDAO {
	private static GoodDAO instance;

	private GoodDAO() {
	};

	public static GoodDAO getInstance() {
		if (instance == null)
			instance = new GoodDAO();
		return instance;
	}

	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx
					.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}

	// 사용 : (service.MyFavoriteView)
	// 기능 : 아이디로 좋아요 전체 갯수를 카운트
	public int getGoodCnt(String id) throws SQLException {
		String sql = "select count(*) from good where id=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totCnt = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
				totCnt = rs.getInt(1);
			else
				totCnt = 0;
			rs.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return totCnt;
	}

	// 사용: (service.MyFovirteView)
	// 기능: 좋아요 목록 리스트기능
	public List<Good> getGoodList(int startRow, int endRow, String id)
			throws SQLException {
		List<Good> list = new ArrayList<Good>();

		String sql = "select good.*, cafe.cname, cafe.type, theme.tname, theme.timage "
				+ "From (Select rownum rn, a.* "
				+ "From (select * from good) a ) good, cafe cafe, theme theme "
				+ "where good.rn between ? and ? and good.id=? "
				+ "and good.cnum = cafe.cnum "
				+ "and good.cnum = theme.cnum "
				+ "and good.tnum = theme.tnum "
				+ "order by good.cnum";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Good good = new Good();
				good.setTimage(rs.getString("timage"));
				good.setCname(rs.getString("cname"));
				good.setType(rs.getString("type"));
				good.setTname(rs.getString("tname"));
				good.setCnum(rs.getInt("cnum"));
				good.setTnum(rs.getInt("tnum"));
				list.add(good);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return list;
	}

	public int favCancle(String id, int cnum, int tnum) throws SQLException {
		String sql = "delete from good where id=? and cnum=? and tnum=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, cnum);
			pstmt.setInt(3, tnum);
			result = pstmt.executeUpdate();
			if (result == 1)
				result = 1;
			else
				result = 0;
		} catch (Exception e) {
			result = -1;
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		System.out.println("DAO result : " + result);
		return result;
	}
	
	//좋아요 하면 good테이블에 데이터 추가됨
	public int good(int cnum,int tnum) throws SQLException{
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt=null;
		String sql="insert into good values('bbb',?,?)";
		
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.setInt(2, tnum);
			result=pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return result;
	}
	
	// 카페의 테마에 대한 좋아요 갯수 가져오기
	public int good_num2(int cnum, int tnum) throws SQLException {
		int num = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from good where cnum=? and tnum=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			pstmt.setInt(2, tnum);
			rs = pstmt.executeQuery();
			if (rs.next())
				num = rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return num;
	}
}
