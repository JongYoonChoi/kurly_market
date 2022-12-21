package project.dto;
/*
이름          널?       유형            
----------- -------- ------------- 
U_ID        NOT NULL VARCHAR2(20)  
U_NAME      NOT NULL VARCHAR2(20)  
U_PW        NOT NULL VARCHAR2(100) 
U_ADDRESS_U NOT NULL NUMBER        
U_ADDRESS_D NOT NULL NUMBER        
U_ADDRESS_N NOT NULL VARCHAR2(20)  
U_PHONE     NOT NULL VARCHAR2(50)  
U_MAIL      NOT NULL VARCHAR2(100) 
U_STATUS    NOT NULL NUMBER(10)   
 */
public class MemberDTO {
	private String uId;
	private String uName;
	private String uPw;
	private String uAddressU;
	private String uAddressD;
	private String uAddressN;
	private String uPhone;
	private String uEmail;
	private int uStatus;
	
	
	public MemberDTO() {
		
	}


	public String getuId() {
		return uId;
	}


	public void setuId(String uId) {
		this.uId = uId;
	}


	public String getuName() {
		return uName;
	}


	public void setuName(String uName) {
		this.uName = uName;
	}


	public String getuPw() {
		return uPw;
	}


	public void setuPw(String uPw) {
		this.uPw = uPw;
	}


	public String getuAddressU() {
		return uAddressU;
	}


	public void setuAddressU(String uAddressU) {
		this.uAddressU = uAddressU;
	}


	public String getuAddressD() {
		return uAddressD;
	}


	public void setuAddressD(String uAddressD) {
		this.uAddressD = uAddressD;
	}


	public String getuAddressN() {
		return uAddressN;
	}


	public void setuAddressN(String uAddressN) {
		this.uAddressN = uAddressN;
	}


	public String getuPhone() {
		return uPhone;
	}


	public void setuPhone(String uPhone) {
		this.uPhone = uPhone;
	}


	public String getuEmail() {
		return uEmail;
	}


	public void setuEmail(String uEmail) {
		this.uEmail = uEmail;
	}


	public int getuStatus() {
		return uStatus;
	}


	public void setuStatus(int uStatus) {
		this.uStatus = uStatus;
	}


	


	
	

	

	
	

	
	
	
	
	
}
