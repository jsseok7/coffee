//
//package model.product;
//
//import java.util.*;
//
//public class TestBeansDAO {
//
//	public static void main(String[] args) {
//		BeansDAO beansDAO = new BeansDAO();
//
//		/*
//		//상품 전체 목록 가져오기 테스트
//		ArrayList<BeansDO> beanList = beansDAO.getAllBeans();
//
//		for(BeansDO beans : beanList) {
//			System.out.printf("카테고리번호: %d \n" , beans.getCategoryNum());
//			System.out.printf("원두 이미지: %s \n" , beans.getBeanImg());
//			System.out.printf("좋아요 수 : %d \n" , beans.getLikeCount());
//			System.out.println("-----------------------------------------------------");
//
//	}
//
//		*///
//
//		/*
//		//상품 상세 가져오기 테스트
//		BeansDO bean = beansDAO.getBeansDO(2);
//
//			System.out.printf("원두이미지: %s \n" , bean.getBeanImg());
//			System.out.printf("원두이름: %s \n" , bean.getBeanName());
//			System.out.printf("배송비: %d \n ", bean.getDeliveryCharge());
//			System.out.printf("원두 가격: %d \n" ,bean.getBeanPrice());
//			System.out.printf("좋아요 수: %d \n ", bean.getLikeCount());
//			System.out.printf("상세설명: %s \n ", bean.getDescript());
//			System.out.println("--------------------------------------------------------");
//		*/
//
//		/*
//		//카테고리 목록 가져오기 테스트
//		ArrayList<CategoryDO> categoryList = beansDAO.getAllCategory();
//			for(CategoryDO category : categoryList) {
//				System.out.printf("원산지: %s \n" , category.getCategoryName());
//				System.out.println("--------------------------------------------------------");
//
//			}
//
//		*/
//
//		/*
//		//정렬
//		ArrayList<BeansDO> originList = beansDAO.arrayOrigin("파라과이");
//			for(BeansDO originbean : originList) {
//				System.out.println("");
//				System.out.println("");
//				System.out.printf("원두 이름: %s \n", originbean.getBeanName());
//				System.out.printf("원두 이미지: %s \n", originbean.getBeanImg());
//				System.out.printf("찜 수: %d \n", originbean.getLikeCount());
//
//			}
//			System.out.println("==============================================================");
//		*/
//
//		/*
//		//좋아요 순 정렬
//
//		ArrayList<BeansDO> likeList = beansDAO.arrayLikeCount();
//		for(BeansDO beanLike : likeList) {
//			System.out.println("");
//			System.out.println("");
//			System.out.printf("원두 이름: %s \n", beanLike.getBeanName());
//			System.out.printf("원두 이미지: %s \n", beanLike.getBeanImg());
//			System.out.printf("찜 수: %d", beanLike.getLikeCount());
//
//		}
//		System.out.println("=======================================================================");
//		*/
//
//		/*
//		//최신 순 정렬
//		ArrayList<BeansDO> recentList = beansDAO.arrayRecent();
//		for(BeansDO beanRecent : recentList) {
//			System.out.println("");
//			System.out.printf("원두 이름: %s \n", beanRecent.getBeanName());
//			System.out.printf("원두 이미지: %s \n", beanRecent.getBeanImg());
//			System.out.printf("찜 수: %d", beanRecent.getLikeCount());
//
//		}
//		System.out.println("-----------------------------------------------------------------");
//		*/
//
//		//장바구니 보이기
//		ArrayList<CartDO> cartList = beansDAO.getCartList("jinseok@gmail.com");
//		for(CartDO cart : cartList) {
//			System.out.println("");
//			System.out.printf("원두 이름: %s \n", cart.getBeanName());
//			System.out.printf("원두 가격: %s \n", cart.getBeanPrice());
//			System.out.printf("원두 이미지: %s \n", cart.getBeanImg());
//			System.out.printf("수량: %d \n", cart.getQty());
//
//			}
//		System.out.println("=============================================================================");
//	}
//}
//		//
//
//
//
