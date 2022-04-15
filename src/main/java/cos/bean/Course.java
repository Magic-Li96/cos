package cos.bean;

public class Course {
    private Integer pId;

	private Integer courseId;

    private Integer department;

    private Integer subject;

    private String courseName;

    private Integer institute;

    private Integer startInstitute;

    private Integer priority;

    private Integer allClassHours;

    private Double credit;

    private Integer courseType;

    public Integer getpId() {
		return pId;
	}

	public void setpId(Integer pId) {
		this.pId = pId;
	}
    
    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
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

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public Integer getInstitute() {
        return institute;
    }

    public void setInstitute(Integer institute) {
        this.institute = institute;
    }

    public Integer getStartInstitute() {
        return startInstitute;
    }

    public void setStartInstitute(Integer startInstitute) {
        this.startInstitute = startInstitute;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public Integer getAllClassHours() {
        return allClassHours;
    }

    public void setAllClassHours(Integer allClassHours) {
        this.allClassHours = allClassHours;
    }

    public Double getCredit() {
        return credit;
    }

    public void setCredit(Double credit) {
        this.credit = credit;
    }

    public Integer getCourseType() {
        return courseType;
    }

    public void setCourseType(Integer courseType) {
        this.courseType = courseType;
    }

	@Override
	public String toString() {
		return "Course [pId=" + pId + ", courseId=" + courseId + ", department=" + department + ", subject=" + subject
				+ ", courseName=" + courseName + ", institute=" + institute + ", startInstitute=" + startInstitute
				+ ", priority=" + priority + ", allClassHours=" + allClassHours + ", credit=" + credit + ", courseType="
				+ courseType + "]";
	}
    
}