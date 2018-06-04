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

public class MemberDAO {
	private static MemberDAO instance;
	private MemberDAO() {};
	public static MemberDAO getInstance() {
		if(instance == null)
			instance = new MemberDAO();
		return instance;
	}



	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	// 사용하는 곳: (service.LoginAction), (service.MemberContent)
	// 기능: 아이디를 받아 삭제되지않은 회원정보를 가져온다
	public Member getUserInfo(String id) throws SQLException {
		String sql1 = "select * from member where id=? and mem_del_yn = 'N'";
		String sql2 = "select count(*) from reservation where id=? and resdate >= To_CHAR(sysdate,'YYYY/MM/DD')";	//오늘날짜 기준으로 예약 갖고오기
		String sql3 = "select count(*) from good where id=?";
		String sql4 = "select count(*) from message where toid=?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Member member = new Member();
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member.setId(rs.getString(1));
				member.setPassword(rs.getString(2));
				member.setAdmin(rs.getInt(3));
				member.setName(rs.getString(4));
				member.setBirth(rs.getString(5));
				member.setImage(rs.getString(6));
				member.setSex(rs.getString(7));
				member.setAddress(rs.getString(8));
				member.setEmail(rs.getString(9));
				member.setTel(rs.getString(10));
				member.setIntro(rs.getString(11));
				member.setPoint(rs.getInt(12));
				member.setReg_date(rs.getDate(13));
				member.setMem_del_yn(rs.getString(14));
			}
			rs.close();
			pstmt.close();
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				member.setResTotCnt(rs.getInt(1));
			rs.close();
			pstmt.close();
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				member.setTotGood(rs.getInt(1));
			rs.close();
			pstmt.close();
			pstmt = conn.prepareStatement(sql4);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				member.setTotMsg(rs.getString(1));
			rs.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return member;
	}

	// 아이디 중복체크 (join.jsp -> checkId.jsp)
	public int checkId(String id) throws SQLException {
		if(id.length() < 4 || id.length() > 20)
			return -1;

		String sql = "select id from member where id=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 1;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			System.out.println(rs);
			if(rs.next())
				result = 1;
			else
				result = 0;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(rs != null)
				rs.close();
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return result;
	}
	// 회원가입(join.jsp -> JoinAction.java)
	public int join(Member member) throws SQLException {
		String sql = "insert into member values(?, ?, 1, ?, ?, ?, ?,? ,?, ?, ?, 1000, sysdate, 'N')";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirth());
			pstmt.setString(5, member.getImage());
			pstmt.setString(6, member.getSex());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getEmail());
			pstmt.setString(9, member.getTel());
			pstmt.setString(10, member.getIntro());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return result;
	}

	// 로그인(login.jsp -> LoginAction.java)
	public int login(String id, String password) throws SQLException {
		String sql = "select password from member where id=? and mem_del_yn='N'";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String dbPwd = rs.getString(1);
				if (dbPwd.equals(password))
					result = 1;
				else
					result = 0;
			} else result = -1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(rs != null)
				rs.close();
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		System.out.println(result);
		return result;
	}

	//관리자가 3보다 작은, 삭제되지 않은 멤버 전체 수를 뽑는 메소드
	public int getTotalCnt() throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int tot = 0;
		String sql = "select count(*) from MEMBER where (mem_del_yn = 'N') "
				+ "and (admin < 3)";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
				tot = rs.getInt(1);
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
		return tot;
	}

	// 관리자가 3보다 작은, 삭제되지 않은 멤버 전체 리스트를 뽑는 메소드
	public List<Member> memberlist() throws SQLException {
		List<Member> list = new ArrayList<Member>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from MEMBER " + "where (mem_del_yn = 'N') "
				+ "and (admin < 3)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Member member = new Member();
				member.setId(rs.getString("id"));
				member.setPassword(rs.getString("password"));
				member.setAdmin(rs.getInt("admin"));
				member.setName(rs.getString("name"));
				member.setBirth(rs.getString("birth"));
				member.setImage(rs.getString("image"));
				member.setSex(rs.getString("sex"));
				member.setAddress(rs.getString("address"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setIntro(rs.getString("intro"));
				member.setPoint(rs.getInt("point"));
				member.setReg_date(rs.getDate("reg_date"));
				member.setMem_del_yn(rs.getString("mem_del_yn"));
				list.add(member);
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

	// 관리자 페이지: MemberAddProAction에서 쓰는 메소드
	// 프로필 사진만 default로 한 회원 생성 메소드
	public int memberInsert(Member member) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		ResultSet rs = null;
		String sql = "insert into MEMBER values "
				+ "(?,?,?,?,?,null,?,?,?,?,?,?,sysdate,'N')";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setInt(3, member.getAdmin());
			pstmt.setString(4, member.getName());
			pstmt.setString(5, member.getBirth());
			pstmt.setString(6, member.getSex());
			pstmt.setString(7, member.getAddress());
			pstmt.setString(8, member.getEmail());
			pstmt.setString(9, member.getTel());
			pstmt.setString(10, member.getIntro());
			pstmt.setInt(11, member.getPoint());
			result = pstmt.executeUpdate();
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
		return result;

	}
	// 아이디 찾기	
	public String findId(String name, String email) throws SQLException {
		String sql = "select id from member where name=? and email=?";
		String id = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next())
				id = rs.getString(1);
			rs.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return id;
	}
	// 임시 비밀번호 DB에 저장
	public int updateTempPwd(String id, String email, String tempPwd) throws SQLException {
		String sql = "update member set password=? where id=? and email=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tempPwd);
			pstmt.setString(2, id);
			pstmt.setString(3, email);
			result = pstmt.executeUpdate();
			if (result == 1)
				result = 1;
			else if (result == 0)
				result = 0;
			else
				result = -1;
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return result;
	}
	// 회원정보 수정 (service.MyInfoAction)
		public int infoUpdate(String id, String password, String email, String tel,	String intro) throws SQLException {
			String sql = "update member set password=?, email=?, tel=?, intro=? where id=?";
			Connection conn = getConnection();
			PreparedStatement pstmt = null;
			int result = 0;
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, password);
				pstmt.setString(2, email);
				pstmt.setString(3, tel);
				pstmt.setString(4, intro);
				pstmt.setString(5, id);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			} finally {
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			}
			return result;
		}
		// 회원 탈퇴 (service.
		public int deleteUser(String id, String password) throws SQLException {
			String sql1 = "select password from member where id=? and mem_del_yn='N'";
			String sql2 = "update member set mem_del_yn='Y' where id=? and password=?";
			Connection conn = getConnection();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			String dbPwd;
			
			try {
				pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dbPwd = rs.getString(1);
					if(dbPwd.equals(password)) {
						pstmt = conn.prepareStatement(sql2);
						pstmt.setString(1, id);
						pstmt.setString(2, password);
						result = pstmt.executeUpdate();
						if(result == 1)
							result = 1;
						else
							result = 0;
					}
				} else {
					result = -1;
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			} finally {
				if(rs != null)
					rs.close();
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			}
			return result;
		}
		
	// 관리자페이지 회원 정보 수정
	public int memberUpdate(Member member) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "update Member set password=?, admin=?, name=?, birth=?,"
				+ " address=?, email=?, tel=?, point=? where id=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getPassword());
			pstmt.setInt(2, member.getAdmin());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getBirth());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getTel());
			pstmt.setInt(8, member.getPoint());
			pstmt.setString(9, member.getId());
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn !=null) conn.close();
		}
		return result;
	}
	
	//사용하는 곳: MemberDeleteProAction.java
	//관리자가 선택한 사용자를 지우기 위한 메소드
	public int memberDelete(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "update Member set mem_del_yn=? where id=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "Y");
			pstmt.setString(2, id);
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn !=null) conn.close();
		}
		return result;
	}
	
	//로그인했는지 체크
	public int logincheck(String id) throws SQLException{
		int logincheck=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from member where id=? ";
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) logincheck=1;
			else logincheck=0;
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally {
			if(rs!=null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn !=null) conn.close();
		}
		return logincheck;
				
	}
	public Member getUserInfoWithPwd(String id, String password) throws SQLException {
		String sql = "select * from member where id=? and password=? and mem_del_yn ='N'";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Member member = new Member();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member.setId(rs.getString(1));
				member.setPassword(rs.getString(2));
				member.setAdmin(rs.getInt(3));
				member.setName(rs.getString(4));
				member.setBirth(rs.getString(5));
				member.setImage(rs.getString(6));
				member.setSex(rs.getString(7));
				member.setAddress(rs.getString(8));
				member.setEmail(rs.getString(9));
				member.setTel(rs.getString(10));
				member.setIntro(rs.getString(11));
				member.setPoint(rs.getInt(12));
				member.setReg_date(rs.getDate(13));
				member.setMem_del_yn(rs.getString(14));
			}
			rs.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return member;
	}
	
	//roomReserve3Action, VrReserve3Action, MyresCancleAction, AddPointproAction
	//기존 멤버 포인트에 변수로 들어오는 포인트를 추가/감소
	public int updateMemberPoint(int point, String id) throws SQLException {
		
		String sql1 = "select point from member where id=?";
		String sql = "update member set point=? where id=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		int mempoint = 0; //기존 멤버 포인트
		
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				mempoint = rs.getInt(1);
				rs.close();
				pstmt.close();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mempoint + point);
				pstmt.setString(2, id);
				result = pstmt.executeUpdate();
				//if (point > 0)
					//충전내역 테이블에 추가
				//if (point < 0)
					//소비내역 테이블에 추가
			}		
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return result;
	}
	
//	id로 회원 타입을 가져옴 ( 1=일반, 2=카페관리자, 3=전체관리자)
	public int getAdmin(String id) throws SQLException {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int admin = 0;
		String sql = "select admin from member where id = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
			admin = rs.getInt(1);
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
		return admin;
	}
	
//	id와 대조하여 비밀번호 가져옴.
	public String getpassword(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String password = null;
		String sql = "select password from member where id = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next())
				password = rs.getString(1);
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
		return password;
	}
	
		
}
