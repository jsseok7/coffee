//package main.java.controller;
package controller;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import model.member.BuyerDAO;
import model.order.OrderProductDO;
import model.product.BeansQty;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.cart.CartDAO;
import model.cart.CartDTO;
import model.member.BuyerDAO;
import model.member.BuyerDO;
import model.member.SellerDAO;
import model.member.SellerDO;
import model.product.BeansDAO;
import model.product.BeansDO;
import model.product.BeansQty;
import model.product.CartBeans;
import model.product.LikeBeans;
import model.service.ImgUpload;
import model.service.LikeService;
import model.service.OrderService;
/*
 * 	구매자 메서드
 * 	1) GET	|	/goProdcutList		->	mainLoginBuyer, mainLoginSeller랑 각각 설정? -> productList.jsp
 *  2) GET	|	/goProdcutListGroup ->	productListGroup.jsp
 *  2) POST	|	/goListDetail		->	각각의 상품 마다 고유 NUM이 있을텐데 ... -> productListDetail.jsp
 *  3) POST	|	/goListDetailGroup	->	그룹 상품도 마찬가지 -> productListDetailGroup.jsp
 *  4) POST	|	/payment			->	상세 페이지에서 결제 누르면 바로이동 -> payment.jsp
 *  5) POST	|	/paymentComplete	->	결제 완료시 -> paymentComplete.jsp
 *  6) POST	|	/mainLogin			->	결제 완료 페이지에서 버튼 누르면 메인으로 이동(멤버 컨트롤러에 메서드 정의되어있음) -> mainLoginBuyer
 *  7) POST	|	/cart				->	어디서 누르는지는 모르겟지만 카트로 이동 -> cart.jsp

 *  
 *  장바구니는 마이페이지로 이동하게 만들면 될듯
 *  

 *  판매자 메서드
 *  8) GET	|	/goRegisterProd		->	상품등록 페이지로 이동 -> registerProduct.jsp
 *  9) GET	|	/goRegisterProdGroup->	공동구매 상품등록 페이지로 이동 -> registerProductGroup.jsp
 *  10)POST	|	/registerProd		->	상품등록 후 -> mainLoginSeller.jsp
 *  11)POST	|	/registerProdGroup	->	공동구매 상품 등록 -> mainLoginSeller.jsp
 *  
 */
@Controller
public class ProductController {
	
	private BeansDO beans;
	private BeansQty beansQty;

	private final BeansDAO beansDAO = new BeansDAO();
	private final SellerDAO sellerDAO = new SellerDAO();
	private final ImgUpload imgUpload = new ImgUpload();
	private final CartDAO cartDAO = new CartDAO();
	private final OrderService orderService = new OrderService();
	private final LikeService likeService = new LikeService();
	private final BuyerDAO buyerDAO = new BuyerDAO();
	
