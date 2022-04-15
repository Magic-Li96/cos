package cos.util;

import com.alibaba.fastjson.JSONObject;

/**
 * 
 * @author li
 * 
 */
public class JsonResult {

	public static final String fail_condition = "500";
	public static final String success_condition = "200";

	public String byJsonStr(Object data, int condition) {
		if (String.valueOf(condition).equals(JsonResult.success_condition)) {
			Result result = new Result();
			result.setCondition(JsonResult.success_condition);
			result.setData(data);
			return JSONObject.toJSONString(result);
		} else {
			Result result = new Result();
			result.setCondition(JsonResult.fail_condition);
			result.setData(data);
			return JSONObject.toJSONString(result);
		}
	}

	class Result {
		Object data;
		String condition;

		public Object getData() {
			return data;
		}

		public void setData(Object data) {
			this.data = data;
		}

		public String getCondition() {
			return condition;
		}

		public void setCondition(String condition) {
			this.condition = condition;
		}

		@Override
		public String toString() {
			return "SuccessResult [data=" + data + ", condition=" + condition + "]";
		}
	}

}
