package com.khg.exam.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.khg.exam.demo.repository.BoardRepository;
import com.khg.exam.demo.vo.Board;

@Service
public class BoardService {

	@Autowired
	private BoardRepository boardRepository;

	public BoardService(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;

	}
	
	public Board getBoardById(int id) {
		return boardRepository.getBoardById(id);
	}
}
