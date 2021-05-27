package com.sbs.untact2.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.Board;
import com.sbs.untact2.dto.GenFile;
import com.sbs.untact2.dto.Reply;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.dto.Rq;
import com.sbs.untact2.service.ArticleService;
import com.sbs.untact2.service.GenFileService;
import com.sbs.untact2.service.ReplyService;
import com.sbs.untact2.util.Util;

@Controller
public class MpaUsrWineController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private GenFileService genFileService;

	@RequestMapping("/mpaUsr/article/winewrite")
	public String showWineWrite(HttpServletRequest req, @RequestParam(defaultValue = "3") int boardId) {
		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return Util.msgAndBack(req, "존재하지않는 게시판 입니다.");
		}

		req.setAttribute("board", board);
		return "mpaUsr/article/winewrite";
	}

	@RequestMapping("/mpaUsr/article/doWineWrite")
	public String doWineWrite(HttpServletRequest req, int boardId, String title, String body, String wineKinds,
			String wineCountry, String winePlace, int wineVintage, String wineVariety, String wineAlcohol,
			String wineML, String winePrice, MultipartRequest multipartRequest) {

		Rq rq = (Rq) req.getAttribute("rq");
		int memberId = rq.getLoginedMemberId();
		ResultData writeWineRd = articleService.writeWine(memberId, boardId, title, body, wineKinds, wineCountry,
				winePlace, wineVintage, wineVariety, wineAlcohol, wineML, winePrice);

		if (writeWineRd.isFail()) {
			return Util.msgAndBack(req, writeWineRd.getMsg());
		}
		
		// newArticleId = 새 게시물 번호
		// 게시글이 만들어진 후 파일 작업 시작, relid가 정해져야 하기 때문
		int newArticleId = (int) writeWineRd.getBody().get("id");

		// 파일맵으로 정리
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			// 파일이 비어있지 않을 때 save , multipartFile의 관련된 것은 newArticleId이란 게시글이다
			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, newArticleId);
			}
		}
		

		return Util.msgAndReplace(req, writeWineRd.getMsg(),
				"../article/winedetail?id=" + writeWineRd.getBody().get("id"));
	}

	// wine 정보 보여주기
	@RequestMapping("/mpaUsr/article/winedetail")
	public String showDetail(Integer id, HttpServletRequest req, @RequestParam(defaultValue = "3") int boardId
			) {
		articleService.increaseArticleHit(id);
		Article article = articleService.getArticleForPrintById(id);
		List<Reply> replies = replyService.getForPrintRepliesByRelTypeCodeAndRelId("article", id);
		
		List<GenFile> files = genFileService.getGenFiles("article", article.getId(), "common", "attachment");

		Map<String, GenFile> filesMap = new HashMap<>();

		for (GenFile file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		article.getExtraNotNull().put("file__common__attachment", filesMap);
		

		if (article == null) {
			return Util.msgAndBack(req, "해당 게시글이 존재하지 않습니다.");
		}

		Board board = articleService.getBoardById(article.getBoardId());

		int replyTotalCount = replyService.getReplyTotalCount("article", id);

		req.setAttribute("replyTotalCount", replyTotalCount);

		req.setAttribute("replies", replies);
		req.setAttribute("article", article);
		req.setAttribute("board", board);

		return "mpaUsr/article/winedetail";
	}

	@RequestMapping("/mpaUsr/article/winelist")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "3") int boardId,
			@RequestParam(defaultValue = "1") int page, String searchKeyword,
			@RequestParam(defaultValue = "titleAndBody") String searchKeywordType) {
		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return Util.msgAndBack(req, "존재하지않는 게시판 입니다.");
		}

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "titleAndBody";
		}

		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}

		req.setAttribute("board", board);

		int totalCount = articleService.getArticlesTotalCount(boardId, searchKeyword, searchKeywordType);

		req.setAttribute("totalCount", totalCount);

		int itemsInAPage = 8;
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);

		req.setAttribute("page", page);
		req.setAttribute("totalPage", totalPage);

		List<Article> articles = articleService.getForPrintArticles(boardId, page, itemsInAPage, searchKeyword,
				searchKeywordType);
		
		for ( Article article : articles ) {
			GenFile genFile = genFileService.getGenFile("article", article.getId(), "common", "attachment", 1);

			if ( genFile != null ) {
				article.setExtra__thumbImg(genFile.getForPrintUrl());
			}
		}

		req.setAttribute("articles", articles);

		return "mpaUsr/article/winelist";
	}
	
	@RequestMapping("/mpaUsr/article/doWineDelete")
	public String doDelete(Integer id, HttpServletRequest req) {
		if (Util.isEmpty(id)) {
			return Util.msgAndBack(req, "id을 입력해주세요.");
		}

		ResultData rd = articleService.deleteArticleById(id);

		if (rd.isFail()) {
			return Util.msgAndBack(req, rd.getMsg());
		}
		String replaceUri = "../article/list?boardId=" + rd.getBody().get("boardId");
		return Util.msgAndReplace(req, rd.getMsg(), replaceUri);
	}
	
	

}
