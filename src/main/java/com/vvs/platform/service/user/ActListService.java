package com.vvs.platform.service.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vvs.platform.dao.user.ActListDAO;
import com.vvs.platform.dto.user.ActListDTO;
import com.vvs.platform.dto.user.NoticeDTO;

@Service
public class ActListService {
	@Autowired
	private ActListDAO actlistDAO;
	
		// 카테고리에 맞춰 글 갯수를 가져옴
		public int getActTotalCount(String category) {
		System.out.println("Service totalCOunt : " + category);
		System.out.println(actlistDAO.getActTotalCount(category));
			return actlistDAO.getActTotalCount(category);
		}
		
		// 카테고리에 맞춘 페이징된 글 목록 가져옴
		public List<ActListDTO> getActList(Map<String, Object> map) {
			System.out.println(actlistDAO.getActList(map));
			return actlistDAO.getActList(map);
		}
}
