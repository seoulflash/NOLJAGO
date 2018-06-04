package dao;

import java.sql.Date;

public class Party {
	private int pnum;
	private int tnum;
	private int cnum;
	private Date preg_date;
	private String hopedate;
	private int hopehour;
	private int max;
	private String pcontent;
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getTnum() {
		return tnum;
	}
	public void setTnum(int tnum) {
		this.tnum = tnum;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public Date getPreg_date() {
		return preg_date;
	}
	public void setPreg_date(Date preg_date) {
		this.preg_date = preg_date;
	}
	public String getHopedate() {
		return hopedate;
	}
	public void setHopedate(String hopedate) {
		this.hopedate = hopedate;
	}
	public int getHopehour() {
		return hopehour;
	}
	public void setHopehour(int hopehour) {
		this.hopehour = hopehour;
	}
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	private String cname;
	private String caddress;
	private int open;
	private int close;
	private int price;
	private int redprice;
	private String type;
	private String content;
	private String image1;
	private String image2;
	private String image3;

	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCaddress() {
		return caddress;
	}
	public void setCaddress(String caddress) {
		this.caddress = caddress;
	}
	public int getOpen() {
		return open;
	}
	public void setOpen(int open) {
		this.open = open;
	}
	public int getClose() {
		return close;
	}
	public void setClose(int close) {
		this.close = close;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getRedprice() {
		return redprice;
	}
	public void setRedprice(int redprice) {
		this.redprice = redprice;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	private int pmnum;
	private int pmcount;
	private String id;
	private int pcount;
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public int getPmcount() {
		return pmcount;
	}
	public void setPmcount(int pmcount) {
		this.pmcount = pmcount;
	}
	public int getPmnum() {
		return pmnum;
	}
	public void setPmnum(int pmnum) {
		this.pmnum = pmnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	private String tname;
	private String tcontent;
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getTcontent() {
		return tcontent;
	}
	public void setTcontent(String tcontent) {
		this.tcontent = tcontent;
	}
	private int reviewCount;
	private double reviewAvg;
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public double getReviewAvg() {
		return reviewAvg;
	}
	public void setReviewAvg(double reviewAvg) {
		this.reviewAvg = reviewAvg;
	}

}
