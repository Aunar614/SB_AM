package com.khg.exam.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khg.exam.demo.service.ReactionPointService;
import com.khg.exam.demo.vo.ResultData;
import com.khg.exam.demo.vo.Rq;

@Controller
public class UsrReactionPointController {

	@Autowired
	private ReactionPointService reactionPointService;
	@Autowired
	private Rq rq;

	@RequestMapping("/usr/reactionPoint/doGoodReaction")
	@ResponseBody
	public String doGoodReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReactionRd = reactionPointService
				.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		if (actorCanMakeReactionRd.isFail()) {
			return rq.jsHistoryBackOnView(actorCanMakeReactionRd.getMsg());
		}

		reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace("좋아요!", replaceUri);
	}
	

	@RequestMapping("/usr/reactionPoint/doBadReaction")
	@ResponseBody
	public String doBadReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReactionRd = reactionPointService
				.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		if (actorCanMakeReactionRd.isFail()) {
			return rq.jsHistoryBackOnView(actorCanMakeReactionRd.getMsg());
		}

		reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace("싫어요!", replaceUri);
	}
	
	@RequestMapping("/usr/reactionPoint/doCancelGoodReaction")
	@ResponseBody
	public String doCancelGoodReaction(String relTypeCode, int relId, String replaceUri) {
		
		ResultData actorCanMakeReactionRd = reactionPointService
				.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);
		
		if (actorCanMakeReactionRd.isSuccess()) {
			return rq.jsHistoryBackOnView("처리할 수 없습니다");
		}
		
		reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		
		return rq.jsReplace("좋아요 취소!", replaceUri);
	}

	@RequestMapping("/usr/reactionPoint/doCancelBadReaction")
	@ResponseBody
	public String doCancelBadReaction(String relTypeCode, int relId, String replaceUri) {
		
		ResultData actorCanMakeReactionRd = reactionPointService
				.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);
		
		if (actorCanMakeReactionRd.isSuccess()) {
			return rq.jsHistoryBackOnView("처리할 수 없습니다");
		}
		
		reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		
		return rq.jsReplace("싫어요 취소!", replaceUri);
	}

}
