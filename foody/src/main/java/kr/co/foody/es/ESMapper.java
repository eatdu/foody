package kr.co.foody.es;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ESMapper {
	Map<String, Object> selectByNo(int no);
	List<Map<String, Object>> findIngresByNo(int no);
}