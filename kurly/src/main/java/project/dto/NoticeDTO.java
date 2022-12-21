package project.dto;

/*
이름        널?       유형             
--------- -------- -------------- 
N_NO       NOT NULL NUMBER(10)      - 글번호       
N_TITLE    NOT NULL VARCHAR2(1000)  - 제목
N_CONTENT  NOT NULL VARCHAR2(2000) - 내용 
N_DATE     NOT NULL DATE           - 작성일자 
*/

public class NoticeDTO {
	private int nno;
	private String ntitle;
	private String ncontent;
	private String ndate;
	
	//기본 생성자(Default Constructor) : [Ctrl]+[Space] >> Constructor 선택
	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	//Getter & Setter : [Alt]+[Shift]+[S] >> [R] >> 필드 선택 >> Generate
	public int getNno() {
		return nno;
	}

	public void setNno(int nno) {
		this.nno = nno;
	}

	public String getNtitle() {
		return ntitle;
	}

	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}

	public String getNcontent() {
		return ncontent;
	}

	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}

	public String getNdate() {
		return ndate;
	}

	public void setNdate(String ndate) {
		this.ndate = ndate;
	}
}