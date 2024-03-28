package controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import model.product.LikeBeans;
import model.product.OrderBeans;
import model.service.ImgUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import model.member.*;
import model.product.BeansDAO;
import model.product.BeansDO;
import model.like.*;
import model.order.*;

/*
 * 	1) GET	|	/main				->  main.jsp, 세션이 있다면 -> mainLoginBuyer.jsp
 * 	2) POST	|	/mainLogin			->	구매자 판매자 구별 -> 아이디 맞는지 확인 -> 로그인 -> 세션생성 -> mainLoginBuyer.jsp :: mainLoginSeller.jsp
 * 	3) GET	|	/myPageBuyer		->	세션정보로 여러정보(찜, 구매내역, 공동구매내역) 보여줘야함. -> myPageBuyer.jsp
 * 	4) GET	|	/buyerModify		->	세션정보 받아서 회원정보 수정할 페이지 -> buyerModify.jsp
 * 	5) POST |	/buyerModifyChange	->	구매자 회원정보 수정 -> redirect:/mainPageBuyer
 *  
 * 	6) POST	|	/myPageSeller		->  세션정보로 여러정보(찜, 구매내역, 공동구매내역) 보여줘야함. -> myPageSeller.jsp
 * 	7) GET	|	/sellerModify		->  세션정보 받아서 회원정보 수정할 페이지 -> sellerModify.jsp
 * 	8) POST |	/sellerModifyChange ->	판매자 회원정보 수정 -> redirect:/mainPageSeller
 * 
 * 	9) GET	|	/signup				->	회원가입 구매자 판매자 선택 -> signup.jsp
 * 	10)POST	|	/signupSeller		->	Seller 정보 insert -> redirect:/main
 * 	11)POST	|	/signupBuyer		->	Buyer 정보 insert -> redirect:/main
 *  
 * 	12)GET	|	/logout				->  세션정보를 지움 -> redirect:/main
 *  
 */


@Controller
//@RequestMapping()
public class MemberController {
	private BuyerDO buyer;
	private final BuyerDAO buyerDAO = new BuyerDAO();
	private SellerDO seller;
	private final SellerDAO sellerDAO = new SellerDAO();
	private BeansDO beansDO;
	private final BeansDAO beansDAO = new BeansDAO();
	private final LikeDAO likeDAO = new LikeDAO();
	private final OrderProductDAO orderProductDAO = new OrderProductDAO();
	private final OrderProductDO orderProductDO = new OrderProductDO();
	private final OrderProductDetailDAO orderProductDetailDAO = new OrderProductDetailDAO();
	private final ImgUpload imgUpload = new ImgUpload();
	
	public MemberController() {}
	
	//메인
	@GetMapping("/main")
	public String main(HttpSession session, Model model) {
		model.addAttribute("categoryList", beansDAO.getAllCategory());
		model.addAttribute("bestBean", beansDAO.bestBeanArray());

		String sessionBuyer = (String) session.getAttribute("buyerEmail");
		String sessionSeller = (String) session.getAttribute("sellerEmail");


		if (sessionBuyer != null) {

			BuyerDO buyerDO = buyerDAO.getBuyer(sessionBuyer);

			model.addAttribute("buyer", buyerDO);

			return "mainLoginBuyer";
		} else if(sessionSeller != null){

			SellerDO sellerDO = sellerDAO.getSeller(sessionSeller);

			model.addAttribute("seller", sellerDO);

			return "mainLoginSeller";
		}
		else {

			return "main";
		}

	}
	
