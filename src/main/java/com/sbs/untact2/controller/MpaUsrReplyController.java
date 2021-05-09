package com.sbs.untact2.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.Board;
import com.sbs.untact2.dto.Reply;
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
			if (article == null) {
				return Util.msgAndBack(req, "해당 게시물이 존재하지 않습니다.");
			}
			break;
		default:
			return Util.msgAndBack(req, "올바르지 않은 relTypeCode입니다.");
		}

		// 누가 썼는지 알기
		Rq rq = (Rq) req.getAttribute("rq");
		int memberId = rq.getLoginedMemberId();

		ResultData writeResultData = replyService.write(relTypeCode, relId, memberId, body);

		return Util.msgAndReplace(req, writeResultData.getMsg(), redirectUri);
	}

	@RequestMapping("/mpaUsr/reply/doDelete")
	public String doDelete(HttpServletRequest req, int id, String redirectUri) {
		Reply reply = replyService.getReplyById(id);

		if (reply == null) {
			return Util.msgAndBack(req, "존재하지 않는 댓글입니다.");
		}

		// 누가 썼는지 알기
		Rq rq = (Rq) req.getAttribute("rq");
		
		if(reply.getMemberId() != rq.getLoginedMemberId()) {
			return Util.msgAndBack(req, "권한이 없습니다.");
		}
		ResultData deleteResultData = replyService.delete(id);
		
		return Util.msgAndReplace(req, deleteResultData.getMsg(), redirectUri);

	}

}
