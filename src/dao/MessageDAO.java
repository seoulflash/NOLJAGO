package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MessageDAO {
	private static MessageDAO instance;

	private MessageDAO() {
	}

	public static MessageDAO getInstance() {
		if (instance == null) {
			instance = new MessageDAO();
		}
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
	
	
	// 아이디로 쪽지 보낸 갯수 가져오는 메소드
	public int getTotalCnt(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int tot = 0;
		String sql = "select count(*) from message where toid=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
				tot = rs.getInt(1);
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
		return tot;
	}
	// 아이디로 쪽지 받은 갯수 가져오는 메소드
	
	public int getRcvCnt(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int tot = 0;
		String sql = "select count(*) from message where fromid=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
				tot = rs.getInt(1);
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
		return tot;
	}
	
	// 보낸 아이디로 정보 가져옴
	public List<Message> sendList(String id)
			throws SQLException {
		List<Message> list = new ArrayList<Message>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from message where toid=? order by mnum desc";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Message message = new Message();
				message.setMnum(rs.getInt("mnum"));
				message.setFromid(rs.getString("fromid"));
				message.setToid(rs.getString("toid"));
				message.setMcontent(rs.getString("mcontent"));
				message.setMdate(rs.getDate("mdate"));
				list.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
	
	// 받은 아이디로 정보 가져옴
	public List<Message> rcvList(String id)
			throws SQLException {
		List<Message> list = new ArrayList<Message>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from message where fromid=? order by mnum desc";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Message message = new Message();
				message.setMnum(rs.getInt("mnum"));
				message.setFromid(rs.getString("fromid"));
				message.setToid(rs.getString("Toid"));
				message.setMcontent(rs.getString("mcontent"));
				message.setMdate(rs.getDate("mdate"));
				list.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
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

	public Message messageSelect(int mnum) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select *from message where mnum=" + mnum;
		Message message = new Message();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				message.setMnum(rs.getInt("mnum"));
				message.setFromid(rs.getString("fromid"));
				message.setToid(rs.getString("toid"));
				message.setMcontent(rs.getString("mcontent"));
				message.setMdate(rs.getDate("mdate"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
		return message;
	}
	// 쪽지 보내기
	public int messageInsert(String fromid, String toid, String mcontent)
			throws SQLException {
		String sql = "insert into message values(?,?,?,?,sysdate)";
		String sql1 = "select nvl(max(mnum),0) from message";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			rs.next();
			int number = rs.getInt(1) + 1;
			rs.close();
			pstmt.close();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, fromid);
			pstmt.setString(3, toid);
			pstmt.setString(4, mcontent);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
			if (rs != null)
				rs.close();
		}
		return result;
	}
	// 쪽지 삭제	
	public int messageDelete(int mnum) throws SQLException {
		String sql = "delete from message where mnum=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mnum);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}
}
