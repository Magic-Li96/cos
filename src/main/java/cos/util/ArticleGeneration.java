package cos.util;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cos.bean.article.CourseContent;
import cos.bean.article.CourseTarget;
import cos.bean.article.Experiment;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.Version;

public class ArticleGeneration {
	
	public void generation(String fileName,String path,Map<String,Object> dataMap) throws Exception{
		Configuration configuration = new Configuration(new Version("2.3.23"));
		configuration.setDefaultEncoding("utf-8");
        //指定路径的第一种方式（根据某个类的相对路径指定）
		configuration.setClassForTemplateLoading(this.getClass(),"");
		//指定路径的第二种方式，我的路径是C：/a.ftl
		//configuration.setDirectoryForTemplateLoading(new File("c:/"));
        Template template = configuration.getTemplate("cTemp.ftl", "utf-8");
        //输出文档路径及名称
        File outFile = new File(path+fileName+".doc");
        outFile.createNewFile();
        Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile), "utf-8"), 10240);
        
        template.process(dataMap, out);
        out.flush();
        out.close();
	}
}
