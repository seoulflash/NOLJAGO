package dao;

import java.util.Date;

public class Member {
	private String id;
	private String password;
	private int admin;
	private String name;
	private String birth;
	private String image;
	private String sex;
	private String address;
	private String email;
	private String tel;
	private String intro;
	private int point;
	private Date reg_date;
	private String mem_del_yn;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getAdmin() {
		return admin;
	}
	public void setAdmin(int admin) {
		this.admin = admin;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getMem_del_yn() {
		return mem_del_yn;
	}
	public void setMem_del_yn(String mem_del_yn) {
		this.mem_del_yn = mem_del_yn;
	}
	
	private int resTotCnt;
	private int totGood;
	private String totMsg;

	public int getResTotCnt() {
		return resTotCnt;
	}
	public void setResTotCnt(int resTotCnt) {
		this.resTotCnt = resTotCnt;
	}
	public int getTotGood() {
		return totGood;
	}
	public void setTotGood(int totGood) {
		this.totGood = totGood;
	}
	public String getTotMsg() {
		return totMsg;
	}
	public void setTotMsg(String totMsg) {
		this.totMsg = totMsg;
	}
}