	public ProductController() {
	}
		
// 이전, 다음 페이지 처리
	@GetMapping("/navigatePage")
	public String navigatePage(@RequestParam("currentPage") int currentPage, 
	                            @RequestParam("totalPages") int totalPages,
	                            @RequestParam("direction") String direction, 
	                            @RequestParam("category") int categoryNum, 
	                            @RequestParam("search") String search,
	                            @RequestParam("sort") String sort) {
		
		
		String category = "&category=" + categoryNum;
		
		if (!"recent".equals(sort)) {
	        return "?page=" + currentPage + 
	        		"&search=" + search + 
	        		"&sort=" + sort + category;
	    }
		
	    if ("previous".equals(direction) && currentPage > 1) {
	        return "?page=" + (currentPage - 1) + 
	        		"&search=" + search + 
	        		"&sort=" + sort + category;
	    } else if ("next".equals(direction) && currentPage < totalPages) {
	        return "?page=" + (currentPage + 1) + 
	        		"&search=" + search + 
	        		"&sort=" + sort + category;
	    }
	    return "?page=" + currentPage + "&search=" + search + category;
	}

// 상품 목록 페이지로 이동
	@GetMapping("/goProductList")
	public String ProductList(Model model,
							  @RequestParam(value = "page", required = false, defaultValue = "1") int page, 
		            @RequestParam(value = "pageSize", required = false, defaultValue = "14") int pageSize,
		            @RequestParam(value = "category", required = false, defaultValue = "0") String categoryNum,
		            @RequestParam(value = "sort", required = false, defaultValue = "recent") String sort,
		            @RequestParam(value = "search", required = false , defaultValue = "") String search,
							  HttpSession session, HttpServletRequest request) throws SQLException {

		// 상품 목록을 가져오는 기본 메서드
		//System.out.println(sort + ":" + search + ":" + categoryNum);
        ArrayList<BeansDO> beansList = beansDAO.sortedPage(sort, search, Integer.parseInt(categoryNum));
        if (sort != null && sort.equals("recent")) {
        	model.addAttribute("sort", "recent");
        }else if (sort != null && sort.equals("mostLiked")) {
        	model.addAttribute("sort", "mostLiked");
        }else if (sort != null && sort.equals("bestSelling")) {
        	model.addAttribute("sort", "bestSelling");
        }

		// 페이징 처리를 위한 전체 상품 수 계산
        int totalRows = beansList.size();
        int totalPages = (int) Math.ceil((double) totalRows / pageSize);

        // 페이지 범위를 조정
        if (page < 1) {
            page = 1;
        } else if (page > totalPages) {
            page = totalPages;
        }

        // 페이징 처리를 위해 부분 리스트 선택
        int startRow = 1 + (page - 1) * pageSize;
        int endRow = pageSize * page;
        ArrayList<BeansDO> pagedBeansList = new ArrayList<>(beansList.subList(
        	    Math.max(startRow - 1, 0), Math.min(endRow, totalRows)));

		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));

		ArrayList<LikeBeans> likeBeans = likeService.likeBeans(sessionBuyer, pagedBeansList);

		// 모델에 데이터 추가
        model.addAttribute("categoryNum", categoryNum);
        model.addAttribute("sortOption", sort);
        model.addAttribute("beansList", likeBeans);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("search", search);
        model.addAttribute("categoryList", beansDAO.getAllCategory());



		return "productList";
	}

// 공동 구매 상품 페이지로 이동	
	@GetMapping("/goProductListGroup")
	public String goProductListGroup(Model model, 
            @RequestParam(value = "page", required = false, defaultValue = "1") int page, 
            @RequestParam(value = "pageSize", required = false, defaultValue = "14") int pageSize,
            @RequestParam(value = "category", required = false, defaultValue = "0") String categoryNum,
            @RequestParam(value = "sort", required = false, defaultValue = "recent") String sort, 
            @RequestParam(value = "search", required = false) String search) {
    
    ArrayList<BeansDO> groupBeansList;
    groupBeansList = beansDAO.sortedPage2(sort, search, Integer.parseInt(categoryNum));     	
    
    
    int totalRows = groupBeansList.size();
    int totalPages = (int) Math.ceil((double) totalRows / pageSize);

    if (page < 1) {
        page = 1;
    } else if (page > totalPages) {
        page = totalPages;
    }

    int startRow = 1 + (page - 1) * pageSize;
    int endRow = pageSize * page;
    ArrayList<BeansDO> pagedGroupBeansList = new ArrayList<>(groupBeansList.subList(
            Math.max(startRow - 1, 0), Math.min(endRow, totalRows))); 

    model.addAttribute("categoryNum", categoryNum);
    model.addAttribute("sortOption", sort);
    model.addAttribute("groupBeansList", pagedGroupBeansList);
    model.addAttribute("totalPages", totalPages);
    model.addAttribute("currentPage", page);
    model.addAttribute("search", search);
    model.addAttribute("categoryList", beansDAO.getAllCategory()); 

    return "productListGroup";
}

