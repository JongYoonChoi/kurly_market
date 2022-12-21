package project.dto;

/*
이름        널?       유형            
--------- -------- ------------- 
P_NO      NOT NULL NUMBER(10)    - 글번호  
P_DATE    NOT NULL DATE          - 작성일자   
P_ID      NOT NULL VARCHAR2(20)  - 작성자(아이디) 
P_ITEM    NOT NULL VARCHAR2(100) - 상품명
P_AMOUNT  NOT NULL NUMBER(4)     - 주문개수
P_ADDRESS NOT NULL VARCHAR2(300) - 주소
P_STATUS           NUMBER(1)     - 상태 : 0(배송준비), 1(배송중), 2(배송완료) 
P_MSG              VARCHAR2(200) - 요청사항
P_IMG     		   VARCHAR2(500) - 사진
P_PRICE 		   VARCHAR2(100) - 가격
*/

public class PayDTO {
	private int pno;
	private String pdate;	
	private String pid;
	private String pitem;
	private int pamount;
	private String paddress;	
	private int pstatus;
	private String Pmsg;
	private String pImg;
	private int pPrice;
	private String total;
	
	public PayDTO() {
		// TODO Auto-generated constructor stub
	}

	
	public PayDTO(int pno, String pdate, String pid, String pitem, int pamount, String paddress, int pstatus,
			String pmsg, String pImg, int pPrice) {
		super();
		this.pno = pno;
		this.pdate = pdate;
		this.pid = pid;
		this.pitem = pitem;
		this.pamount = pamount;
		this.paddress = paddress;
		this.pstatus = pstatus;
		Pmsg = pmsg;
		this.pImg = pImg;
		this.pPrice = pPrice;
	}
	
	
	
	public String getTotal() {
		return total;
	}


	public void setTotal(String total) {
		this.total = total;
	}


	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getPdate() {
		return pdate;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPitem() {
		return pitem;
	}

	public void setPitem(String pitem) {
		this.pitem = pitem;
	}

	public int getPamount() {
		return pamount;
	}

	public void setPamount(int pamount) {
		this.pamount = pamount;
	}

	public String getPaddress() {
		return paddress;
	}

	public void setPaddress(String paddress) {
		this.paddress = paddress;
	}

	public int getPstatus() {
		return pstatus;
	}

	public void setPstatus(int pstatus) {
		this.pstatus = pstatus;
	}

	public String getPmsg() {
		return Pmsg;
	}

	public void setPmsg(String pmsg) {
		Pmsg = pmsg;
	}
	public String getpImg() {
		return pImg;
	}

	public void setpImg(String pImg) {
		this.pImg = pImg;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

}