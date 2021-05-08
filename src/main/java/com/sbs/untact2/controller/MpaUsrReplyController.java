package com.sbs.untact2.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.dto.Rq;
import com.sbs.untact2.service.ArticleService;
import com.sbs.untact2.service.ReplyService;
import com.sbs.untact2.util.Util;

@Controller
public class MpaUsrReplyController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;

	@RequestMapping("/mpaUsr/reply/doWrite")
	public String showWrite(HttpServletRequest req, String relTypeCode, int relId, String body, String redirectUri) {

		switch (relTypeCode) {
		case "article":
			Article article = articleService.getArticleById(relId);
			if(article == null) {
				return Util.msgAndBack(req, "해당 게시물이 존재하지 않습니다.");
			}
			break;
			default:
				return Util.msgAndBack(req, "올바르지 않은 relTypeCode입니다.");
		}
		
		//누가 썼는지 알기
		Rq rq = (Rq)req.getAttribute("rq");
		int memberId = rq.getLoginedMemberId();
		
		ResultData writeResultData = replyService.write(relTypeCode, relId, memberId, body);

		 return Util.msgAndReplace(req, writeResultData.getMsg(), redirectUri);
	}

}
