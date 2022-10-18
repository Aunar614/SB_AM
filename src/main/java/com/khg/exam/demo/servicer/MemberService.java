package com.khg.exam.demo.servicer;

import org.springframework.stereotype.Service;

import com.khg.exam.demo.repository.MemberRepository;

@Service
public class MemberService {
	private MemberRepository memberRepository;
	
	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
		
	public void join(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNum, email);
	}

}
