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

public class ReservationDAO {
	private static ReservationDAO instance;
	private ReservationDAO() {};
	
	public static ReservationDAO getInstance() {
		if(instance == null)
			instance = new ReservationDAO();
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
	
	//reserveconfirmempty.jsp
	//희망 예약시간이 공석인지 알려주는 메소드
	public List<Integer> confirmEmpty (String date, int cnum, int tnum) throws SQLException{
		List<Integer> rslist = new ArrayList<Integer>();
		System.out.println("date-->" + date);
		System.out.println("cnum-->" + cnum);
		System.out.println("tnum-->" + tnum);
		String sql = "select starttime from reservation where resdate=? and cnum=? and tnum=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);		//원하는 날짜의 시작시간들을 받아옴
			pstmt.setString(1, date);
			pstmt.setInt(2, cnum);
			pstmt.setInt(3, tnum);
			rs = pstmt.executeQuery();
			while(rs.next()){
				rslist.add(rs.getInt("starttime"));
				System.out.println("starttime-->" + rs.getInt("starttime"));
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
		return rslist;
	}
	// 아이디로 전체 예약 건수 가져오는 메소드
	public int getResCnt(String id) throws SQLException {
		String sql = "select count(*) from reservation where id=? and resdate >= To_CHAR(sysdate,'YYYY/MM/DD')";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int getTotCnt = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				getTotCnt = rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return getTotCnt;
	}
	// 예약 내역 받아오기 (service.MyResAction)
	public List<Reservation> getResList(int startRow, int endRow, String id) throws SQLException {
		List<Reservation> list = new ArrayList<Reservation>();
		
		String sql = "select reserv.*, cafe.cname, theme.tname "
				+ "From (Select rownum rn, a.* From "
				+ "(select * from reservation where id= ? and resdate >= To_CHAR(sysdate,'YYYY/MM/DD') order by resdate) a ) "
				+ "reserv, cafe cafe, theme theme "
				+ "where reserv.rn between ? and ? "
				+ "and reserv.cnum = cafe.cnum "
				+ "and reserv.cnum = theme.cnum "
				+ "and reserv.tnum = theme.tnum "
				+ "order by resdate, starttime";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Reservation reservation = new Reservation();
				reservation.setResdate(rs.getString("resdate"));
				reservation.setStarttime(rs.getInt("starttime"));
				reservation.setCnum(rs.getInt("cnum"));
				reservation.setTnum(rs.getInt("tnum"));
				reservation.setResno(rs.getString("resno"));
				reservation.setCname(rs.getString("cname"));
				reservation.setTname(rs.getString("tname"));
				list.add(reservation);
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
		return list;
	}
	
	// myresinfoaction, myrescancelaction
	// 아이디, 예약번호로 예약내역 가져옴
	public Reservation getResInfo(String id, String resno) throws SQLException {
		String sql = "select reserv.*, cafe.cname, cafe.type, theme.tname "
				+ "From reservation reserv, cafe cafe, theme theme "
				+ "where reserv.id=? and reserv.resno = ? "
				+ "and reserv.cnum = cafe.cnum and reserv.cnum = theme.cnum "
				+ "and reserv.tnum = theme.tnum";
		String sql2 = "select id from partymem where pnum=? and pmnum=1"; //파티장 아이디를 가져오기 위한 sql
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Reservation reservation = new Reservation();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, resno);
			rs = pstmt.executeQuery();
			if(rs.next()){
				reservation.setResdate(rs.getString("resdate"));
				reservation.setStarttime(rs.getInt("starttime"));
				reservation.setEndtime(rs.getInt("endtime"));
				reservation.setPnum(rs.getInt("pnum"));
				reservation.setCname(rs.getString("cname"));
				reservation.setCnum(rs.getInt("cnum"));
				reservation.setType(rs.getString("type"));
				reservation.setTname(rs.getString("tname"));
				reservation.setCount(rs.getInt("count"));
				reservation.setPoint(rs.getInt("point"));
				rs.close();
				if(reservation.getPnum()!=0){ //파티에 가입되어 있을 경우
					pstmt.close();
					pstmt = conn.prepareStatement(sql2);
					pstmt.setInt(1, reservation.getPnum());
					rs = pstmt.executeQuery();
					if(rs.next()){
						reservation.setLeaderId(rs.getString(1));
					}
				}
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
		return reservation;
	}
	// 예약취소 (service.MyResCancleAction)
	
	public int resCancle(String id, String resno) throws SQLException {
		String sql = "delete from reservation where id=? and resno=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, resno);
			result = pstmt.executeUpdate();
			if(result == 1)
				result = 1;
			else
				result = 0;
		} catch (Exception e) {
			result = -1;
			System.out.println(e.getMessage());
		} finally {
			if(pstmt != null)
				pstmt.close();
			if(conn != null)
				conn.close();
		}
		return result;
	}
	
//	신규 예약 추가
	public int reservation(Reservation res) throws SQLException{
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt=null;
		String sql = "insert into reservation values(?,?,?,?,?,?,?,?,?,?)";
		try{
			conn=getConnection();
			System.out.println("resdao");
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, res.getResdate());
			pstmt.setInt(2, res.getStarttime());
			pstmt.setString(3, res.getId());
			pstmt.setInt(4, res.getEndtime());
			pstmt.setInt(5, res.getPnum());
			pstmt.setInt(6, res.getCnum());
			pstmt.setInt(7, res.getTnum());
			pstmt.setString(8, res.getResno());
			pstmt.setInt(9, res.getCount());
			pstmt.setInt(10, res.getPoint());
			result=pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return result;
	}
	
	public int vr_reservation(Reservation res) throws SQLException{
		int result=0;
		Connection conn = null;
		PreparedStatement pstmt=null;
		String sql = "insert into reservation values(?,?,?,?,?,?,?,INCREASE.NEXTVAL,?,?)";
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, res.getStarttime());
			pstmt.setInt(2, res.getEndtime());
			pstmt.setInt(3, res.getCnum());
			pstmt.setInt(4, res.getTnum());
			pstmt.setInt(5, res.getCount());
			result=pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return result;
	}
	
//	전체 예약 리스트
	public List<Reservation> ResList() throws SQLException {
		List<Reservation> reslist = new ArrayList<Reservation>();
		String sql = "select * from reservation order by resdate";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				do {
					Reservation res = new Reservation();
					res.setResdate(rs.getString("resdate"));
					res.setStarttime(rs.getInt("starttime"));
					res.setId(rs.getString("id"));
					res.setEndtime(rs.getInt("endtime"));
					res.setPnum(rs.getInt("pnum"));
					res.setCnum(rs.getInt("cnum"));
					res.setTnum(rs.getInt("tnum"));
					res.setResno(rs.getString("resno"));
					res.setCount(rs.getInt("count"));
					res.setPoint(rs.getInt("point"));
					reslist.add(res);
				} while (rs.next());
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
		return reslist;
	}
	
//	각 카페 주인만 볼 수 있는 본인 카페 앞으로 달린 예약 리스트
	public List<Reservation> getCafeRes(String id) throws SQLException {
		List<Reservation> cafereslist = new ArrayList<Reservation>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select reserv.* from reservation reserv, cafe, member mem "
				+ "where reserv.cnum = cafe.cnum and cafe.id = mem.id "
				+ "and mem.admin = 2 and mem.id = ? order by resdate";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					Reservation res = new Reservation();
					res.setResdate(rs.getString("resdate"));
					res.setStarttime(rs.getInt("starttime"));
					res.setId(rs.getString("id"));
					res.setEndtime(rs.getInt("endtime"));
					res.setPnum(rs.getInt("pnum"));
					res.setCnum(rs.getInt("cnum"));
					res.setTnum(rs.getInt("tnum"));
					res.setResno(rs.getString("resno"));
					res.setCount(rs.getInt("count"));
					res.setPoint(rs.getInt("point"));
					cafereslist.add(res);
				} while (rs.next());
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
		return cafereslist;
	}
	
