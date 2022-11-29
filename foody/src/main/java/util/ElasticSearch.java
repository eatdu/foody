package util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpHost;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.ml.PostDataRequest.JsonBuilder;
import org.elasticsearch.common.xcontent.XContentType;

public class ElasticSearch {
	
	public static void main(String[] args) throws Exception {
//		Map map = getDocument("seoul_wifi", "1");
//		System.out.println(map);
		
		// 여러건 조회
//		HttpHost host = new HttpHost("localhost", 9200);
//		RestClientBuilder restClientBuilder = RestClient.builder(host);
//		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
//		
//		SearchRequest searchRequest = new SearchRequest("seoul_wifi");
//		SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
//
//		sourceBuilder.query(QueryBuilders.matchQuery("place_nm", "도서관"));
//		searchRequest.source(sourceBuilder);
//		
//		SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//		List<Map<String, Object>> list = new ArrayList();
//		for (SearchHit sh : searchResponse.getHits().getHits()) {
//			list.add(sh.getSourceAsMap());
//		}
//		
//		for (Map<String, Object> map : list) {
//			System.out.println(map.get("place_nm"));
//		}
		
//		// put document 테스트
//		String index = "test_index";
//		String id = "3";
//		Map<String, Object> doc = new HashMap<String, Object>();
//		doc.put("rname","약식");
//		doc.put("intro", "집에서도 쉽게 만들어 맛있게 먹을 수 있답니다. 어려워 마시고 만들어 보세요~!");
//		doc.put("rtype", "밥");
//		
//		List<Map> ingres = new ArrayList<Map>();
//		Map<String, Object> i1 = new HashMap<String, Object>();
//		Map<String, Object> i2 = new HashMap<String, Object>();
//		
//		i1.put("iname", "멥쌀");
//		i1.put("icate", "곡류 및 그 제품");
//		i2.put("iname", "콩나물");
//		i2.put("icate", "나물/생채/샐러드");
//		ingres.add(i1);
//		ingres.add(i2);
//		doc.put("ingres", ingres);
//		
//		putDocument(index, id, doc);
		
		//멀티매치 getMultiMatch 테스트
//		System.out.println(getMultiMatch("foody_recipe", "여름"));
	}

	
	// 한건조회
	public static Map<String, Object> getDocument (String index, String id) throws Exception {
		
		HttpHost host = new HttpHost("localhost", 9200);
		RestClientBuilder restClientBuilder = RestClient.builder(host);
		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
		
		GetRequest getRequest = new GetRequest(index, id);
		RequestOptions options = RequestOptions.DEFAULT;
		
		GetResponse getResponse = client.get(getRequest, options);
		Map<String, Object> map = getResponse.getSourceAsMap();
		
		return map;
	}
	
	public static String getMultiMatch (String index, String keyword) throws Exception {
		URL url = new URL("http://localhost:9200/" + index + "/_search");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setDoOutput(true);
		
		String paramData = "{\"size\": 500,\"query\": {\"multi_match\": {\"query\": \""+ keyword +"\",\"fields\": [\"rname\",\"intro\",\"rtype\",\"ingres.icate\",\"ingres.iname\",\"ingres.detail\"]}}}";
		
		try (OutputStream os = conn.getOutputStream()){
			byte request_data[] = paramData.getBytes("utf-8");
			os.write(request_data);
			os.close();
		}
		catch(Exception e) {
			e.printStackTrace();
		}	
		
		conn.connect();
		
		try{
			StringBuffer sb = new StringBuffer();
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			while(br.ready()) {
				sb.append(br.readLine());
			}
			
			return sb.toString();
		}catch(Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
	
	public static void putDocument (String index, String id, Map<String, Object> doc) throws Exception {
		
		HttpHost host = new HttpHost("localhost", 9200);
		RestClientBuilder restClientBuilder = RestClient.builder(host);
		RestHighLevelClient client = new RestHighLevelClient(restClientBuilder);
		
		JsonBuilder json = new JsonBuilder();
		json.addDoc(doc);

		IndexRequest req = new IndexRequest(index).id(id).source(doc, XContentType.JSON);
		client.index(req, RequestOptions.DEFAULT);
	}
}
