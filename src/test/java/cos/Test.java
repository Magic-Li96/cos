package cos;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import freemarker.core.ParseException;
import freemarker.template.Configuration;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;
import freemarker.template.TemplateNotFoundException;
import freemarker.template.Version;

public class Test {
	
	public static void an() throws Exception {
		Configuration configuration = new Configuration(new Version("2.3.23"));
		configuration.setDefaultEncoding("utf-8");
		//指定路径的第一种方式（根据某个类的相对路径指定）
		configuration.setClassForTemplateLoading(new Test().getClass(),"");
		//指定路径的第二种方式，我的路径是C：/a.ftl
		//configuration.setDirectoryForTemplateLoading(new File("c:/"));
		Template template = configuration.getTemplate("temp.ftl", "utf-8");
		//输出文档路径及名称
		File outFile = new File("bobo.doc");
		outFile.createNewFile();
		Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "utf-8"), 10240);
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("name","张三");
        dataMap.put("teacher", "0505");
        dataMap.put("institute", "计算机与人工智能学院");
        dataMap.put("subject", "软件工程");
        dataMap.put("abstract","..........................");
        dataMap.put("Lt", "priorCourse");
        dataMap.put("pt", "nextCourse");
        dataMap.put("idea", "department");
        dataMap.put("title", "institute");
        dataMap.put("methond", "courseQuality");
        dataMap.put("part", "courseTask");
        dataMap.put("ts", "courseTask");
        dataMap.put("cx", "courseTask");
        template.process(dataMap, out);
        out.flush();
        out.close();
	}
	
	public static void main(String[] args) throws Exception {
		new Test().an();
	}
}