// 게시판 기능을 위해 쓰는 게시글 총 개수 세는 메소드
	public int getTotalCnt() throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int tot = 0;
		String sql = "select count(*) from reservation";
		try { 
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
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
	
//	카페 관리자 게시판 예약 게시물 개수 세는 메소드
	public int getCafeResCnt(String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rescnt = 0;
		String sql = "select count(*) from reservation reserv, cafe, member mem "
				+ "where mem.id = cafe.id and mem.admin = 2 and reserv.cnum = cafe.cnum and mem.id = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
				rescnt = rs.getInt(1);
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
		return rescnt;
	}
	
	public int check(String resdate, int starttime, String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String sql = "select * from reservation where resdate=? and starttime=? and id=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resdate);
			pstmt.setInt(2, starttime);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = -1;	//예약이 이미있다
			} else {
				result = 1;
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
		
		return result;
	}
	
	
	//예약을 했는지 확인하기 위한 메소드 ( 예약하면 후기 쓸 수 있음)
	public int res_yn(String id, int cnum) throws SQLException{
		int res_yn=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		//String sql="select * from reservation where id=? and cnum=?";
		String sql="select count(*) from reservation where id=? and cnum=?";
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, cnum);
			rs=pstmt.executeQuery();
			//if(rs.next()) res_yn=1;
			//else res_yn=0;
			if(rs.next()){
				res_yn=rs.getInt(1);
			}
			else res_yn=0;
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return res_yn;
	}
	
	//예약한 id로 후기를 남겼으면 더이상 작성하지 못하게 막기 위한 메소드
	public int review_yn(String id,int cnum) throws SQLException{
		int review_yn=0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from review where id=? and cnum=?";
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, cnum);
			rs=pstmt.executeQuery();
			if(rs.next()) review_yn=1;	//후기 썼으면 더이상 작성하지 못함
			else review_yn=0;
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return review_yn;
	}

