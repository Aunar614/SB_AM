package com.khg.exam.demo.service;

import org.springframework.stereotype.Service;

import com.khg.exam.demo.repository.MemberRepository;
import com.khg.exam.demo.util.Ut;
import com.khg.exam.demo.vo.Member;
import com.khg.exam.demo.vo.ResultData;

@Service
public class MemberService {
	private MemberRepository memberRepository;
	
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
		
	public ResultData<Integer> join(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		// 로그인아이디 중복 체크
		Member existsMember = getMemberByLoginId(loginId);
		
		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용 중인 아이디(%s)입니다", loginId));
		}
		
		// 이름 + 이메일 중복체크
		existsMember = getMemberByNameAndEmail(name, email);
		
		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용 중인 이름(%s)과 이메일(%s)입니다", loginId, email));
		}
		
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		int id = memberRepository.getLastInsertId();
		
		return ResultData.from("S-1", "회원가입이 완료되었습니다", "id", id);
	}

	private Member getMemberByNameAndEmail(String name, String email) {

		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	public Member getMemberByLoginId(String loginId) {

		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {

		return memberRepository.getMemberById(id);
	}

}