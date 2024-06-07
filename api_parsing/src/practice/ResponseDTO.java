package practice;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ResponseDTO {
	private Response response;

	@NoArgsConstructor
	@AllArgsConstructor
	@Getter
	@Setter
	public class Response {

		private Body body;
		private Header header;

		@NoArgsConstructor
		@AllArgsConstructor
		@Getter
		@Setter
		public class Body {
			private int totalCount;
			private List<Item> items;
			private int pageNo;
			private int numOfRows;
		}

		@NoArgsConstructor
		@AllArgsConstructor
		@Getter
		@Setter
		public class Header {
			private String resultMsg;
			private String resultCode;
		}

		@NoArgsConstructor
		@AllArgsConstructor
		@Getter
		@Setter
		public class Item {
			private String clearVal;
			private String sn;
			private String districtName;
			private String dataDate;
			private String issueVal;
			private String issueTime;
			private String clearDate;
			private String issueDate;
			private String moveName;
			private String clearTime;
			private String issueGbn;
			private String itemCode;
		}
	}
}
