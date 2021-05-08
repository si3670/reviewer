package com.sbs.untact2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.untact2.dao.ReplyDao;
import com.sbs.untact2.dto.Reply;
import com.sbs.untact2.dto.ResultData;

@Service
public class ReplyService {
	@Autowired
	private ReplyDao replyDao;

	public ResultData write(String relTypeCode, int relId, int memberId, String body) {
		replyDao.write(relTypeCode, relId, memberId, body);
		int id = replyDao.getLastInsertId();

		return new ResultData("S-1", "댓글이 작성되었습니다.", "id", id);
	}

	public List<Reply> getForPrintRepliesByRelTypeCodeAndRelId(String relTypeCode, int relId) {
		return replyDao.getForPrintRepliesByRelTypeCodeAndRelId(relTypeCode, relId);
	}

}
