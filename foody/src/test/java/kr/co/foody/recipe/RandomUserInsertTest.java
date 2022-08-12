package kr.co.foody.recipe;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/config/servlet-context.xml")
@Log4j
public class RandomUserInsertTest {
	public static String[] emailArr =  {"Adnus@gmail.com","Deward@gmail.com","Jennigir@gmail.com","Priffy@gmail.com",
							 "Aeberry@gmail.com","Edgarwyn@gmail.com","Jodoflidy@gmail.com","Prikel@gmail.com",
							 "Ahmund@gmail.com","Erethan@gmail.com","Katly@gmail.com","Rathrywove@gmail.com",
							 "Amallen@gmail.com","Erkildis@gmail.com","Lathaa@gmail.com","Remio@gmail.com",
							 "Ambin@gmail.com","Etexton@gmail.com","Leinna@gmail.com","Reothers@gmail.com",
							 "Asliger@gmail.com","Eurost@gmail.com","Lindey@gmail.com","Shear@gmail.com",
							 "Attin@gmail.com","Falic@gmail.com","Litaci@gmail.com","Strehan@gmail.com",
							 "Baside@gmail.com","Farle@gmail.com","Lugovard@gmail.com","Suavia@gmail.com",
							 "Billesley@gmail.com","Fearap@gmail.com","Lungol@gmail.com","Suide@gmail.com",
							 "Bjorn@gmail.com","Firitte@gmail.com","Maelio@gmail.com","Taurelach@gmail.com",
							 "Bozeigh@gmail.com","Flider@gmail.com","Maerone@gmail.com","Terede@gmail.com",
							 "Brase@gmail.com","Floda@gmail.com","Mahon@gmail.com","Thancie@gmail.com",
							 "Burhia@gmail.com","Fornelock@gmail.com","Matha@gmail.com","Thilliph@gmail.com",
							 "Calesli@gmail.com","Fredil@gmail.com","Mercaed@gmail.com","Thred@gmail.com",
							 "Caranse@gmail.com","Garbel@gmail.com","Mezzo@gmail.com","Throndem@gmail.com",
							 "Cathoen@gmail.com","Gilina@gmail.com","Mirag@gmail.com","Todumnan@gmail.com",
							 "Cerothe@gmail.com","Glanis@gmail.com","Mochan@gmail.com","Tolbad@gmail.com",
							 "Cinne@gmail.com","Greene@gmail.com","Muirgissy@gmail.com","Weithan@gmail.com",
							 "Conne@gmail.com","Guobe@gmail.com","Nebenn@gmail.com","Wicheber@gmail.com",
							 "Corber@gmail.com","Gwaynet@gmail.com","Nomascius@gmail.com","Wihta@gmail.com",
							 "Courne@gmail.com","Heathe@gmail.com","Omnes@gmail.com","Winin@gmail.com",
							 "Coveda@gmail.com","Heget@gmail.com","Ormanz@gmail.com","Wippi@gmail.com",
							 "Crovan@gmail.com","Interitta@gmail.com","Ossecummo@gmail.com","Yrcharun@gmail.com",
							 "Cvlicus@gmail.com","Irroth@gmail.com","Palmoth@gmail.com","Zainba@gmail.com",
							 "Cyngelowr@gmail.com","Ivann@gmail.com","Perdana@gmail.com","Zhula@gmail.com"};
	public static String[] nameArr = {"남궁진철", "설은영", "손상호", "이석연", "문호경", "한천화", "정창희", "정진철", "배창우", "정재환", "최지희", "표영숙", "배소훈", "권혜빈", "하호정", "오해원", "신유현", "사공원우", "안태웅", "추인옥", "이한결", "황샘", "배샘", "남샘", "임믿음", "허믿음", "박나라우람", "추다운", "탁으뜸", "정힘찬", "배한결", "고다운", "오다운", "황보힘찬", "김다운", "탁나길", "남힘찬", "예믿음", "심나길", "하나라우람", "한마리", "배소라", "신꽃", "노송이", "최비", "강마음", "류별찌", "성별", "복한울", "서바람", "오담비", "권초롱", "허하루", "조나리", "성새벽", "박하나", "봉나라", "강하얀", "신솔", "윤아람", "김동건", "제갈요한", "예성한", "풍치원", "조재섭", "손경택", "노동건", "남궁이수", "한남규", "예치원", "손재섭", "송무열", "하경구", "정승헌", "예현승", "한오성", "전경구", "허강민", "정강민", "조동건", "강재신", "양경님", "허은채", "황혜린", "정혜림", "황혜린", "추가영", "이숙자", "추영애", "송경완", "최혜린", "손애정", "노재신", "강영신", "강애정", "박경님", "예미래", "류애정", "허남순", "제갈영신"};
	public static String[] nickArr1 = {"요리하는", "멋진", "귀여운", "무서운", "졸린", "용감한", "뚱보", "잘생긴", "최고의", "히어로"};
	public static String[] nickArr2 = {"강아지", "고양이", "사나이", "맘", "호랑이", "하마", "기린", "아이", "오리", "미식가"};
	public static String intro = "안녕하세요. 잘부탁드립니다.^^";
	


	
	
}
