package project.dto;
/*
이름       널?       유형            
-------- -------- ------------- 
CART_IDX NOT NULL VARCHAR2(20)  
U_ID     NOT NULL VARCHAR2(20)  
P_NO     NOT NULL NUMBER(10)    
QUANTITY NOT NULL NUMBER(5)     
P_IMG    NOT NULL VARCHAR2(500) 
P_NAME   NOT NULL VARCHAR2(100) 
P_PRICE  NOT NULL NUMBER        
*/

public class CartDTO {
	private String cartIdx;
	private String uId;
	private int pNo;
	private int quantity;
	private String pImg;
	private String pName;
	private int pPrice;
	private int total;
	private int deTotal;
	private int indTotal;
	
	
	public CartDTO() {
		
	}


	public String getCartIdx() {
		return cartIdx;
	}


	public void setCartIdx(String cartIdx) {
		this.cartIdx = cartIdx;
	}


	public String getuId() {
		return uId;
	}


	public void setuId(String uId) {
		this.uId = uId;
	}


	public int getpNo() {
		return pNo;
	}


	public void setpNo(int pNo) {
		this.pNo = pNo;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public String getpImg() {
		return pImg;
	}


	public void setpImg(String pImg) {
		this.pImg = pImg;
	}


	public String getpName() {
		return pName;
	}


	public void setpName(String pName) {
		this.pName = pName;
	}


	public int getpPrice() {
		return pPrice;
	}


	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}


	

	public int getTotal() {
		return total;
	}


	public void setTotal(int total) {
		this.total = total;
	}


	public int getDeTotal() {
		return deTotal;
	}


	public void setDeTotal(int deTotal) {
		this.deTotal = deTotal;
	}


	public int getIndTotal() {
		return indTotal;
	}


	public void setIndTotal(int indTotal) {
		this.indTotal = indTotal;
	}

	
	
	
	
	
	


	

	
	
	
	
	
}
