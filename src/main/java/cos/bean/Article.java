package cos.bean;

public class Article {
    private Integer pId;
	
	private Integer course;

    private Integer department;

    private Integer subject;

    private String articleName;

    private String articleSrc;

    private Integer contidion;

    private Integer startInstitute;

    private Integer institute;

    private String teacher;
    
    public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}

    public Integer getCourse() {
        return course;
    }

    public void setCourse(Integer course) {
        this.course = course;
    }

    public Integer getDepartment() {
        return department;
    }

    public void setDepartment(Integer department) {
        this.department = department;
    }

    public Integer getSubject() {
        return subject;
    }

    public void setSubject(Integer subject) {
        this.subject = subject;
    }

    public String getArticleName() {
        return articleName;
    }

    public void setArticleName(String articleName) {
        this.articleName = articleName;
    }

    public String getArticleSrc() {
        return articleSrc;
    }

    public void setArticleSrc(String articleSrc) {
        this.articleSrc = articleSrc;
    }

    public Integer getContidion() {
        return contidion;
    }

    public void setContidion(Integer contidion) {
        this.contidion = contidion;
    }

    public Integer getStartInstitute() {
        return startInstitute;
    }

    public void setStartInstitute(Integer startInstitute) {
        this.startInstitute = startInstitute;
    }

    public Integer getInstitute() {
        return institute;
    }

    public void setInstitute(Integer institute) {
        this.institute = institute;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {
        this.teacher = teacher;
    }

	@Override
	public String toString() {
		return "Article [pId=" + pId + ", course=" + course + ", department=" + department + ", subject=" + subject
				+ ", articleName=" + articleName + ", articleSrc=" + articleSrc + ", contidion=" + contidion
				+ ", startInstitute=" + startInstitute + ", institute=" + institute + ", teacher=" + teacher + "]";
	}

	
    
}