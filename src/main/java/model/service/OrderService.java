package model.service;

import model.member.*;
import model.order.*;
import model.product.*;
import model.cart.*;
import model.cart.CartDO;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.sql.SQLException;
import java.util.ArrayList;

public class OrderService {

    BuyerDAO buyerDAO = new BuyerDAO();
    SellerDAO sellerDAO = new SellerDAO();
    BeansDAO beansDAO = new BeansDAO();
    CartDAO cartDAO = new CartDAO();
    OrderProductDAO orderProductDAO = new OrderProductDAO();
    OrderProductDetailDAO orderProductDetailDAO = new OrderProductDetailDAO();


    // 상품 즉시 구매
    public OrderProductDO onlyOnePayment(int beansNum, int qty, String buyerEmail) throws SQLException {

        OrderProductDO orderProductDO = new OrderProductDO();
        BeansDO bean = beansDAO.getBean(beansNum);
        long totalPrice = 0;

        // 일반 상품 구매 시
        if(bean.getDeadline() == null){
            totalPrice = bean.getBeanPrice() * qty;
        }
        // 공동 구매 상품 구매시
        else {
            totalPrice = bean.getGoalPrice() * qty;
        }
        long buyerPoint = checkPoint(buyerEmail);
        
        if(buyerPoint >= totalPrice){
        	orderProductDO.setBeforeOrderPoint(buyerPoint);
        	orderProductDO.setOrderTotalPrice(totalPrice);
            insertOrderProductDAO(buyerPoint, totalPrice, buyerEmail);
            insertOrderProductDetailDAO(buyerEmail, beansNum, qty);

            movePoint(bean.getSellerEmail(), buyerEmail, totalPrice);
            beansDAO.updateBeanTotalSellCount(beansNum, qty);

            return orderProductDO;
        }
        else return null;
    }

    //여러상품  결제
    public OrderProductDO cartPayment(String email) throws SQLException{

        long totalPrice= cartDAO.totalPrice(email);
        
        long buyerPoint = checkPoint(email);
        OrderProductDO orderProductDO = new OrderProductDO();
      
        if(buyerPoint>=totalPrice){
        	
        	  insertOrderProductDAO(buyerPoint, totalPrice, email);
         
        
        	ArrayList<CartBeans> cartBeans = cartDAO.getCartList(email);
        	
            for(CartBeans c : cartBeans) {
                BeansDO beansDO = c.getBeansDO();
                CartDO cartDO = c.getCartDO();
                insertOrderProductDetailDAO(email, beansDO.getBeansNum(), cartDO.getQty());

                String sellerEmail = beansDAO.getBean(beansDO.getBeansNum()).getSellerEmail();
                long price = (long) beansDO.getBeanPrice() * cartDO.getQty();
                movePoint(sellerEmail, email, price);
                beansDAO.updateBeanTotalSellCount(beansDO.getBeansNum(), cartDO.getQty());
                                
            }
	            orderProductDO.setBeforeOrderPoint(buyerPoint);
	            orderProductDO.setOrderTotalPrice(totalPrice);
	            cartDAO.clearCart(email);
	            return orderProductDO;
            
            
            //잔액부족
        }
        return null;
    }


    // 포인트 확인
    public long checkPoint(String email){

        long buyerPoint = buyerDAO.checkBuyerPoint(email);
        return buyerPoint;
    }

    // 구매자 포인트 차감 + 판매자 포인트 증가
    public void movePoint(String sellerEmail, String buyerEmail, long point){
        buyerDAO.buyerPointUpdate(buyerEmail, point);
        sellerDAO.sellerPointUpdate(sellerEmail, point);
        System.out.println(sellerEmail);
    }

    public boolean insertOrderProductDAO(long point, long price, String buyerEmail) throws SQLException {

        OrderProductDO orderProductDO = new OrderProductDO();
        orderProductDO.setBuyerEmail(buyerEmail);
        orderProductDO.setOrderTotalPrice(price);
        orderProductDO.setBeforeOrderPoint(point);

        orderProductDAO.insertOrderProduct(orderProductDO);

        return true;
    }
    public boolean insertOrderProductDetailDAO(String email, int num, int qty) throws SQLException {

        OrderProductDetailDO orderProductDetailDO = new OrderProductDetailDO();
        orderProductDetailDO.setBuyerEmail(email);
        orderProductDetailDO.setBeansNum(num);
        orderProductDetailDO.setQty(qty);

        orderProductDetailDAO.insertOrderProductDetail(orderProductDetailDO);
        return true;
    }

}
