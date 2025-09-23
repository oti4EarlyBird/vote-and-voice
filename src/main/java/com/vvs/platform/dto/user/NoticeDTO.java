package com.vvs.platform.dto.user;

import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
public class NoticeDTO {
	private int seqNotices;
    private String title;
    private String content;
    private String category;
    private String isPinned;
    private Date postDate;
    private String writer;
    private int viewnum;
}
