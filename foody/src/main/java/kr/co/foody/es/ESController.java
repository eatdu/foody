 package kr.co.foody.es;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.foody.admin.AdminService;
import kr.co.foody.comment.CommentService;
import kr.co.foody.comment.CommentVO;
import kr.co.foody.constants.IngredientCategory;
import kr.co.foody.constants.RecipeCategory;
import kr.co.foody.user.UserService;
import kr.co.foody.user.UserVO;
import util.ElasticSearch;

@Controller
public class ESController {

	@CrossOrigin
	@ResponseBody
	@GetMapping(value = "/esApi.do", produces = "application/json;charset=UTF-8")
	public String esSearch(@RequestParam String keyword) {
		try {
			return ElasticSearch.getMultiMatch("foody_recipe", keyword);
		} catch (Exception e) {
			return "error";
		}
	}
	
	@GetMapping("/es.do")
	public String esPage() {
		return "es/essearch";
	}
}
