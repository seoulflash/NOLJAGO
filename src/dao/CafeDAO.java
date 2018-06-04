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

public class CafeDAO {
	private static CafeDAO instance;
	private CafeDAO() {}
	public static CafeDAO getInstance() {
		if (instance == null) {
			instance = new CafeDAO();
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

	// vr 가게의 리스트를 보여줌 (vrMainView)
	public List<Cafe> list() throws SQLException{
		List<Cafe> list = new ArrayList<Cafe>();
		Connection conn = null;
		PreparedStatement pstmt= null; PreparedStatement pstmt1 = null;
		ResultSet rs = null; ResultSet rs1 = null;
		String sql = "select * from cafe where type='vr' ";
		String sql1 = "select count(*),trunc(avg(rate)) from review where cnum = ?";
		int cnum = 0;
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			System.out.println("vr_list1");
			
			rs=pstmt.executeQuery();
			while(rs.next()){
				Cafe cafe = new Cafe();
				cafe.setCnum(rs.getInt("cnum"));
				cafe.setCname(rs.getString("cname"));
				cafe.setCaddress(rs.getString("caddress"));
				cafe.setOpen(rs.getInt("open"));
				cafe.setClose(rs.getInt("close"));
				cafe.setPrice(rs.getInt("price"));
				cafe.setRedprice(rs.getInt("redprice"));
				cafe.setType(rs.getString("type"));
				cafe.setImage1(rs.getString("image1"));
				cafe.setImage2(rs.getString("image2"));
				cafe.setImage3(rs.getString("image3"));
				cafe.setContent(rs.getString("content"));
				cafe.setRoomcount(rs.getInt("roomcount"));
				cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
				cafe.setCurl(rs.getString("curl"));
				cnum = rs.getInt("cnum");
				pstmt1 = conn.prepareStatement(sql1);
				pstmt1.setInt(1, cnum);
				rs1 = pstmt1.executeQuery();
				if (rs1.next()) {
					cafe.setReview_count(rs1.getInt(1));
					cafe.setV_rate(rs1.getDouble(2));
				}
				list.add(cafe);
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(rs1!=null) rs1.close();
			if(pstmt1!=null) pstmt1.close();
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return list;
	}
	
	//카페평점 뿌려주기
	public int cafe_rate(int cnum) throws SQLException{
		int rate=0;
		Connection conn = null;
		PreparedStatement pstmt= null; 
		ResultSet rs = null;
		String sql = "select trunc(avg(rate)) from review where cnum = ?";
		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			rs=pstmt.executeQuery();
			if(rs.next()){
				rate=rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return rate;
	}
	
	//vr리스트에서 선택된 vr 가게의 정보를 보여줌
	public List<Theme> v_select_theme(int cnum) throws SQLException{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs= null;
		String sql= "select * from theme where cnum="+cnum;
		List<Theme> list = new ArrayList<Theme>();

		try{
			conn=getConnection();
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);

			while(rs.next()){
				Theme theme = new Theme();
				theme.setCnum(rs.getInt("cnum"));
				theme.setTnum(rs.getInt("tnum"));
				theme.setTname(rs.getString("tname"));
				theme.setTcontent(rs.getString("tcontent"));
				theme.setTimage(rs.getString("timage"));
				theme.setScore1(rs.getDouble("score1"));
				theme.setScore2(rs.getDouble("score2"));
				theme.setScore3(rs.getDouble("score3"));
				theme.setScore4(rs.getDouble("score4"));
				theme.setHeadcount(rs.getInt("headcount"));
				list.add(theme);
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}
		return list;
	}

	// 카페 정보를 보여줌(vrReserveView)
	public Cafe cafe_info(int cnum) throws SQLException{
		Cafe cafe = new Cafe();
		Connection conn = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		String sql = "select * from cafe where cnum="+cnum;

		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
			    cafe.setCnum(rs.getInt("cnum"));
				cafe.setCname(rs.getString("cname"));
				cafe.setCaddress(rs.getString("caddress"));
				cafe.setOpen(rs.getInt("open"));
				cafe.setClose(rs.getInt("close"));
				cafe.setPrice(rs.getInt("price"));
				cafe.setRedprice(rs.getInt("redprice"));
				cafe.setType(rs.getString("type"));
				cafe.setImage1(rs.getString("image1"));
				cafe.setImage2(rs.getString("image2"));
				cafe.setImage3(rs.getString("image3"));
				cafe.setContent(rs.getString("content"));
				cafe.setRoomcount(rs.getInt("roomcount"));
				cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
				cafe.setCurl(rs.getString("curl"));
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return cafe;
	}

	//테마 정보를 보여줌 (vrReserveView 에서 사용)
	public Theme v_theme(int cnum,int tnum) throws SQLException{
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;

		String sql = "select * from theme where cnum="+cnum +" and tnum="+tnum;
		Theme theme = new Theme();

		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery(sql);
			while(rs.next()){
				theme.setCnum(rs.getInt("cnum"));
				theme.setTnum(rs.getInt("tnum"));
				theme.setTname(rs.getString("tname"));
				theme.setTcontent(rs.getString("tcontent"));
				theme.setTimage(rs.getString("timage"));
				theme.setScore1(rs.getDouble("score1"));
				theme.setScore2(rs.getDouble("score2"));
				theme.setScore3(rs.getDouble("score3"));
				theme.setScore4(rs.getDouble("score4"));
				theme.setHeadcount(rs.getInt("headcount"));
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}
		return theme;
	}

	/// room카페 리스트 출력
	// roomMainAction.java 에서 쓰임
		public List<Cafe> r_list() throws SQLException{
			List<Cafe> list = new ArrayList<Cafe>();
			Connection conn = null;
			PreparedStatement pstmt= null; PreparedStatement pstmt1 = null;
			ResultSet rs = null; ResultSet rs1 = null;
			String sql = "select * from cafe where type='room' order by cnum desc";
			String sql1 = "select count(*),trunc(avg(rate)) from review where cnum = ?";
			int cnum = 0;
			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				System.out.println("r_list 실행2");
				
				while(rs.next()){
					Cafe cafe = new Cafe();
					cafe.setCnum(rs.getInt("cnum"));
					cafe.setCname(rs.getString("cname"));
					cafe.setCaddress(rs.getString("caddress"));
					cafe.setOpen(rs.getInt("open"));
					cafe.setClose(rs.getInt("close"));
					cafe.setPrice(rs.getInt("price"));
					cafe.setRedprice(rs.getInt("redprice"));
					cafe.setType(rs.getString("type"));
					cafe.setImage1(rs.getString("image1"));
					cafe.setImage2(rs.getString("image2"));
					cafe.setContent(rs.getString("content"));
					cafe.setRoomcount(rs.getInt("roomcount"));
					cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
					cafe.setCurl(rs.getString("curl"));
					cnum = rs.getInt("cnum");
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setInt(1, cnum);
					rs1 = pstmt1.executeQuery();
					if (rs1.next()) {
						cafe.setReview_count(rs1.getInt(1));
						cafe.setV_rate(rs1.getDouble(2));
					}
					list.add(cafe);
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs1!=null) rs1.close();
				if(pstmt1!=null) pstmt1.close();
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return list;
		}

		// room카페 리스트 출력
	// roomMainAction.java 에서 쓰임
	/*public List<Cafe> r_list2() throws SQLException{
		List<Cafe> list = new ArrayList<Cafe>();
		Connection conn = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		String sql = "SELECT avg(review.rate)"
				+ "FROM  review  review "
				+ "WHERE resno IN "
				+ "(  SELECT  R.resno  resno "
				+ "FROM RESERVATION  R"
				+ ",(select c.cnum, c.id, c.cname from cafe c where type='room') c "
				+ "WHERE  R.cnum = c.cnum"
				+ ")  ; ";

		try{
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()){
				Cafe cafe = new Cafe();

				cafe.setR_rate(rs.getDouble("r_rate"));
				list.add(cafe);
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

		//삭제되지 않은 카페 리스트를 전부 불러옴
		public List<Cafe> CafeList() throws SQLException {
			List<Cafe> cafelist = new ArrayList<Cafe>();
			String sql = "select * from cafe where cafe_del_yn = 'N' order by cnum";
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						Cafe cafe = new Cafe();
						cafe.setCnum(rs.getInt("cnum"));
						cafe.setId(rs.getString("id"));
						cafe.setCname(rs.getString("cname"));
						cafe.setCaddress(rs.getString("caddress"));
						cafe.setOpen(rs.getInt("open"));
						cafe.setClose(rs.getInt("close"));
						cafe.setPrice(rs.getInt("price"));
						cafe.setRedprice(rs.getInt("redprice"));
						cafe.setType(rs.getString("type"));
						cafe.setImage1(rs.getString("image1"));
						cafe.setImage2(rs.getString("image2"));
						cafe.setImage3(rs.getString("image3"));
						cafe.setContent(rs.getString("content"));
						cafe.setRoomcount(rs.getInt("roomcount"));
						cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
						cafe.setCurl(rs.getString("curl"));
						cafelist.add(cafe);
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
			return cafelist;
		}

		//SearchAction
		//지역별 검색했을때 list 받아오기
		public List<Cafe> areaSearchClist(List<String> wordlist) throws SQLException {
			System.out.println("areaSearchClist called from SearchAction");
			List<Cafe> cafelist = new ArrayList<Cafe>();

			int wordcnt = wordlist.size();	//단어 갯수
			String sqlstart = "select * from (";
			String sqlend = ") where caddress like ? ";
			String sqlorder = "order by type, caddress";
			String sql = null;

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				for (int i = 0; i< wordcnt; i++) {
					if (i == 0) {	//맨 처음은 cafe에서 불러와야됨
						sql = "select * from cafe where caddress like ? ";
					} else {
						sql = sqlstart + sql + sqlend;
						System.out.println("i <> 0 areaSearchClist sql->"+sql);
					}

				}

				pstmt = conn.prepareStatement(sql + sqlorder);
				for (int i= 0; i< wordcnt; i++) {
					pstmt.setString(i+1, '%' + wordlist.get(i) + '%');
				}
				rs = pstmt.executeQuery();
				if (rs.next()) {
					do {
						Cafe cafe = new Cafe();
						cafe.setCnum(rs.getInt("cnum"));
						cafe.setId(rs.getString("id"));
						cafe.setCname(rs.getString("cname"));
						cafe.setCaddress(rs.getString("caddress"));
						cafe.setOpen(rs.getInt("open"));
						cafe.setClose(rs.getInt("close"));
						cafe.setPrice(rs.getInt("price"));
						cafe.setRedprice(rs.getInt("redprice"));
						cafe.setType(rs.getString("type"));
						cafe.setImage1(rs.getString("image1"));
						cafe.setImage2(rs.getString("image2"));
						cafe.setImage3(rs.getString("image3"));
						cafe.setContent(rs.getString("content"));
						cafe.setRoomcount(rs.getInt("roomcount"));
						cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
						cafe.setCurl(rs.getString("curl"));
						cafelist.add(cafe);
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
			return cafelist;
		}

		//SearchAction
		//카페이름별 검색했을때 list 받아오기
		public List<Cafe> nameSearchClist(List<String> wordlist) throws SQLException {
			System.out.println("nameSearchClist called from SearchAction");
			List<Cafe> cafelist = new ArrayList<Cafe>();
			int wordcnt = wordlist.size();	//단어 갯수
			String sqlstart = "select * from (";
			String sqlend = ") where UPPER(cname) like UPPER(?) ";
			String sqlorder = "order by type, caddress";
			String sql = null;

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				for (int i = 0; i< wordcnt; i++) {
					if (i == 0) {	//맨 처음은 cafe에서 불러와야됨
						sql = "select * from cafe where UPPER(cname) like UPPER(?) ";
					} else {
						sql = sqlstart + sql + sqlend;
						System.out.println("i <> 0 nameSearchClist sql->"+sql);
						System.out.println("nameSearchClist sql->"+sql);
					}

				}
				pstmt = conn.prepareStatement(sql + sqlorder);
				for (int i= 0; i< wordcnt; i++) {
					pstmt.setString(i+1, '%' + wordlist.get(i) + '%');
				}
				rs = pstmt.executeQuery();

				if (rs.next()) {
					do {
						Cafe cafe = new Cafe();
						cafe.setCnum(rs.getInt("cnum"));
						cafe.setId(rs.getString("id"));
						cafe.setCname(rs.getString("cname"));
						cafe.setCaddress(rs.getString("caddress"));
						cafe.setOpen(rs.getInt("open"));
						cafe.setClose(rs.getInt("close"));
						cafe.setPrice(rs.getInt("price"));
						cafe.setRedprice(rs.getInt("redprice"));
						cafe.setType(rs.getString("type"));
						cafe.setImage1(rs.getString("image1"));
						cafe.setImage2(rs.getString("image2"));
						cafe.setImage3(rs.getString("image3"));
						cafe.setContent(rs.getString("content"));
						cafe.setRoomcount(rs.getInt("roomcount"));
						cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
						cafe.setCurl(rs.getString("curl"));
						cafelist.add(cafe);
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
			return cafelist;
		}

		//SearchAction
		//두 단어로 지역,이름 혹은 이름,지역 검색
		public List<Cafe> twoWordClist(String first, String second) throws SQLException {
			System.out.println("twoWordClist called from SearchAction");
			List<Cafe> cafelist = new ArrayList<Cafe>();
			String sql = "select * from cafe where caddress like ?";
			String sql1 = "select * from cafe where UPPER(cname) like UPPER(?)";
			String sql2 = "select * from (select * from cafe where caddress like ?) "
							+ "where UPPER(cname) like UPPER(?) order by type, cname";	//지역, 이름 순서로 검색시 혹은 이름, 지역 순서로 검색

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);		//첫번째 단어로 지역별 검색
				pstmt.setString(1, '%' + first + '%');
				rs = pstmt.executeQuery();
				if (rs.next()) {		//첫번째 단어의 지역별 검색 결과 존재시
					rs.close();
					pstmt.close();
					System.out.println("twoWordCList---->" +first + "---" + second);
					pstmt = conn.prepareStatement(sql2);
					pstmt.setString(1, '%' + first + '%');	//지역, 이름순으로 검색
					pstmt.setString(2, '%' + second + '%');
					rs = pstmt.executeQuery();
					if(rs.next()) {
						do {
							Cafe cafe = new Cafe();
							cafe.setCnum(rs.getInt("cnum"));
							cafe.setId(rs.getString("id"));
							cafe.setCname(rs.getString("cname"));
							cafe.setCaddress(rs.getString("caddress"));
							cafe.setOpen(rs.getInt("open"));
							cafe.setClose(rs.getInt("close"));
							cafe.setPrice(rs.getInt("price"));
							cafe.setRedprice(rs.getInt("redprice"));
							cafe.setType(rs.getString("type"));
							cafe.setImage1(rs.getString("image1"));
							cafe.setImage2(rs.getString("image2"));
							cafe.setImage3(rs.getString("image3"));
							cafe.setContent(rs.getString("content"));
							cafe.setRoomcount(rs.getInt("roomcount"));
							cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
							cafe.setCurl(rs.getString("curl"));
							cafelist.add(cafe);
						} while (rs.next());
					}
				} else {	//첫번째 단어의 지역별 검색결과가 존재하지 않을 시
					rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql1);	// 첫번째 단어로 이름별 검색 실시
					pstmt.setString(1, '%' + first + '%');
					rs = pstmt.executeQuery();
					if (rs.next()) { // 첫번째 단어에 대한 이름별 검색결과가 존재할시
						rs.close();
						pstmt.close();
						pstmt = conn.prepareStatement(sql2);
						pstmt.setString(1, '%' + second + '%');	//이름, 지역 순으로 검색
						pstmt.setString(2, '%' + first + '%');
						rs = pstmt.executeQuery();
						if(rs.next()) {
							do {
								Cafe cafe = new Cafe();
								cafe.setCnum(rs.getInt("cnum"));
								cafe.setId(rs.getString("id"));
								cafe.setCname(rs.getString("cname"));
								cafe.setCaddress(rs.getString("caddress"));
								cafe.setOpen(rs.getInt("open"));
								cafe.setClose(rs.getInt("close"));
								cafe.setPrice(rs.getInt("price"));
								cafe.setRedprice(rs.getInt("redprice"));
								cafe.setType(rs.getString("type"));
								cafe.setImage1(rs.getString("image1"));
								cafe.setImage2(rs.getString("image2"));
								cafe.setImage3(rs.getString("image3"));
								cafe.setContent(rs.getString("content"));
								cafe.setRoomcount(rs.getInt("roomcount"));
								cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
								cafe.setCurl(rs.getString("curl"));
								cafelist.add(cafe);
							} while (rs.next());
						}
					} else {
						return cafelist;	//검색결과 없으면 빈 리스트를 돌려줌
					}

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
			return cafelist;
		}



		// 선택한 카페의 테마 리스트 불러오기
		// roomListAction.java 에서 쓰임
		public List<Theme> r_select_theme(int cnum) throws SQLException{
			Connection conn=null;
			Statement stmt=null;
			ResultSet rs= null;
			String sql= "select * from theme where cnum="+cnum;
			List<Theme> list = new ArrayList<Theme>();

			try{
				conn=getConnection();
				stmt=conn.createStatement();
				rs=stmt.executeQuery(sql);

				while(rs.next()){
					Theme theme = new Theme();
					theme.setCnum(rs.getInt("cnum"));
					theme.setTnum(rs.getInt("tnum"));
					theme.setTname(rs.getString("tname"));
					theme.setTcontent(rs.getString("tcontent"));
					theme.setTimage(rs.getString("timage"));
					theme.setScore1(rs.getDouble("score1"));
					theme.setScore2(rs.getDouble("score2"));
					theme.setScore3(rs.getDouble("score3"));
					theme.setScore4(rs.getDouble("score4"));
					theme.setHeadcount(rs.getInt("headcount"));
					list.add(theme);
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			}
			return list;
		}





		// 선택한 방탈출 카페에 대한 정보(카페이름,소개,평점 등) 보여주기
		// roomListAction.java 에서 사용
		// roomThemeAction.java 에서 사용
		// RoomList2Action.java 에서 사용
		// roomReserve3Action.java 에서 사용
		public Cafe r_list3(int cnum) throws SQLException{
			Cafe cafe = new Cafe();
			/*List<Cafe> list = new ArrayList<Cafe>();*/
			Connection conn = null;
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			String sql = "select * from cafe where cnum="+cnum;

			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					/*Cafe cafe = new Cafe();*/
					cafe.setCnum(rs.getInt("cnum"));
					cafe.setCname(rs.getString("cname"));
					cafe.setCaddress(rs.getString("caddress"));
					cafe.setOpen(rs.getInt("open"));
					cafe.setClose(rs.getInt("close"));
					cafe.setPrice(rs.getInt("price"));
					cafe.setRedprice(rs.getInt("redprice"));
					cafe.setType(rs.getString("type"));
					cafe.setImage1(rs.getString("image1"));
					cafe.setImage2(rs.getString("image2"));
					cafe.setContent(rs.getString("content"));
					cafe.setRoomcount(rs.getInt("roomcount"));
					cafe.setCafe_del_yn(rs.getString("cafe_del_yn"));
					cafe.setCurl(rs.getString("curl"));
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return cafe;
		}





		// 방탈출 카페와 테마까지 선택했다면, 선택한 테마에 대한 간략한 정보 보여주기
		// roomThemeAction.java 에서 사용
		// RoomlikeAction.java 에서 사용
		public Theme r_theme(int cnum, int tnum) throws SQLException{
			Theme theme = new Theme();
			/*List<Cafe> list = new ArrayList<Cafe>();*/
			Connection conn = null;
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			String sql = "select * from theme where cnum="+cnum +" and tnum="+tnum;

			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					theme.setCnum(rs.getInt("cnum"));
					theme.setTnum(rs.getInt("tnum"));
					theme.setTname(rs.getString("tname"));
					System.out.println("CafeDao  tname->"+rs.getString("tname"));
					System.out.println("CafeDaot image->"+rs.getString("timage"));
					theme.setTcontent(rs.getString("tcontent"));
					theme.setTimage(rs.getString("timage"));
					theme.setScore1(rs.getDouble("score1"));
					theme.setScore2(rs.getDouble("score2"));
					theme.setScore3(rs.getDouble("score3"));
					theme.setScore4(rs.getDouble("score4"));
					theme.setHeadcount(rs.getInt("headcount"));
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return theme;
		}

//		//예약을 위한 멤버 테스트용
//		public Member member_into(String id) throws SQLException{
//			Connection conn=null;
//			PreparedStatement pstmt=null;
//			ResultSet rs= null;
//			String sql="select id,name,email,tel,point from member where id=?";
//			Member member= new Member();
//			try{
//				conn=getConnection();
//				pstmt=conn.prepareStatement(sql);
//				pstmt.setString(1, id);
//				rs=pstmt.executeQuery();
//
//				while(rs.next()){
//					member.setId(rs.getString("id"));
//					member.setName(rs.getString("name"));
//					member.setEmail(rs.getString("email"));
//					member.setTel(rs.getString("tel"));
//					member.setPoint(rs.getInt("point"));
//				}
//
//			}catch(Exception e){
//				System.out.println(e.getMessage());
//			}finally{
//				if(rs!=null) rs.close();
//				if(pstmt!=null) pstmt.close();
//				if(conn!=null) conn.close();
//			}
//			return member;
//		}



		public int vr_reservation(Reservation res) throws SQLException{
			int result=0;
			Connection conn = null;
			PreparedStatement pstmt=null;
			String sql = "insert into reservation values(sysdate,?,'bbb',?,'',?,?,INCREASE.NEXTVAL,?,10000)";
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


		//좋아요 하면 good테이블에 데이터 추가됨
		public int good(String id, int cnum,int tnum) throws SQLException{
			int result=0;
			Connection conn = null;
			PreparedStatement pstmt=null;
			String sql="insert into good values(?,?,?)";

			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, cnum);
				pstmt.setInt(3, tnum);
				result=pstmt.executeUpdate();
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return result;
		}
		
		//좋아요 버튼 두 번 클릭 시 좋아요 리스트에서 삭제되는 함수
		public int deleteGood(String id, int cnum, int tnum) throws SQLException{
			int result;
			Connection conn=null;
			PreparedStatement pstmt=null;
			String sql="delete from good where id=? and cnum=? and tnum=?";
			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, cnum);
				pstmt.setInt(3, tnum);
				result=pstmt.executeUpdate();
				if(result == 1)
					result = 1;
				if(result == 0)
					result = 0;
			}catch(Exception e){
				result = -1;
				System.out.println(e.getMessage());
			}finally{
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return result;
		}
		
		//vrList2View.jsp 에서 좋아요를 누른 상태에 따라 버튼 이미지 다르게 출력하기 위한 함수
		public int good_yn(String id,int cnum,int tnum) throws SQLException{
			int good_clk=0;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select id from good where id=? and cnum=? and tnum=?";
			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, cnum);
				pstmt.setInt(3, tnum);
				rs=pstmt.executeQuery();
				if(rs.next()) good_clk=1;
				else good_clk=0;
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return good_clk;
		}
		

		//good 목록을 아이디별로 보여줌
		public  Good good_list(int cnum,int tnum) throws SQLException{
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select good.id,good.cnum,good.tnum,good.like_yn,tname,timage from good,theme where id='bbb' and good.cnum=theme.cnum and good.tnum=theme.tnum";
			//String sql="select good.id,good.cnum,good.tnum,good.like_yn from good,theme where id='bbb' ";

			Good good= new Good();
			try{
				//Member member = new Member();
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				//pstmt.setString(1, );
				rs=pstmt.executeQuery();
				while(rs.next()){
					good.setId(rs.getString("id"));
					good.setCnum(rs.getInt("cnum"));
					good.setTnum(rs.getInt("tnum"));
					good.setLike_yn(rs.getString("like_yn"));
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return good;
		}

		//좋아요를 한 가게번호를 리스트로 뿌려줌
		public List<Good> good_list2(int cnum,int tnum) throws SQLException{
			List<Good> list= new ArrayList<Good>();
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			//String sql="select theme.tname from good,theme where good.cnum=theme.cnum and good.tnum=theme.tnum and id='bbb'";
			String sql="select * from good where id='bbb'";
			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					Good good = new Good();
					good.setId(rs.getString("id"));
					good.setCnum(rs.getInt("cnum"));
					good.setTnum(rs.getInt("tnum"));
					good.setLike_yn(rs.getString("like_yn"));
					list.add(good);
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

		//카페 좋아요 수
		public int good_num(int cnum) throws SQLException{
			int num=0;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select count(*) from good where cnum=?";

			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, cnum);

				rs=pstmt.executeQuery();
				if (rs.next()) num = rs.getInt(1);
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return num;
		}

		//카페의 테마에 대한 좋아요 수
		public int good_num2(int cnum,int tnum) throws SQLException{
			int num=0;
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql="select count(*) from good where cnum=? and tnum=?";

			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				pstmt.setInt(2, tnum);
				rs=pstmt.executeQuery();
				if (rs.next()) num = rs.getInt(1);
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return num;
		}

			//임시 방탈출 인원
			public Theme r_theme_people(int cnum, int tnum) throws SQLException{
			Theme theme = new Theme();
			Connection conn = null;
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			String sql = "select * from theme where cnum="+cnum +" and tnum="+tnum;

			try{
				conn=getConnection();
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					theme.setCnum(rs.getInt("cnum"));
					theme.setTnum(rs.getInt("tnum"));
					theme.setTname(rs.getString("tname"));
					theme.setTcontent(rs.getString("tcontent"));
					theme.setTimage(rs.getString("timage"));
					theme.setScore1(rs.getDouble("score1"));
					theme.setScore2(rs.getDouble("score2"));
					theme.setScore3(rs.getDouble("score3"));
					theme.setScore4(rs.getDouble("score4"));
					theme.setHeadcount(rs.getInt("headcount"));
				}
			}catch(Exception e){
				System.out.println(e.getMessage());
			}finally{
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			return theme;
		}

			//임시 방탈출 예약
			public int r_reservation(Reservation res) throws SQLException{
			int result=0;
			Connection conn = null;
			PreparedStatement pstmt=null;
			String sql = "insert into reservation values(sysdate,?,'bbb',?,'',?,?,INCREASE.NEXTVAL,?,10000)";
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

		//사용하는 곳: AmCafeListAction
		//관리자가 삭제되지 않은 카페 전체 숫자를 뽑는 메소드 (pageNum을 위해)
		public int getTotalCnt() throws SQLException {
			Connection conn=null;
			Statement stmt = null;
			ResultSet rs = null;
			int tot = 0;
			String sql = "select count(*) from CAFE where cafe_del_yn = 'N'";
			try {
				conn = getConnection();
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				if(rs.next())
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

		//AMCafeUpdateProAction
		//카페 고유번호(cnum)으로 검색 이후 카페 정보 수정
		public int update(Cafe cafe) throws SQLException {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			String sql = "update cafe set cname = ?, caddress = ?, open = ?, close = ?, price = ?, redprice = ?, type = ?, content = ?, roomcount = ?"
					+ ", curl = ? where cnum = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cafe.getCname());
				pstmt.setString(2, cafe.getCaddress());
				pstmt.setInt(3, cafe.getOpen());
				pstmt.setInt(4, cafe.getClose());
				pstmt.setInt(5, cafe.getPrice());
				pstmt.setInt(6, cafe.getRedprice());
				pstmt.setString(7, cafe.getType());;
				pstmt.setString(8, cafe.getContent());
				pstmt.setInt(9, cafe.getRoomcount());
				pstmt.setString(10, cafe.getCurl());
				pstmt.setInt(11, cafe.getCnum());
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

		//AMCafeDeleteProAction
		/*카페 삭제(삭제 시 cafe_del_yn값만 바꾼다)
		 * 카페 번호(cnum)으로 불러온다*/
		public int cafeDelete(int cnum) throws SQLException {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			String sql = "update cafe set cafe_del_yn = ? where cnum = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, "Y");
				pstmt.setInt(2, cnum);

				result = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			} finally {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			}
			return result;
		}

		//AmCafeAddFormAction
		//카페 추가 메소드
		public int cafeAdd(Cafe cafe) throws SQLException {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = 0;
			ResultSet rs = null;
			String sql1 = "select nvl(max(cnum), 0) from Cafe";
			String sql = "insert into cafe values (?, null, ?, ?, ?, ?, ?, ?, ?, 'default_cafeimage.jpg', null, null, ?, ?, 'N', ?)";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql1);
				rs = pstmt.executeQuery();
				rs.next();
				int cnum = rs.getInt(1) + 1;
				rs.close(); pstmt.close();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				pstmt.setString(2, cafe.getCname());
				pstmt.setString(3, cafe.getCaddress());
				pstmt.setInt(4, cafe.getOpen());
				pstmt.setInt(5, cafe.getClose());
				pstmt.setInt(6, cafe.getPrice());
				pstmt.setInt(7, cafe.getRedprice());
				pstmt.setString(8, cafe.getType());
				pstmt.setString(9, cafe.getContent());
				pstmt.setInt(10, cafe.getRoomcount());
				pstmt.setString(11, cafe.getCurl());
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
		
//		카페 사장 id로 카페 번호 조회하는 기능
		public int getCnum(String id) throws SQLException {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int cnum = 0;
			String sql = "select cnum from cafe where id = ?";
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next())
				cnum = rs.getInt(1);
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
			return cnum;
		}
		
//		cnum으로 카페 가격 가져옴
		public int getprice(int cnum) throws SQLException {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int price = 0;
			String sql = "select price from cafe where cnum = ?";
			try  {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cnum);
				rs = pstmt.executeQuery();
				if (rs.next())
					price = rs.getInt(1);
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
			return price;
		}
}
