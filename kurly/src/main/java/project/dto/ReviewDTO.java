package project.dto;

/*
 이름        널?       유형             
--------- -------- -------------- 
R_PNO     NOT NULL NUMBER(10)     - 상품번호
R_NO      NOT NULL NUMBER(10)     - 글번호
P_USER    NOT NULL VARCHAR2(20)   - 작성자
P_TITLE   NOT NULL VARCHAR2(500)  - 제목
P_CONTENT NOT NULL VARCHAR2(1000) - 내용
P_DATE    NOT NULL DATE   		  - 작성날짜
 */

public class ReviewDTO {
	private int rPno;
	private int rNo;
	private String pUser;
	private String pTitle;
	private String pContent;
	private String pDate;
	


	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}

	public ReviewDTO(int rPno, int rNo, String pUser, String pTitle, String pContent, String pDate) {
		super();
		this.rPno = rPno;
		this.rNo = rNo;
		this.pUser = pUser;
		this.pTitle = pTitle;
		this.pContent = pContent;
		this.pDate = pDate;
	}


	public int getrPno() {
		return rPno;
	}

	public void setrPno(int rPno) {
		this.rPno = rPno;
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public String getpUser() {
		return pUser;
	}

	public void setpUser(String pUser) {
		this.pUser = pUser;
	}

	public String getpTitle() {
		return pTitle;
	}

	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}

	public String getpContent() {
		return pContent;
	}

	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	
	public String getpDate() {
		return pDate;
	}

	public void setpDate(String pDate) {
		this.pDate = pDate;
	}

	
}