	// 메인 로그인 페이지 (가영 수정)
	@PostMapping("/mainLogin")
	public String mainLoginBuyer(@RequestParam("action") String action, HttpServletRequest request, HttpSession session, Model model) {
		String user = request.getParameter("user");
		HashPw hash = new HashPw();
		
		if(action.equals("login")) {
			System.out.println("1");
			if(user.equals("seller")) {
				String id = request.getParameter("id");
				String pw = request.getParameter("passwd");

				
				SellerDO sellerEmail = sellerDAO.getSeller(id);
				model.addAttribute("seller", sellerEmail);
				
				// 겹치면 true = DB에 id가 있다는 뜻
				if(sellerDAO.checkSellerId(id) == true) { 
					System.out.println("login fail1");
					model.addAttribute("categoryList", beansDAO.getAllCategory());
					model.addAttribute("bestBean", beansDAO.bestBeanArray());
					model.addAttribute("login", "fail1");
					return "/main";
				}
				//비밀번호 틀림
				else if(!sellerEmail.getPasswd().equals(pw)){  
					System.out.println("login fail2");
					model.addAttribute("categoryList", beansDAO.getAllCategory());
					model.addAttribute("bestBean", beansDAO.bestBeanArray());
					model.addAttribute("login", "fail2");
				    return "/main";
				}
				//아이디 비밀번호 전부일치
				else { 
					System.out.println("login all clear");
					
					session.setAttribute("sellerEmail", sellerEmail.getSellerEmail());
					String sessionSeller = String.valueOf(session.getAttribute("sellerEmail"));
					System.out.printf(sessionSeller);
					System.out.println();

					model.addAttribute("categoryList", beansDAO.getAllCategory());
					model.addAttribute("bestBean", beansDAO.bestBeanArray());
					model.addAttribute("login", "true");
					return "mainLoginSeller";
				}
				
			} 
			else if(user.equals("buyer")){
				
				String id = request.getParameter("id");
				String pw = request.getParameter("passwd");
				
				BuyerDO buyerDO = buyerDAO.getBuyer(id);
				model.addAttribute("buyer", buyerDO);
				String saltValue = buyerDO.getSaltValue(id);
				
				// 겹치면 true = DB에 id가 있다는 뜻
				if(buyerDAO.checkBuyerId(id)) {
					System.out.println("login fail1");
					model.addAttribute("categoryList", beansDAO.getAllCategory());
					model.addAttribute("bestBean", beansDAO.bestBeanArray());
					model.addAttribute("login", "fail1");
					return "/main";
				}
				//비밀번호 틀림, 해싱 처리 추가
				
				else if(!buyerDO.getPasswd().equals(hash.hashPw(pw,saltValue))){
					System.out.println("login fail2");
					System.out.println(buyerDO.getPasswd());
					System.out.println(pw);
					System.out.println(saltValue);
					System.out.println(hash.hashPw(pw,saltValue));
					model.addAttribute("categoryList", beansDAO.getAllCategory());
					model.addAttribute("bestBean", beansDAO.bestBeanArray());
					model.addAttribute("login", "fail2");
				    return "/main";
				}
				//아이디 비밀번호 전부일치
				else { 
					System.out.println("login all clear");
					
					session.setAttribute("buyerEmail", buyerDO.getBuyerEmail());
					String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
					System.out.printf(sessionBuyer);
					System.out.println();

					model.addAttribute("categoryList", beansDAO.getAllCategory());
					model.addAttribute("bestBean", beansDAO.bestBeanArray());
					model.addAttribute("login", "true");
					return "mainLoginBuyer";
				}
				
			}
		}
		
		else if (action.equals("signup")) {
			return "signup";
		}
		
		return "error";
		
	}
	
	// 판매자 메인 로그인
	@GetMapping("mainLoginSeller")
	public String mainLoginSeller(HttpSession session, Model model) {
		
		String sessionSeller = String.valueOf(session.getAttribute("sellerEmail"));
		model.addAttribute("seller", sellerDAO.getSeller(sessionSeller));
		model.addAttribute("categoryList", beansDAO.getAllCategory());
		model.addAttribute("bestBean", beansDAO.bestBeanArray());
		model.addAttribute("login", "true");
		
		return "mainLoginSeller";
	}
	
	
	/*
	 * 
	 * 구매자 메소드
	 * 
	 */
	// 구매자 마이페이지
	@GetMapping("/myPageBuyer")
	public String myPageBuyer(HttpSession session, Model model) {
		
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
		model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
		
		// 찜 내역 불러오기
		ArrayList<LikeBeans> likeListInfo = likeDAO.getLikeList(sessionBuyer);

		model.addAttribute("likeList", likeListInfo);
		
		// 구매내역
		ArrayList<OrderProductDO> orderListInfo = orderProductDAO.getBuyerOrderList(sessionBuyer);
		ArrayList<OrderBeans> orderBeansList = new ArrayList<>();

		for (OrderProductDO i : orderListInfo){
			OrderBeans orderBeans = new OrderBeans();
			ArrayList<OrderBeans> orderProductDetailList = orderProductDetailDAO.getOrderProductDetailList(sessionBuyer, i.getOrderDatetime());
			BeansDO beans = orderProductDetailList.get(0).getBeansDO();
			orderBeans.setOrderProductDO(i);
			orderBeans.setBeansDO(beans);

			orderBeansList.add(orderBeans);
		}

		model.addAttribute("orderList", orderBeansList);
		
		
		return "myPageBuyer";
	}