//	고유한 값을 가진 랜덤값 resno로 예약 정보 1개를 Reservation에 담아 가져옴
	public Reservation reserv_info(String resno) throws SQLException {
		Reservation reserv = new Reservation();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from reservation where resno = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resno);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				reserv.setResdate(rs.getString("resdate"));
				reserv.setStarttime(rs.getInt("starttime"));
				reserv.setId(rs.getString("id"));
				reserv.setEndtime(rs.getInt("endtime"));
				reserv.setPnum(rs.getInt("pnum"));
				reserv.setCnum(rs.getInt("cnum"));
				reserv.setTnum(rs.getInt("tnum"));
				reserv.setResno(rs.getString("resno"));
				reserv.setCount(rs.getInt("count"));
				reserv.setPoint(rs.getInt("point"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return reserv;	
	}
	
	public int ResDelete(String resno) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = "delete from reservation where resno = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resno);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			result = -1;
			System.out.println(e.getMessage());
		} finally {
			if (pstmt!=null) 
				pstmt.close();
			if (conn!=null) 
				conn.close();
		}
		return result;
	}
	
//	예약 업데이트(시작시간과 끝시간만 바꿈)
	public int ResUpdate(Reservation reserv) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		System.out.println("ResUpdate reserv.getStarttime()->"+reserv.getStarttime());
		System.out.println("ResUpdate getResno->"+reserv.getResno());
		String sql = "update reservation set resdate = ?, starttime = ?, endtime = ? where resno = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reserv.getResdate());
			pstmt.setInt(2, reserv.getStarttime());
			pstmt.setInt(3, reserv.getEndtime());
			pstmt.setString(4, reserv.getResno());
			result = pstmt.executeUpdate();
			System.out.println("ResUpdate result->"+result);
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