// 일반 상품 상세페이지로 이동
	@GetMapping("/goListDetail")
	public String goListDetail(@RequestParam("beansNum") int beansNum, Model model, HttpSession session) throws SQLException {
		//System.out.println("번호: " + beansNum);
		
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
		boolean b = likeService.checkLike(sessionBuyer, beansNum);

		LikeBeans likeBeans = new LikeBeans();
		likeBeans.setBeansDO(beansDAO.getBean(beansNum));
		likeBeans.setaBoolean(b);


		model.addAttribute("productListDetail", likeBeans);
		return "productListDetail";
	}

// 공동 상품 상세 페이지로 이동
	@GetMapping("/goListDetailGroup")
	public String goListDetailGroup(@RequestParam("beansNum") int beansNum, Model model) {
		beans = beansDAO.getBean(beansNum);


			model.addAttribute("productListDetailGroup", beansDAO.getGroupBean(beansNum));
			return "productListDetailGroup";
	}

// *  4) POST	|	/payment			->	상세 페이지에서 결제 누르면 바로이동 -> payment.jsp
	//장바구니에 담기

	@GetMapping("/cartOrPayment")
	public String goCartList(HttpSession session,
	        Model model) throws SQLException {
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
		
		long totalPrice = cartDAO.totalPrice(sessionBuyer);
		
		model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("cart", cartDAO.getCartList(sessionBuyer));
	    return "cart";
	}
		
	@PostMapping("/cartOrPayment")
	public String payment(CartDTO cartDTO,
	        HttpSession session,
	        Model model) throws SQLException {
		 //System.out.println(cartDTO.toString());

		BeansDO bean = beansDAO.getBean(cartDTO.getBeansNum());
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
		
		// bean에 해당하는 상품이 cartDAO에 있는지 체크한다
		if(cartDAO.checkItem(sessionBuyer, cartDTO.getBeansNum())) {
			// 있다면 제거한다.
			cartDAO.deleteItem(sessionBuyer, cartDTO.getBeansNum());
		}
		cartDAO.addItem(sessionBuyer, bean, cartDTO.getQty());
		long totalPrice = cartDAO.totalPrice(sessionBuyer);
		model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("cart", cartDAO.getCartList(sessionBuyer));
	    return "cart";
	 }


	//하나 바로 결제
	@PostMapping("/buyNow")
	public String buyNow(CartDTO cartDTO, HttpSession session, Model model) throws SQLException {

		BeansDO beansDO = beansDAO.getBean(cartDTO.getBeansNum());
		
		
		model.addAttribute("qty", cartDTO.getQty());
		model.addAttribute("beansDO", beansDO);
		
		
		return "buyNow";
	}
	


	@GetMapping("/deleteItem")
	public String deleteItem (@RequestParam("beansNum") int beansNum, HttpSession session, Model model) {

	    String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
	    //System.out.println("번호: " + beansNum);
	    
	    cartDAO.deleteItem(sessionBuyer, beansNum);

	    model.addAttribute("totalPrice", cartDAO.totalPrice(sessionBuyer));
	    model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
	    model.addAttribute("cart", cartDAO.getCartList(sessionBuyer));
	    return "cart";
	}

	@PostMapping("/paymentComplete")
	public String paymentComplete(CartDTO cartDTO , HttpSession session, Model model) throws SQLException {
		
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
		//System.out.println(cartDTO.toString());
		OrderProductDO orderProductDO = orderService.onlyOnePayment(cartDTO.getBeansNum(), cartDTO.getQty(), sessionBuyer);


		ArrayList<BeansQty> beanList = new ArrayList<>();

		beansQty = new BeansQty();

		beansQty.setBeansDO(beansDAO.getBean(cartDTO.getBeansNum()));
		beansQty.setQty(cartDTO.getQty());

		
		beanList.add(beansQty);
		orderProductDO.setBeforeOrderPoint(orderProductDO.getBeforeOrderPoint());

		model.addAttribute("beansList", beanList);
		model.addAttribute("orderList", orderProductDO);
		
		return "paymentComplete";
	}

	//장바구니 결제
	@GetMapping("/cartPayment")
	public String cartPayment(HttpSession session, Model model) throws SQLException {
		
		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
		
		cartDAO.getCartList(sessionBuyer);
		
		OrderProductDO orderProductDO = orderService.cartPayment(sessionBuyer);
		
//	if(orderProductDO != null) {
			model.addAttribute("orderList", orderProductDO);
			model.addAttribute("beansList", cartDAO.getCartList(sessionBuyer));

			return "paymentComplete";
//		}
		
//		return 
	}
	
	
	// 장바구니로 이동