	// 구매 내역 상세보기
	@PostMapping("/paymentDetail")
	public String paymentDetail(@RequestParam("orderDatetime") String orderDatetime, HttpSession session, Model model) {
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));

		OrderProductDO order = new OrderProductDO();
		for(OrderProductDO i : orderProductDAO.getBuyerOrderList(sessionBuyer)) {
			if(i.getOrderDatetime().equals(orderDatetime)) {
				order.setBeforeOrderPoint(i.getBeforeOrderPoint() - i.getOrderTotalPrice());
				order.setOrderTotalPrice(i.getOrderTotalPrice());
			}
		}
		model.addAttribute("beforeOrderPoint", order);

		model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
		model.addAttribute("bean", orderProductDetailDAO.getOrderProductDetailList(sessionBuyer, orderDatetime));
		model.addAttribute("order", orderProductDAO.getBuyerOrderList(sessionBuyer));

		return "paymentDetail";
	}
//	@PostMapping("/paymentDetail")
//	public String paymentDetail(@RequestParam("orderDatetime") String orderDatetime, HttpSession session, Model model) {
//		
//		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
//		model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
//		
//		model.addAttribute("bean", orderProductDetailDAO.getOrderProductDetailList(sessionBuyer, orderDatetime));
//		
//		return "paymentDetail";
//	}
	
//	// 로그아웃  		확인하고 지우기 가영
//		@GetMapping("/loginAfter")
//		public String loginAfter(HttpSession session) {
//			
//			session.invalidate();
//			
//			return "redirect:/main";
//		}
	
	// 구매자 회원정보 수정페이지로 이동
	@GetMapping("/loginAfter")
	public String loginAfter(@RequestParam("action") String action, HttpSession session, Model model) {
		
		if(action.equals("buyerModify")) {
			String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
			model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
			
			return "buyerModify";
		} else if (action.equals("sellerModify")) {
			String sessionSeller = String.valueOf(session.getAttribute("sellerEmail"));
			model.addAttribute("seller", sellerDAO.getSeller(sessionSeller));

			return "sellerModify";
		} else if(action.equals("logout")) {
			session.invalidate();
			
			return "redirect:/main";
		}
		return "main";
	}
	
	@GetMapping("/buyerModify")
	public String buyerModify(HttpSession session, Model model) {
		
			String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
			model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
			
			return "buyerModify";
	}
	
	// 구매자 회원정보 수정
	@PostMapping("/buyerModifyChange")

	public String buyerModifyChange(HttpServletRequest request, HttpSession session, Model model) throws IOException {
		String directory = "C:\\Users\\H40\\finalCoffee/coffee-please/src/main/webapp/registerData/buyerData/buyer";


		int sizeLimit = 1024 * 1024 * 5;
		MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit,
				"UTF-8", new DefaultFileRenamePolicy());

		String action = multi.getParameter("action");

		BuyerDO buyer = new BuyerDO();
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));

		if(action.equals("buyerModifyChange")) {

			String[] img = imgUpload.saveImg(multi, directory);


			buyer.setBuyerEmail(sessionBuyer);
      
      String buyerImg = "/coffee/registerData/buyerData/buyer/" + img[0];

	  		buyer.setNickname(multi.getParameter("nickname"));
			buyer.setTel(multi.getParameter("tel"));
			buyer.setAddress(multi.getParameter("address"));
			buyer.setBuyerImg(buyerImg);
			buyerDAO.updateBuyer(buyer);
			model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
			return "myPageBuyer";
		}
		else if(action.equals("previousPage")) {

			model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
			return "redirect:/myPageBuyer";
		}
		
		return "error";

	}
	/*
	 * 
	 * 판매자 메소드
	 * 
	 */
	// 판매자 마이페이지
	@GetMapping("/myPageSeller")
	public String myPageSeller(HttpSession session, Model model) {
		
		String sessionSeller = String.valueOf(session.getAttribute("sellerEmail"));
		model.addAttribute("seller", sellerDAO.getSeller(sessionSeller));

		ArrayList<LikeBeans> sellList = beansDAO.getSellList(sessionSeller);
		LikeBeans likeBeans;

		for(int i = 0; i < sellList.size(); i++){
			int categoryNum = sellList.get(i).getBeansDO().getCategoryNum();
			likeBeans = sellList.get(i);
			likeBeans.setCategoryName(beansDAO.getCategoryName(categoryNum));
			sellList.set(i, likeBeans);
		}
		// 판매 중인 상품
		model.addAttribute("sellList", sellList);

		// 판매 내역
		
		
		
		return "myPageSeller";
	}
	
	// 판매자 정보수정페이지로 이동
	@GetMapping("/sellerModify")
	public String sellerModify(HttpSession session, Model model) {
		String sessionSeller = String.valueOf(session.getAttribute("sellerEmail"));
		SellerDO seller = sellerDAO.getSeller(sessionSeller);
		model.addAttribute("seller", seller);
		System.out.println(seller.getSellerEmail());
		System.out.println(seller.getAddress());
		System.out.println(seller.getNickname());
		System.out.println(seller.getTel());

		return "sellerModify";
	}
	
	// 판매자 정보수정
	@PostMapping("/sellerModifyChange")
	public String sellerModifyChange(HttpServletRequest request, HttpSession session, Model model) throws IOException {

		String directory =  "C:\\Users\\H40\\finalCoffee/coffee-please/src/main/webapp/registerData/sellerData/seller";

		int sizeLimit = 1024 * 1024 * 5;
		MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit,
				"UTF-8", new DefaultFileRenamePolicy());

		String action = multi.getParameter("action");

		SellerDO seller = new SellerDO();
		String sessionSeller = String.valueOf(session.getAttribute("sellerEmail"));

		if(action.equals("sellerModifyChange")) {

			String[] img = imgUpload.saveImg(multi, directory);


			seller.setSellerEmail(sessionSeller);
      
			String sellerImg = "/coffee/registerData/sellerData/seller/" + img[0];

			seller.setSellerImg(sellerImg);
			seller.setNickname(multi.getParameter("nickname"));
			seller.setTel(multi.getParameter("tel"));
			seller.setAddress(multi.getParameter("address"));
			seller.setSellerEmail(sessionSeller);

			sellerDAO.updateSeller(seller);

			model.addAttribute("seller", sellerDAO.getSeller(sessionSeller));

			return "myPageSeller";
		}
		else if(action.equals("previousPage")) {

			model.addAttribute("seller", sellerDAO.getSeller(sessionSeller));
		    return "redirect:/myPageSeller";
		}		
		return "error";
	}
	
	// 회원가입 하기위해서 판매자 구매자 선택 화면으로 이동 (가영 수정) 확인하고 삭제해도 되는지
