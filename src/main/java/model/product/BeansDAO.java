package main.java.model.product;
//package model.product;

import main.java.model.member.BuyerDO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

//import model.member.BuyerDO;
//import model.member.SellerDO;

public class BeansDAO {

	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	public BeansDAO() {
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

	// 상품 '정보' 조회
	public BeansDO getBean(int beansNum) {

		BeansDO beans = new BeansDO();

		sql = "select bean_name, bean_price, bean_img, descript, delivery_charge, bean_thumbnail " + 
			  "from beans where beans_num = ?";

		try {
			this.pstmt = conn.prepareStatement(this.sql);
			this.pstmt.setInt(1, beansNum);
			rs = this.pstmt.executeQuery();

			if (rs.next()) {
				beans.setBeanName(rs.getString("bean_name"));
				beans.setBeanPrice(rs.getInt("bean_price"));
				beans.setBeanImg(rs.getString("bean_img"));
				beans.setDescript(rs.getString("descript"));
				beans.setDeliveryCharge(rs.getInt("delivery_charge"));
				beans.setBeanThumbnail(rs.getString("bean_thumbnail"));
			}
		} 
		catch (Exception e) {
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
		return beans;
	}
	
	// 상품 '검색' 및 페이징 처리
	public ArrayList<BeansDO> searchBeans(String beanName, int page) {
		ArrayList<BeansDO> searchResult = new ArrayList<BeansDO>();

		this.sql = "select * " + 
				"from (select beans_num, bean_name, bean_price, bean_img, beans_regdate, rownum as rnum " + 
				"from beans " + 
				"where length(bean_name) >= 2 and bean_name like ?) " + 
				"where rnum between ? and ? " + 
				"ORDER BY beans_regdate desc";

		try {
			this.pstmt = conn.prepareStatement(this.sql);
			this.pstmt.setString(1, "%" + beanName + "%");
			// 0페이지 1 - 15 / 1페이지 15 - 30 ...
			this.pstmt.setInt(2, (page * 15) + 1);
			this.pstmt.setInt(3, (page + 1) * 15);
			rs = this.pstmt.executeQuery();

			while (rs.next()) {
				BeansDO beans = new BeansDO();

				beans.setBeansNum(rs.getInt("beans_num"));
				beans.setBeanName(rs.getString("bean_name"));
				beans.setBeanPrice(rs.getInt("bean_price"));
				beans.setBeanImg(rs.getString("bean_img"));

				searchResult.add(beans);
			}
		} 
		catch (Exception e) {
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
		return searchResult;
	}
	// 검색 후 마지막 페이지 처리
	public int SearchLastPage(String beanName) {
		int result = 0;
		
		sql = "select count(beans_num) as count from beans where bean_name like ?";
		
		try {
			this.pstmt = conn.prepareStatement(this.sql);
			this.pstmt.setString(1, "%" + beanName + "%");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int count = rs.getInt("count");
				
				result = count / 15;
				if(count % 15 != 0) {
					result++;
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		} 
		finally {
			try {
				if (!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	// 공동구매 상품 조회 (추가 수정 필요)
	public BeansDO getGroupBean(int beansNum) {
		BeansDO beans = new BeansDO();
		
		this.sql = "select * from beans where deadline is not null and beans_num = ?";

		try {
			this.pstmt = conn.prepareStatement(this.sql);
			this.pstmt.setInt(1, beansNum);
			rs = this.pstmt.executeQuery();

			if (rs.next()) {
				beans.setBeanName(rs.getString("bean_name"));
				beans.setBeanPrice(rs.getInt("bean_price"));
				beans.setBeanImg(rs.getString("bean_img"));
				beans.setDescript(rs.getString("descript"));
				beans.setDeliveryCharge(rs.getInt("delivery_charge"));
				beans.setBeanThumbnail(rs.getString("bean_thumbnail"));
				beans.setDeadline(rs.getString("deadline"));
				beans.setGoalQty(rs.getInt("goal_qty"));
				beans.setGoalPrice(rs.getInt("goal_price"));
			}
		} 
		catch (Exception e) {
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
		return beans;
	}
	
	// 베스트 원두 5개
	public ArrayList<BeansDO> bestBeanArray() {
		ArrayList<BeansDO> beanList = new ArrayList<BeansDO>();
		sql = "select bean_img, like_count, rownum from" +
				"(select bean_img, like_count, rownum from beans order by like_count desc)" +
				"where rownum between 1 and 5"; 
    	try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			BeansDO beansDO = null;
			
			while(rs.next()) {
				beansDO = new BeansDO();
				
				beansDO.setBeanImg(rs.getString("bean_img"));
				beansDO.setLikeCount(rs.getInt("like_count"));
				
				beanList.add(beansDO);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
    	return beanList;
    }
	 //상품 상세보기
    public BeansDO getBeansDO(int beanNum) {
    	BeansDO bean = null;
    	this.sql = "select bean_img, bean_name, delivery_charge, bean_price, like_count, descript from beans where beans_num = ?";
    	try {
			this.pstmt = conn.prepareStatement(sql);
			
			this.pstmt.setInt(1, beanNum);
		return bestBeans;
	}
	
	// 상품 목록 페이지 -테스트
	public ArrayList<BeansDO> getBeansList(int page, int pageSize) {

		ArrayList<BeansDO> resultList = new ArrayList<BeansDO>();
		
		int startRow = 1 + (page-1)*15; // 1, 16, 31, 46, 61
		int endRow = 15*page; // 15, 30, 45, 60

		sql = "select * from ("
				+ "	select rownum rnum, b.* from ("
				+ "		select * from beans order by beans_num desc"
				+ "	) b "
				+ ") "
				+ "where rnum between ? and ?";

		try {
			this.pstmt = conn.prepareStatement(this.sql);
	        this.pstmt.setInt(1, startRow);
	        this.pstmt.setInt(2, endRow);
			rs = this.pstmt.executeQuery();

			while (rs.next()) {
				BeansDO beans = new BeansDO();

				beans.setBeansNum(rs.getInt("beans_num"));
				beans.setBeanName(rs.getString("bean_name"));
				beans.setBeanPrice(rs.getInt("bean_price"));
				beans.setBeanImg(rs.getString("bean_img"));
				beans.setLikeCount(rs.getInt("like_count"));

				resultList.add(beans);
			}
		} 
		catch (Exception e) {
			e.printStackTrace();
		} 
		finally {
			try {
				if (this.pstmt != null && !this.pstmt.isClosed()) {
					this.pstmt.close();
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultList;
	}
	
	// 총 행 수를 구하는 메서드
	public int getTotalRows() {
	    int totalRows = 0;
	    sql = "select count(*) from beans";
	    
	    try {
	        this.pstmt = conn.prepareStatement(this.sql);
	        rs = this.pstmt.executeQuery();

	        if (rs.next()) {
	            totalRows = rs.getInt(1);
	        }
	    } 
	    catch (Exception e) {
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
	    return totalRows;
	}
	
    //일반 판매 상품 등록하기
    //beans_num : 자동
    //판매자 이메일, 카테고리 번호, 원두 이름, 원두 가격, 원두 이미지, 원두 상세설명(이미지), 배송비, 원두 썸네일
	public int insertBean(BeansDO beansDO) {
		int rowCount = 0;
		try {
			this.conn.setAutoCommit(false);
				
				this.sql = "INSERT INTO BEANS (BEANS_NUM, SELLER_EMAIL, CATEGORY_NUM, BEAN_NAME, BEAN_PRICE, "
						+ "BEAN_IMG, DESCRIPT, DELIVERY_CHARGE)"
						+ "VALUES (seq_beans_beans_num.nextval, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, beansDO.getSellerEmail());
				pstmt.setInt(2, beansDO.getCategoryNum());
				pstmt.setString(3, beansDO.getBeanName());
				pstmt.setInt(4, beansDO.getBeanPrice());
				pstmt.setString(5, beansDO.getBeanImg());
				pstmt.setString(6, beansDO.getDescript());
				pstmt.setInt(7, beansDO.getDeliveryCharge());
					
				rowCount = pstmt.executeUpdate();
				this.conn.commit();			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	//공동 구매 상품 등록하기
	
	public int insertGroupBean (BeansDO beansDO) {
		int rowCount = 0;
		try {
			this.conn.setAutoCommit(false);
				
			if(!rs.next()) {
				this.sql = "insert into beans (beans_num, seller_email, bean_name, bean_price, goal_price, category_num, goal_qty, deadline, delivery_charge, bean_thumnail, descript, bean_img)"
						 + "values (seq_beans_beans_num.nextval, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, beansDO.getSellerEmail());
				pstmt.setString(2, beansDO.getBeanName());
				pstmt.setInt(3, beansDO.getBeanPrice());
				pstmt.setInt(4, beansDO.getGoalPrice());
				pstmt.setInt(5, beansDO.getCategoryNum());
				pstmt.setInt(6, beansDO.getGoalQty());
				pstmt.setString(7, beansDO.getDeadline());
				pstmt.setInt(8, beansDO.getDeliveryCharge());
				pstmt.setString(9, beansDO.getBeanThumbnail());
				pstmt.setString(10, beansDO.getDescript());
				pstmt.setString(11, beansDO.getBeanImg());
					
				rowCount = pstmt.executeUpdate();
				this.conn.commit();
			}
			else {
				this.conn.rollback();
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	//등록한 물품을 판매종료 로 만들기 -> status를 바꾸기, 1이면 판매종료
	public int beansSoldout(BeansDO beansDO) {
		int rowCount = 0;
		
		this.sql = "update beans set status = 1 where beans_num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, beansDO.getBeansNum());
			rowCount = pstmt.executeUpdate(); 
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	//상품 정보 수정하기
	public int modifyBeans(BeansDO beansDO) {
		int rowCount = 0;
		this.sql = "update beans set bean_name = ?, bean_price = ?, "
				+ "delivery_charge =?, bean_img = ?, descript = ?, bean_thumbnail = ? where beans_num = ?";
		try {
 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, beansDO.getBeanName());
			pstmt.setInt(2, beansDO.getBeanPrice());
			pstmt.setInt(3, beansDO.getDeliveryCharge());
			pstmt.setString(4, beansDO.getBeanImg());
			pstmt.setString(5, beansDO.getDescript());
			pstmt.setString(6, beansDO.getBeanThumbnail());
			pstmt.setInt(7, beansDO.getBeansNum());
			rowCount = pstmt.executeUpdate(); 
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	//카테고리 번호목록(국기 리스트)가져오기 - 카테고리 컬럼에 이미지로 대체할듯
	public ArrayList<CategoryDO> getAllCategory()  {
    	ArrayList<CategoryDO> categoryList = new ArrayList<CategoryDO>();
    	this.sql = "select c_name from category";
    	try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			CategoryDO category = null;
			
			while(rs.next()) {
				category = new CategoryDO();
				
				category.setCategoryName(rs.getString("c_name"));

				
				categoryList.add(category);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
    	return categoryList;
    }
	
	//원두 정렬하기 - 원산지별
	
	public ArrayList<BeansDO> arrayOrigin(String cName){
		ArrayList<BeansDO> beanList = new ArrayList<BeansDO>();
	
	   	this.sql = "select beans.bean_name, beans.bean_img, beans.like_count  "
	   				+ "from beans join category on category.category_num = beans.category_num where c_name = ?"
	   				+ "order by beans.beans_regdate desc";
	   	try {
			this.pstmt = conn.prepareStatement(sql);
			
			this.pstmt.setString(1, cName);
			rs = this.pstmt.executeQuery();
			
			while(rs.next()) {
				BeansDO bean = new BeansDO();
				bean.setBeanName(rs.getString("bean_name"));
				bean.setBeanImg(rs.getString("bean_img"));
				bean.setLikeCount(rs.getInt("like_count"));
				
				beanList.add(bean);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();					
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}		
    	return beanList;
	}
	
	//좋아요 많은 순 정렬
	public ArrayList<BeansDO> arrayLikeCount()  {
    	ArrayList<BeansDO> beanList = new ArrayList<BeansDO>();
    	this.sql = "select bean_name, bean_img, like_count from beans order by like_count desc";
    	try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			BeansDO beansDO = null;
			
			while(rs.next()) {
				beansDO = new BeansDO();
				
				beansDO.setBeanName(rs.getString("bean_name"));
				beansDO.setBeanImg(rs.getString("bean_img"));
				beansDO.setLikeCount(rs.getInt("like_count"));
				
				beanList.add(beansDO);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
    	return beanList;
    }
	public ArrayList<BeansDO> arrayRecent()  {
    	ArrayList<BeansDO> beanList = new ArrayList<BeansDO>();
    	this.sql = "select bean_name, bean_img, like_count from beans order by beans_regdate desc";
    	try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			BeansDO beansDO = null;
			
			while(rs.next()) {
				beansDO = new BeansDO();
				
				beansDO.setBeanName(rs.getString("bean_name"));
				beansDO.setBeanImg(rs.getString("bean_img"));
				beansDO.setLikeCount(rs.getInt("like_count"));
				
				beanList.add(beansDO);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				if(!stmt.isClosed()) {
					stmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
    	return beanList;
    }
	//선택 물품 장바구니에 넣기
	public int insertCart(CartDO cartDO, String buyerEmail) {
		int rowCount = 0;
		try {
			this.conn.setAutoCommit(false);
				
			if(!rs.next()) {
				this.sql = "INSERT INTO cart (BEANS_NUM, BUYER_EMAIL, qty)"
						+ "VALUES (?, ? ,?)";
				pstmt = conn.prepareStatement(sql);			
				pstmt.setString(1, cartDO.getBuyerEmail());
				pstmt.setInt(2, cartDO.getBeansNum());
				pstmt.setInt(3, cartDO.getQty());
					
				rowCount = pstmt.executeUpdate();
				this.conn.commit();
			}
			else {
				this.conn.rollback();
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	//장바구니 속 상품을 장바구니에서 삭제하기
	public int deleteItem(BuyerDO buyerDO, int beansNum) {
		int rowCount = 0;
		CartDO cart = new CartDO();
		try {
			this.conn.setAutoCommit(false);
				
			if(!rs.next()) {
				this.sql = "delete from cart where cart.beans_num = ?";
				pstmt = conn.prepareStatement(sql);			
				pstmt.setInt(1, cart.getBeansNum());
				rowCount = pstmt.executeUpdate();
				this.conn.commit();
			}
			else {
				this.conn.rollback();
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {			
			try {
				this.conn.setAutoCommit(true);
				
				if(!pstmt.isClosed()) {
					pstmt.close();
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return rowCount;
	}
	
	//장바구니 보이기
	public ArrayList<CartDO> getCartList(String buyerEmail){
		ArrayList<CartDO> cartList = new ArrayList<CartDO>();
	
	   	this.sql = "select beans.bean_name, beans.bean_price, beans.bean_img, cart.qty "+
	   			"from cart " + 
	   			"join buyer on cart.buyer_email = buyer.buyer_email " +
	   			"join beans on cart.beans_num = beans.beans_num " +
	   			"where cart.buyer_email = ?";
	   	try {
			this.pstmt = conn.prepareStatement(sql);
			
			this.pstmt.setString(1, buyerEmail);
			rs = this.pstmt.executeQuery();
			
			while(rs.next()) {
				CartDO cart = new CartDO();
				cart.setBeanName(rs.getString("bean_name"));
				cart.setBeanPrice(rs.getInt("bean_price"));
				cart.setBeanImg(rs.getString("bean_img"));
				cart.setQty(rs.getInt("qty"));
				
				cartList.add(cart);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!pstmt.isClosed()) {
					pstmt.close();					
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}		
    	return cartList;
	}
	//

}