//	@GetMapping("/cart")
//	public String goCart(HttpSession session, Model model){
//		String sessionBuyer = String.valueOf(session.getAttribute("buyerEmail"));
//		
//		ArrayList<CartBeans> cartList = cartDAO.getCartList(sessionBuyer);
//		int totalPrice = cartDAO.totalPrice(sessionBuyer);
//
//		model.addAttribute("buyer", buyerDAO.getBuyer(sessionBuyer));
//		model.addAttribute("cart", cartList);
//		model.addAttribute("totalPrice", totalPrice);
//
//		return "cart";
//	}

// 상품등록(일반, 공동) 페이지로 이동
	@GetMapping("/goRegisterProd")
	public String resisterProduct(@ModelAttribute SellerDO seller, @RequestParam("action") String action) {

		if(action.equals("normal")) {
			return "registerProduct";
		}
		else if(action.equals("group")) {
			return "redirect:/mainLoginSeller";
		}
		else {
			return "error";
		}
	}
	
	// 


	// 일반 상품 등록
	@PostMapping("/registerProd")
	public String resisterProduct(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {

		//String directory = "C:\\Users\\H40\\finalCoffee/coffee-please/src/main/webapp/registerData/sellerData/beans";
		String directory = "C:/Users/jsseo/git/coffee/src/main/webapp/registerData/sellerData/beans" ;
		int sizeLimit = 1024 * 1024 * 5;

		MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit,
				"UTF-8", new DefaultFileRenamePolicy());

		String action = multi.getParameter("action");
		if (action != null && action.equals("register")) {

			System.out.println(2);
			String[] img = imgUpload.saveImg(multi, directory);
			System.out.println(3);
			// 세션이메일을 받아서 판매자 이메일로 저장
			String sellerEmail = String.valueOf(session.getAttribute("sellerEmail"));

			String beanName = multi.getParameter("beanName");
			int beanPrice = Integer.parseInt(multi.getParameter("beanPrice"));
			int categoryNum = Integer.parseInt(multi.getParameter("categoryNum"));
			int deliveryCharge = Integer.parseInt(multi.getParameter("deliveryCharge"));

			String beanImg = "/coffee/registerData/sellerData/beans/" + img[1]; // 웹 경로로 수정
			String descript = "/coffee/registerData/sellerData/beans/" + img[0]; // 웹 경로로 수정
			// 게시물 생성
			BeansDO newBeans = new BeansDO();
			newBeans.setBeanImg(beanImg);
			newBeans.setDescript(descript);
			newBeans.setSellerEmail(sellerEmail);
			newBeans.setBeanName(beanName);
			newBeans.setBeanPrice(beanPrice);
			newBeans.setCategoryNum(categoryNum);
			newBeans.setDeliveryCharge(deliveryCharge);

			// 데이터베이스에 새 게시물 추가
			beansDAO.insertBeans(newBeans);

		}
		return "redirect:/mainLoginSeller";
	}

	//찜하기
	@GetMapping("/like")
	public String like(HttpSession session, Model model, HttpServletRequest request) throws SQLException {

		String buyerEmail = String.valueOf(session.getAttribute("buyerEmail"));
		String beansNum = request.getParameter("beansNum");
		System.out.println("================");
		System.out.println(beansNum);
		System.out.println(buyerEmail);

		String sort = request.getParameter("sort");
		String page = request.getParameter("page");
		System.out.println(sort);

		//상품 목록에서 like 누르면
		if (sort.equals("myPage")) {
			likeService.clickLike(buyerEmail, Integer.parseInt(beansNum));

			return "redirect:/myPageBuyer";
		}
		else if(sort.equals("detail") ) {

			likeService.clickLike(buyerEmail, Integer.parseInt(beansNum));
			model.addAttribute("beansNum", Integer.parseInt(beansNum));

			return "redirect:/goListDetail";
			//상품 상세에서 like 누르면
		}
		else {

			likeService.clickLike(buyerEmail, Integer.parseInt(beansNum));
			model.addAttribute("sort", sort);
			model.addAttribute("page", page);

			return "redirect:/goProductList";


		}
	}

	// 상품 상태 수정하기로 이동
	@GetMapping("/productModify")
	public String productModify(@RequestParam("beansNum") int beansNum, Model model, HttpSession session){
		BeansDO beansDO= beansDAO.getBean(beansNum);
		String categoryName = beansDAO.getCategoryName(beansDO.getCategoryNum());
		
		System.out.println("categoryName" + categoryName);
		
		model.addAttribute("bean", beansDO);
		model.addAttribute("cname", categoryName);

		return "productModify";
	}
	
	// 상품 정보 수정하기 페이지로 이동
		@GetMapping("/modifyInfo")
		public String modifyInfo(@RequestParam("beansNum") int beansNum, Model model, HttpSession session){
			BeansDO beansDO= beansDAO.getBean(beansNum);
			String categoryName = beansDAO.getCategoryName(beansDO.getCategoryNum());			
			model.addAttribute("bean", beansDO);
			model.addAttribute("cname", categoryName);

			return "modifyInfo";
		}
	
	// 상품 상태 수정
	@GetMapping("/setStatus")
	public String setStatus(HttpServletRequest request) {
		
		String command = request.getParameter("command");
		int beansNum = Integer.parseInt(request.getParameter("beansNum"));
		int status = Integer.parseInt(request.getParameter("statusNumber"));
		
		
		if(command.equals("register")) {
			if(status==0) {
				beansDAO.beansRestore(beansNum);
				
			} else if(status==1) {
				beansDAO.beansSoldout(beansNum);
			}
		}
		else if(command.equals("cancel")) {
			
			return "redirect:/myPageSeller";
		}
		
		return "redirect:/myPageSeller";
	}
	
	//상품 정보 수정
	@PostMapping("/doModifyInfo")
	public String doModifyInfo(
			@ModelAttribute BeansDO command,
			Model model, 
			HttpServletRequest request, HttpServletResponse response, 
			HttpSession session, String[] img) 
			throws ServletException, IOException {
		
		String directory = "C:/Users/jsseo/git/coffee/src/main/webapp/registerData/sellerData/beans" ;
		//String directory = "D:/multicampus_project/coffee//coffee-please/src/main/webapp/registerData/sellerData/beans";
			int sizeLimit = 1024 * 1024 * 5;
			
			MultipartRequest multi = new MultipartRequest(request, directory, sizeLimit,
					"UTF-8", new DefaultFileRenamePolicy());
			String action = multi.getParameter("action"); //여기서 action은 jsp버튼의 action
			if (action != null && action.equals("doModifyInfo")) {
				
				String sellerEmail = String.valueOf(session.getAttribute("sellerEmail"));
				String beansNum = multi.getParameter("beansNum");
				String beanName = multi.getParameter("beanName");
				String categoryNum = multi.getParameter("categoryNum");
				int beanPrice = Integer.parseInt(multi.getParameter("beanPrice"));
				long deliveryCharge = Long.parseLong(multi.getParameter("deliveryCharge"));
								
				img = imgUpload.saveImg(multi, directory);
				
				String beanImg = "/coffee/registerData/sellerData/beans/" + img[1];  
				String descript = "/coffee/registerData/sellerData/beans/"+ img[0];  
				
				
				command.setCategoryNum(Integer.parseInt(categoryNum));
				command.setBeansNum(Integer.parseInt(beansNum));
				command.setSellerEmail(sellerEmail);
				command.setBeanName(beanName);
				command.setBeanPrice(beanPrice);
				command.setDeliveryCharge(deliveryCharge);
				command.setBeanImg(beanImg);
				command.setDescript(descript);

				beansDAO.modifyBeans(command);
				
				System.out.println("success");
			}
			return "redirect:/myPageSeller";
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}

