package com.fpjt.upmu.document.model.service;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.document.model.vo.Document;

public interface DocService {

	List<Document> selectDocList(Map<String, Object> param);

	List<Document> selectDocLineList(int id);

}
