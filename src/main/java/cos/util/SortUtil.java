package cos.util;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import cos.bean.Course;

public class SortUtil {
	public static void sortCourse(List<Course> courses) {
		Collections.sort(courses, new Comparator<Course>() {
			@Override
			public int compare(Course o1, Course o2) {
				return o1.getPriority()-o2.getPriority();
			}
		});
	}
}
