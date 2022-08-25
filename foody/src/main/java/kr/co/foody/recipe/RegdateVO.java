package kr.co.foody.recipe;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RegdateVO {
	private int no;
	private int user_no;
	private int recipe_no;
	private Timestamp regdate;
}