//	@GetMapping("/signup")
//	public String signup() {
//		return "signup";
//	}
	
	// 판매자 회원가입화면으로 이동
	@GetMapping("/goSignupSeller")
	public String goSignupSeller() {
		return "signupSeller";
	}
	
	// 판매자 회원가입후 메인으로 이동
	@PostMapping("/signupSeller")
	public String signupSeller(@ModelAttribute SellerDO seller) throws Exception {

		seller.setSellerImg("/coffee/images/userImginit.png");
		sellerDAO.insertSeller(seller);
		return "redirect:/main";
	}
	
	// 구매자 회원가입화면으로 이동
	@GetMapping("/goSignupBuyer")
	public String goSignupBuyer() {
		return "signupBuyer";
	}
	
	// 구매자 회원가입후 메인으로 이동
	@PostMapping("signupBuyer")
	public String signupBuyer(@ModelAttribute BuyerDO buyer,@RequestParam("command") String command, Model model) throws Exception{
		
		if(!buyerDAO.checkBuyerId(buyer.getBuyerEmail()) && command.equals("idCheck")) {
			String msg = "아이디가 중복되었습니다.";
			model.addAttribute("idCheck", msg);
			return "signupBuyer";
		} 
		else if(buyerDAO.checkBuyerId(buyer.getBuyerEmail()) && command.equals("idCheck")) {
			String msg = "사용가능한 아이디 입니다.";
			model.addAttribute("idCheck", msg);
			return "signupBuyer";
		}
		else if(command.equals("signup")){
			buyer.setBuyerImg("/coffee/images/userImginit.png");
			buyerDAO.insertBuyer(buyer);
			System.out.println(buyer.getSaltValue(buyer.getBuyerEmail()));
			return "redirect:/main";
			
		}
		else {
			return "error";
		}
		
	}
	
	
	
	
}