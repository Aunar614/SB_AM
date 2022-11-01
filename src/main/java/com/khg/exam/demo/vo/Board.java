package com.khg.exam.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	private int id;
	private String regData;
	private String updateDate;
	private String code;
	private String name;
	private boolean delStatus;
	private String delDate;
	
}
