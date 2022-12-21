package project.dto;
/*
 * 이름       널?       유형            
-------- -------- ------------- 
P_NO     NOT NULL NUMBER(10)    
P_NAME   NOT NULL VARCHAR2(100) 
P_IMG    NOT NULL VARCHAR2(500) 
P_IMG_D1 NOT NULL VARCHAR2(500) 
P_IMG_D2 NOT NULL VARCHAR2(500) 
P_PRICE  NOT NULL NUMBER(20)    
P_KINDS  NOT NULL VARCHAR2(100) 
P_STOCK  NOT NULL NUMBER(20)    
 */

public class ProductDTO {
	private int pNo;
	private String pName;
	private String pImg;
	private String pImgD1;
	private String pImgD2;
	private int pPrice;
	private String pKinds;
	private int pStock;
	
	public ProductDTO() {

	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getpImg() {
		return pImg;
	}

	public void setpImg(String pImg) {
		this.pImg = pImg;
	}

	public String getpImgD1() {
		return pImgD1;
	}

	public void setpImgD1(String pImgD1) {
		this.pImgD1 = pImgD1;
	}

	public String getpImgD2() {
		return pImgD2;
	}

	public void setpImgD2(String pImgD2) {
		this.pImgD2 = pImgD2;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

	public String getpKinds() {
		return pKinds;
	}

	public void setpKinds(String pKinds) {
		this.pKinds = pKinds;
	}

	public int getpStock() {
		return pStock;
	}

	public void setpStock(int pStock) {
		this.pStock = pStock;
	}
	
	
	
	
	
	
	
	
}
