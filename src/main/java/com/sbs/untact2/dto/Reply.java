package com.sbs.untact2.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private String relTypeCode;
	private int relId;
	private int memberId;
	private int parentId;
	private String body;
	private boolean blindStatus;
	private String blindDate;
	private boolean delStatus;
	private String delDate;
	private int likeCount;
	private int dislikeCount;

	private String extra__writerName;

	public String getBodyForPrint() {
		String bodyForPrint = body.replaceAll("\r\n", "<br>");
		bodyForPrint = bodyForPrint.replaceAll("\r", "<br>");
		bodyForPrint = bodyForPrint.replaceAll("\n", "<br>");

		return bodyForPrint;
	}
	
	public String getWriterProfileImgUri() {
        return "/common/genFile/file/member/" + memberId + "/extra/profileImg/1";
    }

}
