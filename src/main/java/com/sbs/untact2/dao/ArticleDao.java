package com.sbs.untact2.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.Board;

@Mapper
public interface ArticleDao {

	boolean modifyArticle(@Param("id") int id, @Param("title") String title, @Param("body") String body);

	void writeArticle(@Param("boardId")int boardId, @Param("memberId")int memberId, @Param("title") String title, @Param("body") String body);

	Article getArticleById(@Param("id") int id);
	
	int getLastInsertId();

	void deleteArticleById(@Param("id") int id);

	Board getBoardById(@Param("id")int id);

	int getArticlesTotalCount(@Param("boardId")int boardId, @Param("searchKeyword") String searchKeyword, @Param("searchKeywordType") String searchKeywordType);

	List<Article> getForPrintArticles(@Param("boardId")int boardId, @Param("limitStart")int limitStart, @Param("limitTake")int limitTake,@Param("searchKeyword") String searchKeyword, @Param("searchKeywordType") String searchKeywordType);

	void increaseArticleHit(@Param("id")int id);

}
