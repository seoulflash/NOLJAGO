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

public class PartyDAO {
	private static PartyDAO instance;
	private PartyDAO(){}
	public static PartyDAO getInstance(){
		if(instance==null){
			instance = new PartyDAO();
		}
		return instance;
	}
	private Connection getConn(){
		Connection conn = null;
		try{
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return conn;
	}
	//파티 전체 갯수 
	public int getTotalCnt() throws SQLException {
		Connection conn = null;	Statement stmt= null; 
		ResultSet rs = null;    int tot = 0;
		String sql = "select count(*) from party where hopedate >= To_CHAR(sysdate,'YYYY/MM/DD')";
		try {
			conn = getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) tot = rs.getInt(1);
		} catch(Exception e) {	System.out.println(e.getMessage()); 
		} finally {
			if (rs !=null) rs.close();
			if (stmt != null) stmt.close();
			if (conn !=null) conn.close();
		}
		return tot;
	}
	
	//자기 파티 찾기 갯수
	public int getTotalMyCnt(String id) throws SQLException {
		Connection conn = null;	PreparedStatement pstmt= null; 
		ResultSet rs = null;    int tot = 0;
		String sql = "select count(*) from party p, partymem pm where pm.id=? and pm.pnum = p.pnum and p.hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by p.pnum desc";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) tot = rs.getInt(1);
		} catch(Exception e) {	System.out.println(e.getMessage()); 
		} finally {
			if (rs !=null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn !=null) conn.close();
		}
		return tot;
	}
	
	//파티 게시판에서 파티 간략정보, 파티 상세정보를 출력 partyBoard line.169 to line.241
	public List<Party> list(int startRow, int endRow) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; ResultSet rs4 = null;
		ResultSet rs5 = null; ResultSet rs6 = null;
		//sql1 = 게시판 형식으로 출력 / 큰 pnum부터 출력
		 String sql1 = "select * from (select rownum rn ,a.* from (select * from party where hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc) a ) where rn between ? and ?";
		 //sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		 String sql2 = "select * from cafe where cnum=?";
		 //sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		 String sql3 = "select * from theme where cnum=? and tnum=?";
		 //sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		 String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		 //sql5 = 파티장 이름
		 String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		 //sql6 = 평점
		 String sql6 = "select count(*), avg(rate) from review where cnum=?";
		try {
			conn = getConn();
			pstmt1 = conn.prepareStatement(sql1);
			pstmt1.setInt(1, startRow);
			pstmt1.setInt(2, endRow);
			rs1 = pstmt1.executeQuery();
			while (rs1.next()) {
				Party party = new Party();
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setInt(1, rs1.getInt("cnum"));
				rs2 = pstmt2.executeQuery();
				while(rs2.next()){
					party.setTnum(rs1.getInt("tnum"));
					party.setCname(rs2.getString("cname"));
					party.setCaddress(rs2.getString("caddress"));
					party.setContent(rs2.getString("content"));
					party.setType(rs2.getString("type"));
					party.setOpen(rs2.getInt("open"));
					party.setClose(rs2.getInt("close"));
					party.setPrice(rs1.getInt("point"));
					party.setRedprice(rs2.getInt("redprice"));
					party.setImage1(rs2.getString("image1"));
					party.setImage2(rs2.getString("image2"));
					}
				pstmt3 = conn.prepareStatement(sql3);
				pstmt3.setInt(1, rs1.getInt("cnum"));
				pstmt3.setInt(2, rs1.getInt("tnum"));
				rs3 = pstmt3.executeQuery();
				while(rs3.next()){
					party.setTname(rs3.getString("tname"));
					party.setImage3(rs3.getString("timage"));
					party.setTcontent(rs3.getString("tcontent"));
				}
				party.setCnum(rs1.getInt("cnum"));
				party.setPnum(rs1.getInt("pnum"));
				party.setPreg_date(rs1.getDate("preg_date"));
				party.setHopedate(rs1.getString("hopedate"));
				party.setHopehour(rs1.getInt("hopehour"));
				party.setMax(rs1.getInt("max"));
				party.setPcontent(rs1.getString("pcontent"));
				pstmt4 = conn.prepareStatement(sql4);
				pstmt4.setInt(1, rs1.getInt("pnum"));
				pstmt4.setString(2, "1");
				rs4 = pstmt4.executeQuery();
				while(rs4.next()){
					party.setPmcount(rs4.getInt(1));
				}
				pstmt5 = conn.prepareStatement(sql5);
				pstmt5.setInt(1, rs1.getInt("pnum"));
				pstmt5.setString(2, "1");
				rs5 = pstmt5.executeQuery();
				while(rs5.next()){
					party.setId(rs5.getString("id"));
				}
				pstmt6 = conn.prepareStatement(sql6);
				pstmt6.setInt(1, rs1.getInt("cnum"));
				rs6 = pstmt6.executeQuery();
				while(rs6.next()){
					party.setReviewCount(rs6.getInt(1));
					party.setReviewAvg(rs6.getDouble(2));
					}
				list.add(party);
			}
		} catch(Exception e) {	System.out.println(e.getMessage()); 
		} finally {	
			if(rs5!=null)rs5.close();
			if(pstmt5!=null)pstmt5.close();
			if(rs4!=null)rs4.close();
			if(pstmt4!=null)pstmt4.close();
			if(rs3!=null)rs3.close();
			if(pstmt3!=null)pstmt3.close();
			if(rs2!=null)rs2.close();
			if(pstmt2!=null)pstmt2.close();
			if (rs1 !=null) rs1.close();
			if (pstmt1 != null) pstmt1.close();
			if (conn !=null) conn.close();
		}
		return list;
	}
	//파티원 정보를 출력 partyBoard line.274
	public List<PartyMem> memList() throws SQLException {
		List<PartyMem> memList = new ArrayList<PartyMem>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		//sql = 파티원 정보
		String sql = "select * from member, partymem where member.id=partymem.id order by pnum, pmnum";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				PartyMem partyMem = new PartyMem();
				partyMem.setId(rs.getString("id"));
				partyMem.setPnum(rs.getInt("pnum"));
				partyMem.setPmnum(rs.getInt("pmnum"));
				partyMem.setName(rs.getString("name"));
				partyMem.setSex(rs.getString("sex"));
				partyMem.setBirth(rs.getString("birth"));
				partyMem.setEmail(rs.getString("email"));
				partyMem.setTel(rs.getString("tel"));
				partyMem.setIntro(rs.getString("intro"));
				memList.add(partyMem);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return memList;
	}
	//파티 탈퇴를 눌렀을 때 작동 PartyOutAction
	public int partyOut(int pnum, String id) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int pmnum = 0;
		//sql1 = pnum, id 기준으로 파티에 속해있는지 확인
		String sql1 = "select * from partymem where pnum=? and id=?";
		//sql2 = 파티에 속해있을 경우, partymem에서 정보 삭제
		String sql2 = "delete from partymem where pnum=? and id=?";
		//sql3 = 소속 파티원들의 pmnum을 하나씩 줄임
		String sql3 = "update partymem set pmnum = pmnum-1 where pnum=? and pmnum>?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				pmnum = rs.getInt("pmnum");
				rs.close();
				pstmt.close();
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, id);
				result = pstmt.executeUpdate();
				//---------다른 파티원들의 pmnum을 update시켜줘야함---------
				pstmt.close();
				pstmt = conn.prepareStatement(sql3);
				pstmt.setInt(1, pnum);
				pstmt.setInt(2, pmnum);
				pstmt.executeUpdate();
			}else result = -1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	//파티 참여를 할 때 작동 PartyJoinAction
	public int partyJoin(int pnum, String id) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//sql1 = 파티에서 pnum에 대한max 변수를 가져옴
		String sql1 = "select * from party where pnum=?";
		//sql2 = pnum에 대한 partymem 전체의 갯수를 가져옴
		String sql2 = "select count(*) from partymem where pnum=?";
		//sql3 = pnum과 id를 기준으로 파티에 속해있는지를 판별
		String sql3 = "select * from partymem where pnum=? and id=?";
		//sql4 파티에 속해있지 않고 최대 인원수에 도달하지 않았을 경우
		String sql4 = "insert into partymem (pnum, id, pmnum) values (?,?,?)";
		int max = 0; int pmCount = 0;
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				max = rs.getInt("max");
				rs.close();
				pstmt.close();
			}
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				pmCount = rs.getInt("count(*)");
			}
			if(max==pmCount){
				result = -2;
			}else{
				rs.close();
				pstmt.close();
				pstmt = conn.prepareStatement(sql3);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, id);
				rs = pstmt.executeQuery();
			if(rs.next()){
				result=-1;
			}else {
				rs.close();
				pstmt.close();
				pstmt = conn.prepareStatement(sql4);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, id);
				pstmt.setInt(3, pmCount+1);
				result = pstmt.executeUpdate();
			}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return result;
	}
	//파티 정보를 수정할 때 작동 PartyEditAction
	public int partyEdit(int pnum, int max, String pContent) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//sql1 = pnum을 기준으로 partymem의 총 인원수를 가져옴
		String sql1 = "select count(*) from partymem where pnum=?";
		//sql2 = 총 인원수가 최대 인원수를 넘지 않는 범위 내에서 수정
		String sql2 = "update party set max=?,pcontent=? where pnum=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				int pmcount = rs.getInt(1);
				System.out.println(pmcount);
				if(pmcount<=max){
					rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql2);
					pstmt.setInt(1, max);
					pstmt.setString(2, pContent);
					pstmt.setInt(3, pnum);
					result=pstmt.executeUpdate();
				}else{
					result = -1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return result;
	}
	//파티 삭제를 할 때 작동 PartyDeleteAction
	public int partyDelete(int pnum) throws SQLException {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//sql1 = 자식인 reservation의 안에 들어 있는 내용들을 pnum을 기준으로 삭제
		String sql1  = "delete from reservation where pnum=?";
		//sql2 = 자식인 partymem의 안에 들어 있는 내용들을 pnum을 기준으로 삭제 
		String sql2 = "delete from partymem where pnum=?";
		//sql3 = 자식 테이블의 내용이 삭제된 후 부모 테이블 내용 삭제
		String sql3 = "delete from party where pnum=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				rs.close();
				pstmt.close();
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, pnum);
				rs = pstmt.executeQuery();
				if(rs.next()){
					pstmt.close();
					pstmt = conn.prepareStatement(sql3);
					pstmt.setInt(1, pnum);
					result = pstmt.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return result;
	}
	//파티 생성시 작동 PartyCreateAction
	public int partyCreate(Party party,String id, int point) throws SQLException{
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		//sql1 = cnum과 tnum, 희망 날짜, 시간을 기준으로 파티가 있는지 확인
		String sql1 = "select * from party where cnum=? and tnum=? and hopedate=? and hopehour=?";
		//sql2 = pnum의 최대값을 가져와 +1하여 생성시 pnum으로 사용
		String sql2 = "select max(pnum) from party";
		//sql3 = 파티를 생성
		String sql3 = "insert into party values(?,?,?,to_char(sysdate,'YYYY/MM/DD'),?,?,?,?,?)";
		//sql4 = 파티장을 생성
		String sql4 = "insert into partymem values(?,?,1)";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, party.getCnum());
			pstmt.setInt(2, party.getTnum());
			pstmt.setString(3, party.getHopedate());
			pstmt.setInt(4, party.getHopehour());
			rs = pstmt.executeQuery();
			if(rs.next()){
				result= 0;
			}else{
				rs.close();
				pstmt.close();
				pstmt = conn.prepareStatement(sql2);
				rs = pstmt.executeQuery();
				if(rs.next()){
					int pnum=rs.getInt(1)+1;
					party.setPnum(pnum);
					rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql3);
					pstmt.setInt(1, party.getPnum());
					pstmt.setInt(2, party.getTnum());
					pstmt.setInt(3, party.getCnum());
					pstmt.setString(4, party.getHopedate());
					pstmt.setInt(5, party.getHopehour());
					pstmt.setInt(6, party.getMax());
					pstmt.setString(7, party.getPcontent());
					pstmt.setInt(8, point);
					rs = pstmt.executeQuery();
					if(rs.next()){
						rs.close();
						pstmt.close();
						pstmt = conn.prepareStatement(sql4);
						pstmt.setInt(1, party.getPnum());
						pstmt.setString(2, id);
						result = pstmt.executeUpdate();
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return result;
	}
	//PartyJoinAction에서 reservation 추가를 위해 관련 정보를 가져옴 PartyJoinAction
	public Party partyInfo(int pnum) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select cnum, tnum, hopedate, hopehour, point from party where pnum=?";
		Party party = new Party();
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				party.setCnum(rs.getInt(1));
				party.setTnum(rs.getInt(2));
				party.setHopedate(rs.getString(3));
				party.setHopehour(rs.getInt(4));
				party.setPrice(rs.getInt(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return party;
	}
	//PartyOutAction에서 reservation delete시 필요한 resno를 받아옴 PartyOutAction
	public String resnoGet(int pnum, String id) throws SQLException {
		String resno = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select resno from reservation where pnum=? and id=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				resno = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return resno;
	}
	//가장 최근에 만들어진 파티를 파티장의 아이디를 기준으로 찾음 PartyCreateAction
	public int pnumCheck(String id) throws SQLException {
		int pnum = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select pnum from partymem where id=? and pmnum=1 order by pnum desc";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				pnum = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return pnum;
	}
	//상세정보등 파티 하나만을 찾아야 할 경우 PartySelectAction
	public List<Party> partyDetail(int pnum) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; ResultSet rs4 = null;
		ResultSet rs5 = null; ResultSet rs6 = null;
		//sql1 = 게시판 형식으로 출력
		 String sql1 = "select * from party where pnum=?";
		 //sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		 String sql2 = "select * from cafe where cnum=?";
		 //sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		 String sql3 = "select * from theme where cnum=? and tnum=?";
		 //sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		 String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		 //sql5 = 파티장 이름
		 String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		 //sql6 = 평점
		 String sql6 = "select count(*), avg(rate) from review where cnum=?";
		try {
			conn = getConn();
			pstmt1 = conn.prepareStatement(sql1);
			pstmt1.setInt(1, pnum);
			rs1 = pstmt1.executeQuery();
			if (rs1.next()) {
				Party party = new Party();
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setInt(1, rs1.getInt("cnum"));
				rs2 = pstmt2.executeQuery();
				if(rs2.next()){
					party.setTnum(rs1.getInt("tnum"));
					party.setCname(rs2.getString("cname"));
					party.setCaddress(rs2.getString("caddress"));
					party.setContent(rs2.getString("content"));
					party.setType(rs2.getString("type"));
					party.setOpen(rs2.getInt("open"));
					party.setClose(rs2.getInt("close"));
					party.setPrice(rs1.getInt("point"));
					party.setRedprice(rs2.getInt("redprice"));
					party.setImage1(rs2.getString("image1"));
					party.setImage2(rs2.getString("image2"));
					}
				pstmt3 = conn.prepareStatement(sql3);
				pstmt3.setInt(1, rs1.getInt("cnum"));
				pstmt3.setInt(2, rs1.getInt("tnum"));
				rs3 = pstmt3.executeQuery();
				if(rs3.next()){
					party.setImage3(rs3.getString("timage"));
					party.setTname(rs3.getString("tname"));
					party.setTcontent(rs3.getString("tcontent"));
				}
				party.setCnum(rs1.getInt("cnum"));
				party.setPnum(rs1.getInt("pnum"));
				party.setPreg_date(rs1.getDate("preg_date"));
				party.setHopedate(rs1.getString("hopedate"));
				party.setHopehour(rs1.getInt("hopehour"));
				party.setMax(rs1.getInt("max"));
				party.setPcontent(rs1.getString("pcontent"));
				pstmt4 = conn.prepareStatement(sql4);
				pstmt4.setInt(1, rs1.getInt("pnum"));
				pstmt4.setString(2, "1");
				rs4 = pstmt4.executeQuery();
				if(rs4.next()){
					party.setPmcount(rs4.getInt(1));
				}
				pstmt5 = conn.prepareStatement(sql5);
				pstmt5.setInt(1, rs1.getInt("pnum"));
				pstmt5.setString(2, "1");
				rs5 = pstmt5.executeQuery();
				if(rs5.next()){
					party.setId(rs5.getString("id"));
				}
				pstmt6 = conn.prepareStatement(sql6);
				pstmt6.setInt(1, rs1.getInt("cnum"));
				rs6 = pstmt6.executeQuery();
				if(rs6.next()){
					party.setReviewCount(rs6.getInt(1));
					party.setReviewAvg(rs6.getDouble(2));
					}
				list.add(party);
			}
		} catch(Exception e) {	System.out.println(e.getMessage()); 
		} finally {	
			if(rs5!=null)rs5.close();
			if(pstmt5!=null)pstmt5.close();
			if(rs4!=null)rs4.close();
			if(pstmt4!=null)pstmt4.close();
			if(rs3!=null)rs3.close();
			if(pstmt3!=null)pstmt3.close();
			if(rs2!=null)rs2.close();
			if(pstmt2!=null)pstmt2.close();
			if (rs1 !=null) rs1.close();
			if (pstmt1 != null) pstmt1.close();
			if (conn !=null) conn.close();
		}
		return list;
	}
	//partySearch1 : 카페 분류(vr,room) 을 받아 해당하는 파티를 가져옴 PartySearchAction
	public List<Party> partySearch1(String type) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmtS1 = null; PreparedStatement pstmtS2 = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rsS1 = null; ResultSet rsS2 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; 
		ResultSet rs4 = null; ResultSet rs5 = null; ResultSet rs6 = null;
		//sqlS1 = 검색조건을 기준으로 pnum 출력
		String sqlS1 = "select pnum from party where cnum=? and hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc";
		//SqlS2 = sqlS1에 들어갈 검색조건
		String sqlS2 = "select cnum from cafe where upper(type)=upper(?)";
		//sql1 = 큰 pnum부터 출력
		String sql1 = "select * from party where pnum=? order by pnum desc";
		//sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		String sql2 = "select * from cafe where cnum=?";
		//sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		String sql3 = "select * from theme where cnum=? and tnum=?";
		//sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		//sql5 = 파티장 이름
		String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		//sql6 = 평점
		String sql6 = "select count(*), avg(rate) from review where cnum=?";
		 try {
				conn = getConn();
						pstmtS2 = conn.prepareStatement(sqlS2);
						pstmtS2.setString(1, type);
						rsS2 = pstmtS2.executeQuery();
						while(rsS2.next()){
							pstmtS1 = conn.prepareStatement(sqlS1);
							pstmtS1.setInt(1, rsS2.getInt(1));
							rsS1 = pstmtS1.executeQuery();
							while(rsS1.next()){
								pstmt1 = conn.prepareStatement(sql1);
								pstmt1.setInt(1, rsS1.getInt(1));
								rs1 = pstmt1.executeQuery();
								System.out.println(rsS1.getInt(1));
								while (rs1.next()) {
									Party party = new Party();
									pstmt2 = conn.prepareStatement(sql2);
									pstmt2.setInt(1, rs1.getInt("cnum"));
									rs2 = pstmt2.executeQuery();
									while(rs2.next()){
										party.setTnum(rs1.getInt("tnum"));
										party.setCname(rs2.getString("cname"));
										party.setCaddress(rs2.getString("caddress"));
										party.setContent(rs2.getString("content"));
										party.setType(rs2.getString("type"));
										party.setOpen(rs2.getInt("open"));
										party.setClose(rs2.getInt("close"));
										party.setPrice(rs1.getInt("point"));
										party.setRedprice(rs2.getInt("redprice"));
										party.setImage1(rs2.getString("image1"));
										party.setImage2(rs2.getString("image2"));
										}
									pstmt3 = conn.prepareStatement(sql3);
									pstmt3.setInt(1, rs1.getInt("cnum"));
									pstmt3.setInt(2, rs1.getInt("tnum"));
									rs3 = pstmt3.executeQuery();
									while(rs3.next()){
										party.setTname(rs3.getString("tname"));
										party.setImage3(rs3.getString("timage"));
										party.setTcontent(rs3.getString("tcontent"));
									}
									party.setCnum(rs1.getInt("cnum"));
									party.setPnum(rs1.getInt("pnum"));
									party.setPreg_date(rs1.getDate("preg_date"));
									party.setHopedate(rs1.getString("hopedate"));
									party.setHopehour(rs1.getInt("hopehour"));
									party.setMax(rs1.getInt("max"));
									party.setPcontent(rs1.getString("pcontent"));
									pstmt4 = conn.prepareStatement(sql4);
									pstmt4.setInt(1, rs1.getInt("pnum"));
									pstmt4.setString(2, "1");
									rs4 = pstmt4.executeQuery();
									while(rs4.next()){
										party.setPmcount(rs4.getInt(1));
									}
									pstmt5 = conn.prepareStatement(sql5);
									pstmt5.setInt(1, rs1.getInt("pnum"));
									pstmt5.setString(2, "1");
									rs5 = pstmt5.executeQuery();
									while(rs5.next()){
										party.setId(rs5.getString("id"));
									}
									pstmt6 = conn.prepareStatement(sql6);
									pstmt6.setInt(1, rs1.getInt("cnum"));
									rs6 = pstmt6.executeQuery();
									while(rs6.next()){
										party.setReviewCount(rs6.getInt(1));
										party.setReviewAvg(rs6.getDouble(2));
										}
									list.add(party);
									}
								}
							}
			} catch(Exception e) {	System.out.println(e.getMessage()); 
			} finally {	
				if(rs5!=null)rs5.close();
				if(pstmt5!=null)pstmt5.close();
				if(rs4!=null)rs4.close();
				if(pstmt4!=null)pstmt4.close();
				if(rs3!=null)rs3.close();
				if(pstmt3!=null)pstmt3.close();
				if(rs2!=null)rs2.close();
				if(pstmt2!=null)pstmt2.close();
				if (rs1 !=null) rs1.close();
				if (pstmt1 != null) pstmt1.close();
				if(rsS2!=null)rsS2.close();
				if(pstmtS2!=null)pstmtS2.close();
				if(rsS1!=null)rsS1.close();
				if(pstmtS1!=null)pstmtS1.close();
				if (conn !=null) conn.close();
			}
			return list;
		}
	//partySearch2 : 파티장 아이디를 받아 해당하는 파티를 가져옴 PartySearchAction
	public List<Party> partySearch2(String leaderId) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmtS1 = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rsS1 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; 
		ResultSet rs4 = null; ResultSet rs5 = null; ResultSet rs6 = null;
		//sqlS1 = 검색조건을 기준으로 pnum 출력
		String sqlS1 = "select pnum from partymem where pmnum=1 and upper(id) like upper(?) "
					+ "order by pnum desc";
		//sql1 = 큰 pnum부터 출력
		String sql1 = "select * from party where pnum=? and hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc";
		//sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		String sql2 = "select * from cafe where cnum=?";
		//sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		String sql3 = "select * from theme where cnum=? and tnum=?";
		//sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		//sql5 = 파티장 이름
		String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		//sql6 = 평점
		String sql6 = "select count(*), avg(rate) from review where cnum=?";
		 try {
				conn = getConn();
				leaderId = "%"+leaderId+"%";
				pstmtS1 = conn.prepareStatement(sqlS1);
				pstmtS1.setString(1, leaderId);
				rsS1 = pstmtS1.executeQuery();
				while(rsS1.next()){
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setInt(1, rsS1.getInt(1));
					rs1 = pstmt1.executeQuery();
					while (rs1.next()) {
						Party party = new Party();
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setInt(1, rs1.getInt("cnum"));
						rs2 = pstmt2.executeQuery();
						while(rs2.next()){
							party.setTnum(rs1.getInt("tnum"));
							party.setCname(rs2.getString("cname"));
							party.setCaddress(rs2.getString("caddress"));
							party.setContent(rs2.getString("content"));
							party.setType(rs2.getString("type"));
							party.setOpen(rs2.getInt("open"));
							party.setClose(rs2.getInt("close"));
							party.setPrice(rs1.getInt("point"));
							party.setRedprice(rs2.getInt("redprice"));
							party.setImage1(rs2.getString("image1"));
							party.setImage2(rs2.getString("image2"));
							}
						pstmt3 = conn.prepareStatement(sql3);
						pstmt3.setInt(1, rs1.getInt("cnum"));
						pstmt3.setInt(2, rs1.getInt("tnum"));
						rs3 = pstmt3.executeQuery();
						while(rs3.next()){
							party.setTname(rs3.getString("tname"));
							party.setImage3(rs3.getString("timage"));
							party.setTcontent(rs3.getString("tcontent"));
						}
						party.setCnum(rs1.getInt("cnum"));
						party.setPnum(rs1.getInt("pnum"));
						party.setPreg_date(rs1.getDate("preg_date"));
						party.setHopedate(rs1.getString("hopedate"));
						party.setHopehour(rs1.getInt("hopehour"));
						party.setMax(rs1.getInt("max"));
						party.setPcontent(rs1.getString("pcontent"));
						pstmt4 = conn.prepareStatement(sql4);
						pstmt4.setInt(1, rs1.getInt("pnum"));
						pstmt4.setString(2, "1");
						rs4 = pstmt4.executeQuery();
						while(rs4.next()){
							party.setPmcount(rs4.getInt(1));
						}
						pstmt5 = conn.prepareStatement(sql5);
						pstmt5.setInt(1, rs1.getInt("pnum"));
						pstmt5.setString(2, "1");
						rs5 = pstmt5.executeQuery();
						while(rs5.next()){
							party.setId(rs5.getString("id"));
						}
						pstmt6 = conn.prepareStatement(sql6);
						pstmt6.setInt(1, rs1.getInt("cnum"));
						rs6 = pstmt6.executeQuery();
						while(rs6.next()){
							party.setReviewCount(rs6.getInt(1));
							party.setReviewAvg(rs6.getDouble(2));
							}
						list.add(party);
						}
					}
			} catch(Exception e) {	System.out.println(e.getMessage()); 
			} finally {	
				if(rs5!=null)rs5.close();
				if(pstmt5!=null)pstmt5.close();
				if(rs4!=null)rs4.close();
				if(pstmt4!=null)pstmt4.close();
				if(rs3!=null)rs3.close();
				if(pstmt3!=null)pstmt3.close();
				if(rs2!=null)rs2.close();
				if(pstmt2!=null)pstmt2.close();
				if (rs1 !=null) rs1.close();
				if (pstmt1 != null) pstmt1.close();
				if(rsS1!=null)rsS1.close();
				if(pstmtS1!=null)pstmtS1.close();
				if (conn !=null) conn.close();
			}
			return list;
		}
	//partySearch3 : 카페 이름을 받아 해당하는 파티를 가져옴 PartySearchAction
	public List<Party> partySearch3(String cname) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmtS1 = null; PreparedStatement pstmtS2 = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rsS1 = null; ResultSet rsS2 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; 
		ResultSet rs4 = null; ResultSet rs5 = null; ResultSet rs6 = null;
		//sqlS1 = 검색조건을 기준으로 pnum 출력
		String sqlS1 = "select pnum from party where cnum=? and hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc";
		//SqlS2 = sqlS1에 들어갈 검색조건
		String sqlS2 = "select cnum from cafe where upper(cname) like upper(?)";
		//sql1 = 큰 pnum부터 출력
		String sql1 = "select * from party where pnum=? order by pnum desc";
		//sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		String sql2 = "select * from cafe where cnum=?";
		//sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		String sql3 = "select * from theme where cnum=? and tnum=?";
		//sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		//sql5 = 파티장 이름
		String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		//sql6 = 평점
		String sql6 = "select count(*), avg(rate) from review where cnum=?";
		 try {
				conn = getConn();
						cname = "%"+cname+"%";
						pstmtS2 = conn.prepareStatement(sqlS2);
						pstmtS2.setString(1, cname);
						rsS2 = pstmtS2.executeQuery();
						while(rsS2.next()){
							pstmtS1 = conn.prepareStatement(sqlS1);
							pstmtS1.setInt(1, rsS2.getInt(1));
							rsS1 = pstmtS1.executeQuery();
							while(rsS1.next()){
								Party party = new Party();
								pstmt1 = conn.prepareStatement(sql1);
								pstmt1.setInt(1, rsS1.getInt(1));
								rs1 = pstmt1.executeQuery();
								while (rs1.next()) {
									pstmt2 = conn.prepareStatement(sql2);
									pstmt2.setInt(1, rs1.getInt("cnum"));
									rs2 = pstmt2.executeQuery();
									while(rs2.next()){
										party.setTnum(rs1.getInt("tnum"));
										party.setCname(rs2.getString("cname"));
										party.setCaddress(rs2.getString("caddress"));
										party.setContent(rs2.getString("content"));
										party.setType(rs2.getString("type"));
										party.setOpen(rs2.getInt("open"));
										party.setClose(rs2.getInt("close"));
										party.setPrice(rs1.getInt("point"));
										party.setRedprice(rs2.getInt("redprice"));
										party.setImage1(rs2.getString("image1"));
										party.setImage2(rs2.getString("image2"));
										}
									pstmt3 = conn.prepareStatement(sql3);
									pstmt3.setInt(1, rs1.getInt("cnum"));
									pstmt3.setInt(2, rs1.getInt("tnum"));
									rs3 = pstmt3.executeQuery();
									while(rs3.next()){
										party.setTname(rs3.getString("tname"));
										party.setImage3(rs3.getString("timage"));
										party.setTcontent(rs3.getString("tcontent"));
									}
									party.setCnum(rs1.getInt("cnum"));
									party.setPnum(rs1.getInt("pnum"));
									party.setPreg_date(rs1.getDate("preg_date"));
									party.setHopedate(rs1.getString("hopedate"));
									party.setHopehour(rs1.getInt("hopehour"));
									party.setMax(rs1.getInt("max"));
									party.setPcontent(rs1.getString("pcontent"));
									pstmt4 = conn.prepareStatement(sql4);
									pstmt4.setInt(1, rs1.getInt("pnum"));
									pstmt4.setString(2, "1");
									rs4 = pstmt4.executeQuery();
									while(rs4.next()){
										party.setPmcount(rs4.getInt(1));
									}
									pstmt5 = conn.prepareStatement(sql5);
									pstmt5.setInt(1, rs1.getInt("pnum"));
									pstmt5.setString(2, "1");
									rs5 = pstmt5.executeQuery();
									while(rs5.next()){
										party.setId(rs5.getString("id"));
									}
									pstmt6 = conn.prepareStatement(sql6);
									pstmt6.setInt(1, rs1.getInt("cnum"));
									rs6 = pstmt6.executeQuery();
									while(rs6.next()){
										party.setReviewCount(rs6.getInt(1));
										party.setReviewAvg(rs6.getDouble(2));
										}
									}
								list.add(party);
								}
							}
			} catch(Exception e) {	System.out.println(e.getMessage()); 
			} finally {	
				if(rs5!=null)rs5.close();
				if(pstmt5!=null)pstmt5.close();
				if(rs4!=null)rs4.close();
				if(pstmt4!=null)pstmt4.close();
				if(rs3!=null)rs3.close();
				if(pstmt3!=null)pstmt3.close();
				if(rs2!=null)rs2.close();
				if(pstmt2!=null)pstmt2.close();
				if (rs1 !=null) rs1.close();
				if (pstmt1 != null) pstmt1.close();
				if(rsS2!=null)rsS2.close();
				if(pstmtS2!=null)pstmtS2.close();
				if(rsS1!=null)rsS1.close();
				if(pstmtS1!=null)pstmtS1.close();
				if (conn !=null) conn.close();
			}
			return list;
		}
	//partySearch4 : 날짜 두개를 받아 사이값을 가져옴 PartySearchAction
	public List<Party> partySearch4(String startdate, String enddate) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmtS1 = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rsS1 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; 
		ResultSet rs4 = null; ResultSet rs5 = null; ResultSet rs6 = null;
		//sqlS1 = 검색조건을 기준으로 pnum 출력
		String sqlS1 = "select pnum from party where hopedate between ? and ? order by pnum desc";
		//sql1 = 큰 pnum부터 출력
		String sql1 = "select * from party where pnum=? order by pnum desc";
		//sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		String sql2 = "select * from cafe where cnum=?";
		//sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		String sql3 = "select * from theme where cnum=? and tnum=?";
		//sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		//sql5 = 파티장 이름
		String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		//sql6 = 평점
		String sql6 = "select count(*), avg(rate) from review where cnum=?";
		 try {
				conn = getConn();
				pstmtS1 = conn.prepareStatement(sqlS1);
				pstmtS1.setString(1, startdate);
				pstmtS1.setString(2, enddate);
				rsS1 = pstmtS1.executeQuery();
				while(rsS1.next()){
					Party party = new Party();
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setInt(1, rsS1.getInt(1));
					rs1 = pstmt1.executeQuery();
					while (rs1.next()) {
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setInt(1, rs1.getInt("cnum"));
						rs2 = pstmt2.executeQuery();
						while(rs2.next()){
							party.setTnum(rs1.getInt("tnum"));
							party.setCname(rs2.getString("cname"));
							party.setCaddress(rs2.getString("caddress"));
							party.setContent(rs2.getString("content"));
							party.setType(rs2.getString("type"));
							party.setOpen(rs2.getInt("open"));
							party.setClose(rs2.getInt("close"));
							party.setPrice(rs1.getInt("point"));
							party.setRedprice(rs2.getInt("redprice"));
							party.setImage1(rs2.getString("image1"));
							party.setImage2(rs2.getString("image2"));
							}
						pstmt3 = conn.prepareStatement(sql3);
						pstmt3.setInt(1, rs1.getInt("cnum"));
						pstmt3.setInt(2, rs1.getInt("tnum"));
						rs3 = pstmt3.executeQuery();
						while(rs3.next()){
							party.setTname(rs3.getString("tname"));
							party.setImage3(rs3.getString("timage"));
							party.setTcontent(rs3.getString("tcontent"));
						}
						party.setCnum(rs1.getInt("cnum"));
						party.setPnum(rs1.getInt("pnum"));
						party.setPreg_date(rs1.getDate("preg_date"));
						party.setHopedate(rs1.getString("hopedate"));
						party.setHopehour(rs1.getInt("hopehour"));
						party.setMax(rs1.getInt("max"));
						party.setPcontent(rs1.getString("pcontent"));
						pstmt4 = conn.prepareStatement(sql4);
						pstmt4.setInt(1, rs1.getInt("pnum"));
						pstmt4.setString(2, "1");
						rs4 = pstmt4.executeQuery();
						while(rs4.next()){
							party.setPmcount(rs4.getInt(1));
						}
						pstmt5 = conn.prepareStatement(sql5);
						pstmt5.setInt(1, rs1.getInt("pnum"));
						pstmt5.setString(2, "1");
						rs5 = pstmt5.executeQuery();
						while(rs5.next()){
							party.setId(rs5.getString("id"));
						}
						pstmt6 = conn.prepareStatement(sql6);
						pstmt6.setInt(1, rs1.getInt("cnum"));
						rs6 = pstmt6.executeQuery();
						while(rs6.next()){
							party.setReviewCount(rs6.getInt(1));
							party.setReviewAvg(rs6.getDouble(2));
							}
						}
					list.add(party);
					}
			} catch(Exception e) {	System.out.println(e.getMessage()); 
			} finally {	
				if(rs5!=null)rs5.close();
				if(pstmt5!=null)pstmt5.close();
				if(rs4!=null)rs4.close();
				if(pstmt4!=null)pstmt4.close();
				if(rs3!=null)rs3.close();
				if(pstmt3!=null)pstmt3.close();
				if(rs2!=null)rs2.close();
				if(pstmt2!=null)pstmt2.close();
				if (rs1 !=null) rs1.close();
				if (pstmt1 != null) pstmt1.close();
				if(rsS1!=null)rsS1.close();
				if(pstmtS1!=null)pstmtS1.close();
				if (conn !=null) conn.close();
			}
			return list;
		}
	//파티 멤버인지 체크 pmemCheck.jsp
	public int pmemCheck(int pnum, String id) throws SQLException{
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from partymem where pnum=? and id=?";
		conn = getConn();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result=-1; //파티에 속해있을 경우
			}else result=1; //파티에 속해있지 않은 경우
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(rs!=null)rs.close();
			if(pstmt!=null)pstmt.close();
			if(conn!=null)conn.close();
		}
		return result;
	}
	//내 파티만 보여주기 PartyMineAction
	public List<Party> showMyParty(String id) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmtS1 = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rsS1 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; 
		ResultSet rs4 = null; ResultSet rs5 = null; ResultSet rs6 = null;
		//sqlS1 = 검색조건을 기준으로 pnum 출력
		String sqlS1 = "select pnum from partymem where id=? order by pnum desc";
		//sql1 = 큰 pnum부터 출력
		String sql1 = "select * from party where pnum=? and hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc";
		//sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		String sql2 = "select * from cafe where cnum=?";
		//sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		String sql3 = "select * from theme where cnum=? and tnum=?";
		//sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		//sql5 = 파티장 이름
		String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		//sql6 = 평점
		String sql6 = "select count(*), avg(rate) from review where cnum=?";
		 try {
				conn = getConn();
				pstmtS1 = conn.prepareStatement(sqlS1);
				pstmtS1.setString(1, id);
				rsS1 = pstmtS1.executeQuery();
				while(rsS1.next()){
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setInt(1, rsS1.getInt(1));
					rs1 = pstmt1.executeQuery();
					while (rs1.next()) {
						Party party = new Party();
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setInt(1, rs1.getInt("cnum"));
						rs2 = pstmt2.executeQuery();
						while(rs2.next()){
							party.setTnum(rs1.getInt("tnum"));
							party.setCname(rs2.getString("cname"));
							party.setCaddress(rs2.getString("caddress"));
							party.setContent(rs2.getString("content"));
							party.setType(rs2.getString("type"));
							party.setOpen(rs2.getInt("open"));
							party.setClose(rs2.getInt("close"));
							party.setPrice(rs1.getInt("point"));
							party.setRedprice(rs2.getInt("redprice"));
							party.setImage1(rs2.getString("image1"));
							party.setImage2(rs2.getString("image2"));
							}
						pstmt3 = conn.prepareStatement(sql3);
						pstmt3.setInt(1, rs1.getInt("cnum"));
						pstmt3.setInt(2, rs1.getInt("tnum"));
						rs3 = pstmt3.executeQuery();
						while(rs3.next()){
							party.setTname(rs3.getString("tname"));
							party.setImage3(rs3.getString("timage"));
							party.setTcontent(rs3.getString("tcontent"));
						}
						party.setCnum(rs1.getInt("cnum"));
						party.setPnum(rs1.getInt("pnum"));
						party.setPreg_date(rs1.getDate("preg_date"));
						party.setHopedate(rs1.getString("hopedate"));
						party.setHopehour(rs1.getInt("hopehour"));
						party.setMax(rs1.getInt("max"));
						System.out.println("party getMAX------>" + party.getMax());
						party.setPcontent(rs1.getString("pcontent"));
						pstmt4 = conn.prepareStatement(sql4);
						pstmt4.setInt(1, rs1.getInt("pnum"));
						pstmt4.setString(2, "1");
						rs4 = pstmt4.executeQuery();
						while(rs4.next()){
							party.setPmcount(rs4.getInt(1));
							System.out.println("party getPMCOUNT------>" + party.getPmcount());
						}
						pstmt5 = conn.prepareStatement(sql5);
						pstmt5.setInt(1, rs1.getInt("pnum"));
						pstmt5.setString(2, "1");
						rs5 = pstmt5.executeQuery();
						while(rs5.next()){
							party.setId(rs5.getString("id"));
						}
						pstmt6 = conn.prepareStatement(sql6);
						pstmt6.setInt(1, rs1.getInt("cnum"));
						rs6 = pstmt6.executeQuery();
						while(rs6.next()){
							party.setReviewCount(rs6.getInt(1));
							party.setReviewAvg(rs6.getDouble(2));
							}
						list.add(party);
						}
					}
			} catch(Exception e) {	System.out.println(e.getMessage()); 
			} finally {	
				if(rs5!=null)rs5.close();
				if(pstmt5!=null)pstmt5.close();
				if(rs4!=null)rs4.close();
				if(pstmt4!=null)pstmt4.close();
				if(rs3!=null)rs3.close();
				if(pstmt3!=null)pstmt3.close();
				if(rs2!=null)rs2.close();
				if(pstmt2!=null)pstmt2.close();
				if (rs1 !=null) rs1.close();
				if (pstmt1 != null) pstmt1.close();
				if(rsS1!=null)rsS1.close();
				if(pstmtS1!=null)pstmtS1.close();
				if (conn !=null) conn.close();
			}
			return list;
		}
	//같은 카페, 같은 테마를 가는 파티 목록 출력 PartySimilarAction
	public List<Party> partySimilar(int cnum, int tnum) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmtS1 = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rsS1 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; 
		ResultSet rs4 = null; ResultSet rs5 = null; ResultSet rs6 = null;
		//sqlS1 = 검색조건을 기준으로 pnum 출력
		String sqlS1 = "select pnum from party where cnum=? and tnum=? and hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc";
		//sql1 = 큰 pnum부터 출력
		String sql1 = "select * from party where pnum=? order by pnum desc";
		//sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		String sql2 = "select * from cafe where cnum=?";
		//sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		String sql3 = "select * from theme where cnum=? and tnum=?";
		//sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		//sql5 = 파티장 이름
		String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		//sql6 = 평점
		String sql6 = "select count(*), avg(rate) from review where cnum=?";
		 try {
				conn = getConn();
				pstmtS1 = conn.prepareStatement(sqlS1);
				rsS1 = pstmtS1.executeQuery();
				while(rsS1.next()){
					Party party = new Party();
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setInt(1, rsS1.getInt(1));
					rs1 = pstmt1.executeQuery();
					while (rs1.next()) {
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setInt(1, rs1.getInt("cnum"));
						rs2 = pstmt2.executeQuery();
						while(rs2.next()){
							party.setTnum(rs1.getInt("tnum"));
							party.setCname(rs2.getString("cname"));
							party.setCaddress(rs2.getString("caddress"));
							party.setContent(rs2.getString("content"));
							party.setType(rs2.getString("type"));
							party.setOpen(rs2.getInt("open"));
							party.setClose(rs2.getInt("close"));
							party.setPrice(rs2.getInt("price"));
							party.setRedprice(rs2.getInt("redprice"));
							party.setImage1(rs2.getString("image1"));
							party.setImage2(rs2.getString("image2"));
							}
						pstmt3 = conn.prepareStatement(sql3);
						pstmt3.setInt(1, rs1.getInt("cnum"));
						pstmt3.setInt(2, rs1.getInt("tnum"));
						rs3 = pstmt3.executeQuery();
						while(rs3.next()){
							party.setTname(rs3.getString("tname"));
							party.setImage3(rs3.getString("timage"));
							party.setTcontent(rs3.getString("tcontent"));
						}
						party.setCnum(rs1.getInt("cnum"));
						party.setPnum(rs1.getInt("pnum"));
						party.setPreg_date(rs1.getDate("preg_date"));
						party.setHopedate(rs1.getString("hopedate"));
						party.setHopehour(rs1.getInt("hopehour"));
						party.setMax(rs1.getInt("max"));
						party.setPcontent(rs1.getString("pcontent"));
						pstmt4 = conn.prepareStatement(sql4);
						pstmt4.setInt(1, rs1.getInt("pnum"));
						pstmt4.setString(2, "1");
						rs4 = pstmt4.executeQuery();
						while(rs4.next()){
							party.setPmcount(rs4.getInt(1));
						}
						pstmt5 = conn.prepareStatement(sql5);
						pstmt5.setInt(1, rs1.getInt("pnum"));
						pstmt5.setString(2, "1");
						rs5 = pstmt5.executeQuery();
						while(rs5.next()){
							party.setId(rs5.getString("id"));
						}
						pstmt6 = conn.prepareStatement(sql6);
						pstmt6.setInt(1, rs1.getInt("cnum"));
						rs6 = pstmt6.executeQuery();
						while(rs6.next()){
							party.setReviewCount(rs6.getInt(1));
							party.setReviewAvg(rs6.getDouble(2));
							}
						}
					list.add(party);
					}
			} catch(Exception e) {	System.out.println(e.getMessage()); 
			} finally {	
				if(rs5!=null)rs5.close();
				if(pstmt5!=null)pstmt5.close();
				if(rs4!=null)rs4.close();
				if(pstmt4!=null)pstmt4.close();
				if(rs3!=null)rs3.close();
				if(pstmt3!=null)pstmt3.close();
				if(rs2!=null)rs2.close();
				if(pstmt2!=null)pstmt2.close();
				if (rs1 !=null) rs1.close();
				if (pstmt1 != null) pstmt1.close();
				if(rsS1!=null)rsS1.close();
				if(pstmtS1!=null)pstmtS1.close();
				if (conn !=null) conn.close();
			}
			return list;
		}

	//partyCheck.jsp
	//같은 날짜, 같은 시간, 같은 카페, 같은 테마번호로 내가 파티장인 파티가 이미 만들어져있나 확인
	public int checkParty(int cnum, int tnum, String hopedate, int hopehour, String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from party p, partymem pm where "
				+ "cnum=? and tnum=? and hopedate=? and hopehour=? "
				+ "and p.pnum = pm.pnum and id=? and pm.pmnum=1";
		int result = 0;
		try {
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, cnum);
            pstmt.setInt(2, tnum);
            pstmt.setString(3, hopedate);
            pstmt.setInt(4, hopehour);
            pstmt.setString(5, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	result = 1;	//내가 파티장인 완전 동일한 파티가 있는경우
            	
            }
		} catch(Exception e) {
			e.getMessage();
		} finally {
			 if(rs!=null) rs.close();
	         if(pstmt!=null) pstmt.close();
	         if(conn!=null) conn.close();
		}
		
		System.out.println("partycheck result-->" + result);
		return result;
	}
	
	//partyRecommend.jsp
	//같은 카페, 같은 테마번호로 다른 파티가 있나 확인
	public List<Integer> recommendParty(int cnum, int tnum, String id) throws SQLException {
		List<Integer> pnumlist = new ArrayList<Integer>();
		List<Integer> partylist = new ArrayList<Integer>();
		Connection conn = null;
		PreparedStatement pstmt = null, pstmt1 = null, pstmt2 = null;
		ResultSet rs = null, rs1=null, rs2=null;
		int first = 0;
		
		//입력한 카페, 테마로 내가 이미 소속되어있는 파티가 있나 확인
		String sql = "select Distinct pm.pnum from partymem pm, party p "
				+ "where pm.id =? and p.cnum = ? and p.tnum = ? and pm.pnum = p.pnum and p.hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') "
				+ "order by pnum desc";
		
		// 내가 소속되어있는 파티는 제외 시켜주는 sql문
		String sql1start = "select pnum, hopedate from (";
		String sql1end = ") where pnum != ?";
		String sql1order = " and hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc";
		//String sql1order2 = " and p.hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by p.pnum desc";
		String sql1 = null;
		
		String sql2 = "select pnum from party where cnum=? and tnum=? and "
				+ "hopedate >= To_CHAR(sysdate,'YYYY/MM/DD') order by pnum desc";	//첫번째 조건 동일한 카페 동일한 테마
		
		try {
			conn = getConn();
			pstmt2 =  conn.prepareStatement(sql2);
			pstmt2.setInt(1, cnum);
			pstmt2.setInt(2, tnum);
			rs2 = pstmt2.executeQuery();
			if (rs2.next()) {	//같은 카페, 같은 테마 있음
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
	            pstmt.setInt(2, cnum);
	            pstmt.setInt(3, tnum);
	            rs = pstmt.executeQuery();
	            if (rs.next()) {	//자신이 속한 파티의 pnum을 받아옴
	            	do {
	            		pnumlist.add(rs.getInt(1));	//	pnumlist에 내가 소속되어있는 파티의 pnum들을 넣어줌
	            		System.out.println(rs.getInt(1));
	            	} while(rs.next());	//내가 속한 pnumlist 완성
	            	
	            	rs.close();
	                pstmt.close();
	                for (int i = 0; i < pnumlist.size(); i++) {
	                	if (i == 0) {
	                		/*sql1 = "select p.*, c.cname, c.caddress, c.open, c.close, c.price, "
	                				+ "c.type, c.content, c.image1, c.image2, c.image3, pm.pmnum, "
	                				+ "pm.id, t.tname, t.tcontent from party p, partymem pm, cafe c, theme t "
	                				+ "where p.cnum=" +cnum+ " and p.tnum="+tnum+ " and p.pnum !=?"
	                				+ " and p.pnum = pm.pnum and p.cnum = c.cnum and p.cnum = t.cnum and "
	                				+ "c.cnum = t.cnum and p.tnum = t.tnum";*/
	                		
	                		sql1 = "select pnum, hopedate from party where cnum = "+cnum+ " and tnum = "+tnum+ " and pnum != ?";
	                		
	                		first = 0;
	                		
	                	} else {
	                		first = 1;
	                		sql1 = sql1start + sql1 + sql1end;
	                	} 
	                }
	                
	                System.out.println("partydao sql====>" + sql1 + sql1order);
	                if (first == 0) {
	                	pstmt = conn.prepareStatement(sql1 + sql1order);
	                } else {
	                	pstmt = conn.prepareStatement(sql1 + sql1order);	//모든 sql문이 완성되었으면 pstmt에 넣어줌
	                }
	                for (int i = 0; i < pnumlist.size(); i++) {
	                	
	                	pstmt.setInt(i+1, pnumlist.get(i));
	                	System.out.println("pnumlist-->" + pnumlist.get(i));
	                }
	                rs = pstmt.executeQuery();
	                if (rs.next()) {
	                	do {
	                		System.out.println("final pnum-->" + rs.getInt("pnum"));
	                		partylist.add(rs.getInt("pnum"));
	                	} while(rs.next());
	                }
	            
	            	
	            } else {
            		/*sql = "select p.*, c.cname, c.caddress, c.open, c.close, c.price, "
        				+ "c.type, c.content, c.image1, c.image2, c.image3, pm.pmnum, "
        				+ "pm.id, t.tname, t.tcontent from party p, partymem pm, cafe c, theme t "
        				+ "where p.cnum=" +cnum+ " and p.tnum="+tnum+" and p.pnum = pm.pnum"
        				+ " and p.cnum = c.cnum and p.cnum = t.cnum and "
        				+ "c.cnum = t.cnum and p.tnum = t.tnum";		//pnum 상관없이 뽑아냄*/
            		
            		rs.close();
            		pstmt.close();
            		do {
            			partylist.add(rs2.getInt("pnum"));
            			System.out.println("내가 속해있는 파티 없음: pnum---->"+ rs2.getInt("pnum"));
            		} while (rs2.next()); 	//rs2에 저장되어 있던 pnum 그대로 뽑아옴
          
            		
            		
	            }
	            
	            
			} else {
				//return partylist;	//추천할 카페 없음
			}
			
            
            	
		} catch(Exception e) {
			e.getMessage();
		} finally {
			 if(rs!=null) rs.close();
	         if(pstmt!=null) pstmt.close();
	         if(conn!=null) conn.close();
		}
		return partylist;
	}

	//상세정보에서 파티찾기
	public Party partyinfo(int pnum) throws SQLException {
		Party party = new Party();
		Connection conn = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; ResultSet rs4 = null;
		ResultSet rs5 = null; ResultSet rs6 = null;
		//sql1 = 게시판 형식으로 출력
		 String sql1 = "select * from party where pnum=?";
		 //sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		 String sql2 = "select * from cafe where cnum=?";
		 //sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		 String sql3 = "select * from theme where cnum=? and tnum=?";
		 //sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		 String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		 //sql5 = 파티장 이름
		 String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		 //sql6 = 평점
		 String sql6 = "select count(*), avg(rate) from review where cnum=?";
		try {
			conn = getConn();
			pstmt1 = conn.prepareStatement(sql1);
			pstmt1.setInt(1, pnum);
			rs1 = pstmt1.executeQuery();
			if (rs1.next()) {
				
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setInt(1, rs1.getInt("cnum"));
				rs2 = pstmt2.executeQuery();
				if(rs2.next()){
					party.setTnum(rs1.getInt("tnum"));
					party.setCname(rs2.getString("cname"));
					party.setCaddress(rs2.getString("caddress"));
					party.setContent(rs2.getString("content"));
					party.setType(rs2.getString("type"));
					party.setOpen(rs2.getInt("open"));
					party.setClose(rs2.getInt("close"));
					party.setPrice(rs1.getInt("point"));
					party.setRedprice(rs2.getInt("redprice"));
					party.setImage1(rs2.getString("image1"));
					party.setImage2(rs2.getString("image2"));
					}
				pstmt3 = conn.prepareStatement(sql3);
				pstmt3.setInt(1, rs1.getInt("cnum"));
				pstmt3.setInt(2, rs1.getInt("tnum"));
				rs3 = pstmt3.executeQuery();
				if(rs3.next()){
					party.setTname(rs3.getString("tname"));
					party.setImage3(rs3.getString("timage"));
					party.setTcontent(rs3.getString("tcontent"));
				}
				party.setCnum(rs1.getInt("cnum"));
				party.setPnum(rs1.getInt("pnum"));
				party.setPreg_date(rs1.getDate("preg_date"));
				party.setHopedate(rs1.getString("hopedate"));
				party.setHopehour(rs1.getInt("hopehour"));
				party.setMax(rs1.getInt("max"));
				party.setPcontent(rs1.getString("pcontent"));
				pstmt4 = conn.prepareStatement(sql4);
				pstmt4.setInt(1, rs1.getInt("pnum"));
				pstmt4.setString(2, "1");
				rs4 = pstmt4.executeQuery();
				if(rs4.next()){
					party.setPmcount(rs4.getInt(1));
				}
				pstmt5 = conn.prepareStatement(sql5);
				pstmt5.setInt(1, rs1.getInt("pnum"));
				pstmt5.setString(2, "1");
				rs5 = pstmt5.executeQuery();
				if(rs5.next()){
					party.setId(rs5.getString("id"));
				}
				pstmt6 = conn.prepareStatement(sql6);
				pstmt6.setInt(1, rs1.getInt("cnum"));
				rs6 = pstmt6.executeQuery();
				if(rs6.next()){
					party.setReviewCount(rs6.getInt(1));
					party.setReviewAvg(rs6.getDouble(2));
					}
			}
		} catch(Exception e) {	System.out.println(e.getMessage()); 
		} finally {	
			if(rs5!=null)rs5.close();
			if(pstmt5!=null)pstmt5.close();
			if(rs4!=null)rs4.close();
			if(pstmt4!=null)pstmt4.close();
			if(rs3!=null)rs3.close();
			if(pstmt3!=null)pstmt3.close();
			if(rs2!=null)rs2.close();
			if(pstmt2!=null)pstmt2.close();
			if (rs1 !=null) rs1.close();
			if (pstmt1 != null) pstmt1.close();
			if (conn !=null) conn.close();
		}
		return party;
	}
	//추천 파티 목록 partyInfoSelect.jsp
	public List<Party> partyRecommendShow(String[] pnumlist) throws SQLException {
		List<Party> list = new ArrayList<Party>();
		Connection conn = null;
		PreparedStatement pstmt1 = null; PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null; PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null; PreparedStatement pstmt6 = null;
		ResultSet rs1 = null; ResultSet rs2 = null; ResultSet rs3 = null; 
		ResultSet rs4 = null; ResultSet rs5 = null; ResultSet rs6 = null;
		//sql1 = 큰 pnum부터 출력
		String sql1 = "select * from party where pnum=? order by pnum desc";
		//sql2 = 각 파티가 가는 카페 정보 - 파티에 입력된 카페 번호 기준
		String sql2 = "select * from cafe where cnum=?";
		//sql3 = 각 파티가 가는 테마 정보 - 카페+테마 번호 기준
		String sql3 = "select * from theme where cnum=? and tnum=?";
		//sql4 = 파티 현재인원 수 - 파티장(pmnum=1)제외
		String sql4 = "select count(*) from partymem where pnum=? and pmnum!=?";
		//sql5 = 파티장 이름
		String sql5 = "select * from member where member.id=(select id from partymem where pnum=? and pmnum=?)";
		//sql6 = 평점
		String sql6 = "select count(*), avg(rate) from review where cnum=?";
		 try {
				conn = getConn();
				for(int i=0;i<pnumlist.length;i++){
					Party party = new Party();
					pstmt1 = conn.prepareStatement(sql1);
					pstmt1.setInt(1, Integer.parseInt(pnumlist[i]));
					rs1 = pstmt1.executeQuery();
					while (rs1.next()) {
						pstmt2 = conn.prepareStatement(sql2);
						pstmt2.setInt(1, rs1.getInt("cnum"));
						rs2 = pstmt2.executeQuery();
						while(rs2.next()){
							party.setTnum(rs1.getInt("tnum"));
							party.setCname(rs2.getString("cname"));
							party.setCaddress(rs2.getString("caddress"));
							party.setContent(rs2.getString("content"));
							party.setType(rs2.getString("type"));
							party.setOpen(rs2.getInt("open"));
							party.setClose(rs2.getInt("close"));
							party.setPrice(rs1.getInt("point"));
							party.setRedprice(rs2.getInt("redprice"));
							party.setImage1(rs2.getString("image1"));
							party.setImage2(rs2.getString("image2"));
							}
						pstmt3 = conn.prepareStatement(sql3);
						pstmt3.setInt(1, rs1.getInt("cnum"));
						pstmt3.setInt(2, rs1.getInt("tnum"));
						rs3 = pstmt3.executeQuery();
						while(rs3.next()){
							party.setTname(rs3.getString("tname"));
							party.setImage3(rs3.getString("timage"));
							party.setTcontent(rs3.getString("tcontent"));
						}
						party.setCnum(rs1.getInt("cnum"));
						party.setPnum(rs1.getInt("pnum"));
						party.setPreg_date(rs1.getDate("preg_date"));
						party.setHopedate(rs1.getString("hopedate"));
						party.setHopehour(rs1.getInt("hopehour"));
						party.setMax(rs1.getInt("max"));
						party.setPcontent(rs1.getString("pcontent"));
						pstmt4 = conn.prepareStatement(sql4);
						pstmt4.setInt(1, rs1.getInt("pnum"));
						pstmt4.setString(2, "1");
						rs4 = pstmt4.executeQuery();
						while(rs4.next()){
							party.setPmcount(rs4.getInt(1));
						}
						pstmt5 = conn.prepareStatement(sql5);
						pstmt5.setInt(1, rs1.getInt("pnum"));
						pstmt5.setString(2, "1");
						rs5 = pstmt5.executeQuery();
						while(rs5.next()){
							party.setId(rs5.getString("id"));
						}
						pstmt6 = conn.prepareStatement(sql6);
						pstmt6.setInt(1, rs1.getInt("cnum"));
						rs6 = pstmt6.executeQuery();
						while(rs6.next()){
							party.setReviewCount(rs6.getInt(1));
							party.setReviewAvg(rs6.getDouble(2));
							}
						}
					list.add(party);
					}
			} catch(Exception e) {	System.out.println(e.getMessage()); 
			} finally {	
				if(rs5!=null)rs5.close();
				if(pstmt5!=null)pstmt5.close();
				if(rs4!=null)rs4.close();
				if(pstmt4!=null)pstmt4.close();
				if(rs3!=null)rs3.close();
				if(pstmt3!=null)pstmt3.close();
				if(rs2!=null)rs2.close();
				if(pstmt2!=null)pstmt2.close();
				if (rs1 !=null) rs1.close();
				if (pstmt1 != null) pstmt1.close();
				if (conn !=null) conn.close();
			}
			return list;
		}
	public int pmemUpdatePoint(int pnum, int point) throws SQLException {
		MemberDAO md = MemberDAO.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0, result1 = 0;
		String sql = "select id from partymem where pnum=?";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do{
					result = md.updateMemberPoint(point, rs.getString("id"));
					if(result == 0) {	//포인트 반환에서 문제가 발생시
						break;
					}
					
				} while(rs.next());
			}
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			 if(rs!=null) rs.close();
	         if(pstmt!=null) pstmt.close();
	         if(conn!=null) conn.close();
		}
		
		return result;
	}
	
}