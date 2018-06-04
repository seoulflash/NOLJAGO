package dao;

public class Good {
	private String id;
	private int cnum;
	private int tnum;
	private String like_yn;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public int getTnum() {
		return tnum;
	}
	public void setTnum(int tnum) {
		this.tnum = tnum;
	}
	public String getLike_yn() {
		return like_yn;
	}
	public void setLike_yn(String like_yn) {
		this.like_yn = like_yn;
	}
	
	// 카페번호로 카페테이블에서 카페이름, 카페타입
	// 테마번호로 테마테이블에서 테마이름, 테마이미지 가져오기 위한 추가
	private String cname;
	private String tname;
	private String timage;
	private String type;

	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTimage() {
		return timage;
	}
	public void setTimage(String timage) {
		this.timage = timage;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
