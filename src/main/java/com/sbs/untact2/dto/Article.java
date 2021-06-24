package com.sbs.untact2.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private int boardId;
	private int memberId;
	private String title;
	private String body;
	private boolean blindStatus;
	private String blindDate;
	private boolean delStatus;
	private String delDate;
	private int hitCount;
	private int repliesCount;
	private int likeCount;
	private int dislikeCount;
	
	//wine게시글
	private String wineKinds;
	private String wineCountry;
	private String winePlace;
	private int wineVintage;
	private String wineVariety;
	private String wineAlcohol;
	private String wineML;
	private String winePrice;

	
	private String extra__writer;
	private String extra__boardName;
	private String extra__thumbImg;
	
	public String getBodyForPrint() {
        String bodyForPrint = body.replaceAll("\r\n", "<br>");
        bodyForPrint = bodyForPrint.replaceAll("\r", "<br>");
        bodyForPrint = bodyForPrint.replaceAll("\n", "<br>");

        return bodyForPrint;
    }
	
	public String getWriterProfileImgUri() {
        return "/common/genFile/file/member/" + memberId + "/extra/profileImg/1";
    }

    public String getWriterProfileFallbackImgUri() {
        return "https://via.placeholder.com/300?text=^_^";
    }

    public String getWriterProfileFallbackImgOnErrorHtmlAttr() {
        return "this.src = '" + getWriterProfileFallbackImgUri() + "'";
    }
    
    private Map<String, Object> extra;

    public Map<String, Object> getExtraNotNull() {
		if ( extra == null ) {
			extra = new HashMap<String, Object>();
		}

		return extra;
	}

}
