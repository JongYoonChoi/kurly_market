package project.dto;

/*
이름        널?       유형             
--------- -------- -------------- 
Q_NO       NOT NULL NUMBER(10)      - 글번호   
Q_TITLE		        VARCHAR2(1000)  - 제목  
Q_CONTENT           VARCHAR2(2000)  - 내용     
Q_NAME              VARCHAR2(20)    - 작성자(아이디)    
Q_DATE         		DATE            - 작성일자     
REF                 NUMBER(4)       - 게시글 그룹번호
RE_STEP             NUMBER(4)       - 게시글 그룹의 내부 글순서
RE_LEVEL            NUMBER(4)       - 게시글 깊이
Q_STATUS            NUMBER(1)       - 상태 : 1(일반글), 2(비밀글) 
*/

public class QnaDTO {
	private int qno;
	private String qtitle;
	private String qcontent;
	private String qname;
	private String qdate;
	private int ref;
	private int reStep;
	private int reLevel;
	private int qstatus;
	
	public QnaDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getQno() {
		return qno;
	}

	public void setQno(int qno) {
		this.qno = qno;
	}

	public String getQtitle() {
		return qtitle;
	}

	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}

	public String getQcontent() {
		return qcontent;
	}

	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}

	public String getQname() {
		return qname;
	}

	public void setQname(String qname) {
		this.qname = qname;
	}

	public String getQdate() {
		return qdate;
	}

	public void setQdate(String qdate) {
		this.qdate = qdate;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getReStep() {
		return reStep;
	}

	public void setReStep(int reStep) {
		this.reStep = reStep;
	}

	public int getReLevel() {
		return reLevel;
	}

	public void setReLevel(int reLevel) {
		this.reLevel = reLevel;
	}

	public int getQstatus() {
		return qstatus;
	}

	public void setQstatus(int qstatus) {
		this.qstatus = qstatus;
	}
}