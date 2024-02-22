package model.cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;


import model.member.BuyerDO;
import model.product.BeansDO;
import model.product.*;
import model.cart.*;

public class CartDAO {
	
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	public CartDAO() {
		String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
		String jdbc_url = "jdbc:oracle:thin:@localhost:1521:XE";

		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "scott", "tiger");
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 장바구니 상품 추가
	// 같은 상품 추가 시 "이미 등록한 상품입니다." msg 예외 띄우기
	public int addItem (String buyerEmail, BeansDO beansDO, int qty) {
		int rowCount = 0;
		
		sql = "insert into cart (buyer_email, beans_num, qty) values (?, ?, ?)";
		
		try {
				this.pstmt = conn.prepareStatement(this.sql);
				this.pstmt.setString(1, buyerEmail);
				this.pstmt.setInt(2, beansDO.getBeansNum());
				this.pstmt.setInt(3, qty);
				
				rowCount = this.pstmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				this.conn.setAutoCommit(true);
				
				if (!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return rowCount;		
	}
	
	// 장바구니 상품 삭제
	public int deleteItem(String buyerEmail, int beansNum) {
		int rowCount = 0;
		
		this.sql = "delete from cart where buyer_email = ? and beans_num = ?";
		
		try {
				this.pstmt = conn.prepareStatement(this.sql);
				this.pstmt.setString(1, buyerEmail);
				this.pstmt.setInt(2, beansNum);
				
				rowCount = this.pstmt.executeUpdate();				
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return rowCount;
	}
	
	// 장바구니 모든 상품 조회
	public ArrayList<CartBeans> getCartList(String buyerEmail) {
		ArrayList<CartBeans> cartList = new ArrayList<CartBeans>();
		
		this.sql = "select beans.beans_num, beans.bean_name, beans.bean_price, beans.bean_img, cart.qty "+
	   			"from cart " + 
	   			"join buyer on cart.buyer_email = buyer.buyer_email " +
	   			"join beans on cart.beans_num = beans.beans_num " +
	   			"where cart.buyer_email = ?";
		
		try {
			this.pstmt = conn.prepareStatement(this.sql);
			this.pstmt.setString(1, buyerEmail);
			rs = this.pstmt.executeQuery();

			CartBeans cartBeans;
			CartDO cart;
			BeansDO beansDO;

			while(rs.next()) {
				cartBeans = new CartBeans();
				cart = new CartDO();
				beansDO = new BeansDO();

				beansDO.setBeansNum(rs.getInt("beans_num"));
				beansDO.setBeanName(rs.getString("bean_name"));
	            beansDO.setBeanPrice(rs.getInt("bean_price"));
	            beansDO.setBeanImg(rs.getString("bean_img"));
				beansDO.setBeansNum(rs.getInt("beans_num"));
	            
	            cart.setBeansDO(beansDO);
	            cart.setQty(rs.getInt("qty"));

				cartBeans.setCartDO(cart);
				cartBeans.setBeansDO(beansDO);

				cartList.add(cartBeans);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return cartList;
	}
	
	// 장바구니 상품 총 금액
//	public Long totalPrice(BeansDO beansDO, int qty) {
//		Long qtyL = (long) qty;
//		return beansDO.getBeanPrice() * qtyL;
//		
//	}
	public long totalPrice(String buyerEmail) {
		ArrayList<CartBeans> cartList = getCartList(buyerEmail);
		long total = 0;

		 for (CartBeans cart : cartList) {
		        BeansDO beansDO = cart.getBeansDO();
				CartDO cartDO = cart.getCartDO();
		        int qty = cartDO.getQty();
		        long price = beansDO.getBeanPrice();

		        total += price * qty;
		    }
		return total;
	}
	
	// 결제 후 장바구니 비우기 (결제 완료에서 메서드 호출)
	public int clearCart(String buyerEmail) {
	    int rowCount = 0;

	    this.sql = "delete from cart where buyer_email = ?";

	    try {
	        this.pstmt = conn.prepareStatement(this.sql);
	        this.pstmt.setString(1, buyerEmail);

	        rowCount = this.pstmt.executeUpdate();
	    }
	    catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	    return rowCount;
	}
	
	// 상품 여부 조회
	public boolean checkItem(String buyerEmail, int beansNum) {
		int rowCount = 0;
		this.sql = "select * from cart where buyer_email = ? and beans_num = ?";
		
		try {
	        this.pstmt = conn.prepareStatement(this.sql);
	        this.pstmt.setString(1, buyerEmail);
	        this.pstmt.setInt(2, beansNum);

	        rowCount = this.pstmt.executeUpdate();
	    }
	    catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
		}	
		
		return rowCount == 0 ? false : true;
	}
}
