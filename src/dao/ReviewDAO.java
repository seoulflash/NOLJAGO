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

public class ReviewDAO {
	private static ReviewDAO instance;
	private ReviewDAO() {}
	public static ReviewDAO getInstance() {
		if (instance == null) {
			instance = new ReviewDAO();
			}
		return instance;
	}
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)
				ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch(Exception e) {
			System.out.println(e.getMessage());
			}
		return conn;
	}


	//카페 번호에 맞는 후기들을 뿌려줌 (vrList1View)
		public List<Review> review_view(int cnum) throws SQLException {
			List<Review> list = new ArrayList<Review>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql= "select r.id,r.rate,r.recontent,r.redate,mem.image from review r,member mem "
					+ "where r.id=mem.id and r.cnum=? order by redate desc";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					Review review = new Review();
					review.setId(rs.getString("id"));
					review.setRate(rs.getInt("rate"));
					review.setRecontent(rs.getString("recontent"));
					review.setRedate(rs.getDate("redate"));
					review.setImg(rs.getString(5));
					list.add(review);
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			} finally {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			}
			return list;
		}


		//리뷰 작성하면 insert 해줌. 예약번호는 시퀀스로 1씩 증가시켰음.
		public int review_insert(Review review,String id,int cnum) throws SQLException{
			int result=0;
			Connection conn=null;
			PreparedStatement pstmt=null;
			String sql="insert into review values(INCREASE.NEXTVAL,?,?,?,sysdate,?)";
			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,id);
				pstmt.setInt(2, review.getRate());
				pstmt.setString(3, review.getRecontent());
				pstmt.setInt(4,cnum);
				result=pstmt.executeUpdate();
				System.out.println(result);
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return result;
		}

			//카페번호에 해당하는 리뷰 수 보여주는 메서드(카페 소개에서 리뷰 개수 가 필요)
			/*public List<Review> review_count(int cnum) throws SQLException{
				List<Review> review_count = new ArrayList<Review>();
				Connection conn=null;
				PreparedStatement pstmt=null;
				ResultSet rs=null;
				String sql="select count(r.resno) from review r,member m,reservation s where r.id=m.id and m.id=s.id and r.resno=s.resno and cnum=?";
				try{
					conn=getConnection();
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, cnum);
					rs=pstmt.executeQuery();
					while(rs.next()){
						Review review = new Review();
						review.setReview_count(rs.getInt(1));
						review_count.add(review);
					}
				}catch(Exception e){
					System.out.println(e.getMessage());
				}finally{
					if(rs!=null) rs.close();
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
				}
				return review_count;

			}*/

			/*public List<Review> review_count() throws SQLException{
				List<Review> review_count = new ArrayList<Review>();
				Connection conn=null;
				PreparedStatement pstmt=null;
				ResultSet rs=null;
				String sql="SELECT count(review.resno) FROM  review  review WHERE resno IN(SELECT  R.resno  resno FROM RESERVATION  R,(select c.cnum, c.id, c.cname from cafe c where type='vr') c WHERE  R.cnum = c.cnum)";
				try{
					conn=getConnection();
					pstmt=conn.prepareStatement(sql);
					rs=pstmt.executeQuery();
					while(rs.next()){
						Review review = new Review();
						review.setResno(rs.getInt(1));
						//review.setReview_count(rs.getInt("review_count"));
						review_count.add(review);
					}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return review_count;
		}*/
			
			
			
		//vr랭크 (인기순)	
		public List<Review> v_p_rank() throws SQLException{
			List<Review> list = new ArrayList<Review>();
			Connection conn = null;
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			String sql =  "SELECT a.cnum,cafe.cname,cafe.image1"
					+ " FROM( select r.cnum cnum,count(resno) Rcount, row_Number() over(order by count(resno) desc) as sRank"
					+ " from review r,cafe c"
					+ " where type='vr' and r.cnum=c.cnum"
					+ " group by r.cnum) A,cafe cafe"
					+ " WHERE a.sRank BETWEEN  1 AND 3 and a.cnum=cafe.cnum ";
			System.out.println("v_p_rank sql->"+sql);
	
			try{
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					Review review = new Review();
					review.setCnum(rs.getInt("cnum"));
					review.setCname(rs.getString("cname"));
					review.setImage1(rs.getString("image1"));
					System.out.println("v_p_rank cname->"+rs.getString("cname"));
					System.out.println("v_p_rank image1->"+rs.getString("image1"));

					list.add(review);
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return list;
		}
		
		
		//vr랭크 (평점순)	
		/*public List<Review> v_a_rank() throws SQLException{
			List<Review> list = new ArrayList<Review>();
			Connection conn = null;
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			String sql = "SELECT a.cnum,cafe.cname,cafe.image1 "
					+ " FROM( select r.cnum cnum,avg(rate) Rcount, rank() over(order by avg(rate) desc) as sRank  "
					+ " from review r,cafe c  "
					+ " where type='vr' and r.cnum=c.cnum  group by r.cnum) A, cafe cafe "
					+ " WHERE a.sRank BETWEEN  1 AND 3 and a.cnum=cafe.cnum";
			System.out.println("v_a_rank sql->"+sql);
	
			try{
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					Review review = new Review();
					review.setCnum(rs.getInt("cnum"));
					review.setCname(rs.getString("cname"));
					review.setImage1(rs.getString("image1"));
					list.add(review);
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return list;
		}*/
			
			
		//방탈출 랭크 (인기순)
		public List<Review> r_p_rank() throws SQLException{
			
			List<Review> list = new ArrayList<Review>();
			Connection conn = null;
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			String sql = "SELECT a.cnum,cafe.cname,cafe.image1"
					+ " FROM( select r.cnum cnum,count(resno) Rcount, row_Number() over(order by count(resno) desc) as sRank"
					+ " from review r,cafe c"
					+ " where type='room' and r.cnum=c.cnum"
					+ " group by r.cnum) A,cafe cafe"
					+ " WHERE a.sRank BETWEEN  1 AND 3 and a.cnum=cafe.cnum ";
			System.out.println("r_p_rank sql->"+sql);

				try{
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					Review review = new Review();
					review.setCnum(rs.getInt("cnum"));
					review.setCname(rs.getString("cname"));
					review.setImage1(rs.getString("image1"));
					System.out.println("r_p_rank cname->"+rs.getString("cname"));
					System.out.println("r_p_rank image1->"+rs.getString("image1"));
					list.add(review);
					
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return list;
		}
			
		
		// 방탈출 랭크 (평점순)
		/*public List<Review> r_a_rank() throws SQLException{
			List<Review> list = new ArrayList<Review>();
			Connection conn = null;
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			String sql = "SELECT a.cnum,cafe.cname,cafe.image1 "
					+ " FROM( select r.cnum cnum,avg(rate) Rcount, rank() over(order by avg(rate) desc) as sRank  "
							+ " from review r,cafe c  "
							+ " where type='room' and r.cnum=c.cnum  group by r.cnum) A, cafe cafe "
						+ " WHERE a.sRank BETWEEN  1 AND 3 and a.cnum=cafe.cnum";
			System.out.println("r_a_rank sql->"+sql);
				try{
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					Review review = new Review();
					review.setCnum(rs.getInt("cnum"));
					review.setCname(rs.getString("cname"));
					review.setImage1(rs.getString("image1"));
					System.out.println("r_a_rank cname->"+rs.getString("cname"));
					System.out.println("r_a_rank image1->"+rs.getString("image1"));
					list.add(review);
					
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return list;
		}*/
}
