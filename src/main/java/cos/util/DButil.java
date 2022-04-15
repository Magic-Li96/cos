package cos.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

public final class DButil {

	public static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";

	public static final String DB_URL = "jdbc:mysql://localhost:3306/cos";

	public static final String USER = "root";

	public static final String PASS = "9999986";

	// 备份数据库文件
	public static void backup(String filePath){

		try {
			Runtime rt = Runtime.getRuntime();
			Process child = rt.exec("mysqldump -hlocalhost -u"+USER+" -p"+PASS+" cos");
			InputStream in = child.getInputStream();// 控制台的输出信息作为输入流
			InputStreamReader xx = new InputStreamReader(in, "utf8");// 设置输出流编码为utf8。这里必须是utf8，否则从流中读入的是乱码
			String inStr;
			StringBuffer sb = new StringBuffer("");
			String outStr;
			// 组合控制台输出信息字符串
			BufferedReader br = new BufferedReader(xx);
			while ((inStr = br.readLine()) != null) {
				sb.append(inStr + "\r\n");
			}
			outStr = sb.toString();// 备份出来的内容是一个字条串
			// 要用来做导入用的sql目标文件：
			FileOutputStream fout = new FileOutputStream(filePath);
			OutputStreamWriter writer = new OutputStreamWriter(fout, "utf8");
			writer.write(outStr);// 写文件
			// 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免
			writer.flush();
			// 别忘记关闭输入输出流
			in.close();
			xx.close();
			br.close();
			writer.close();
			fout.close();
			System.out.println("backup success");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 恢复数据库文件
	public static void load(String filePath) {
		try {
			Runtime rt = Runtime.getRuntime();
			Process child = rt.exec("mysql -u"+USER+" -p"+PASS+" cos");
			OutputStream out = child.getOutputStream();// 控制台的输入信息作为输出流
			String inStr;
			StringBuffer sb = new StringBuffer("");
			String outStr;
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "utf8"));
			while ((inStr = br.readLine()) != null) {
				sb.append(inStr + "\r\n");
			}
			outStr = sb.toString();
			OutputStreamWriter writer = new OutputStreamWriter(out, "utf8");
			writer.write(outStr);
			// 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免
			writer.flush();
			out.close();
			br.close();
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}