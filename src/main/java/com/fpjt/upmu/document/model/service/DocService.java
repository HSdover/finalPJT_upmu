package com.fpjt.upmu.document.model.service;

import java.util.List;
import java.util.Map;

import com.fpjt.upmu.document.model.vo.DocAttach;
import com.fpjt.upmu.document.model.vo.DocLine;
import com.fpjt.upmu.document.model.vo.Document;

public interface DocService {

	List<Document> selectDocLineList(int id);

	Document selectOneDocument(String docNo);

	int updateDocument(Map<String, Object> param);

	int updateMyDocLineStatus(DocLine docLine);

	int updateOthersDocLineStatus(DocLine docLine);

	List<String> selectDocNo(Map<String, Object> param);

	Document selectOneDocumentByParam(Map<String, Object> param);

	int insertDocument(Document document, List<DocAttach> attachList);

	int insertDocLine(DocLine docLine);

	int insertDocAttach(DocAttach docAttach);
}
