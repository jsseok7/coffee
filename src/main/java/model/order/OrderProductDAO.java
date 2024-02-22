package model.order;

import model.member.BuyerDO;
import model.product.BeansDO;
import model.product.OrderBeans;

import java.sql.*;
import java.util.ArrayList;

public class OrderProductDAO {

    private Connection conn;
    private Statement stmt;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private String sql;

    public OrderProductDAO(){

        String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
        String jdbc_url = "jdbc:oracle:thin:@localhost:1521:XE";

        try {
            Class.forName(jdbc_driver);
            conn = DriverManager.getConnection(jdbc_url,"scott","tiger");
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    // 나의 주문 등록
    public int insertOrderProduct(OrderProductDO orderProduct) throws SQLException {

        int rowCount = 0;
        this.sql = "insert into order_prod (buyer_email, order_total_price, before_order_point) values( ?, ?, ?)";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, orderProduct.getBuyerEmail());
            pstmt.setLong(2, orderProduct.getOrderTotalPrice());
            pstmt.setLong(3, orderProduct.getBeforeOrderPoint());

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

    //나의 주문내역 목록 요청
    public ArrayList<OrderProductDO> getBuyerOrderList(String email){

        ArrayList<OrderProductDO> buyerOrderList = new ArrayList<OrderProductDO>();
        this.sql = "select order_total_price, before_order_point,to_char(order_datetime, 'YYYY-MM-DD HH24:MI:SS') as regdate" +
                " from order_prod where buyer_email = ? order by order_datetime";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            OrderProductDO order = null;

            while (rs.next()) {
                order = new OrderProductDO();
                order.setBuyerEmail(email);
                order.setOrderDatetime(rs.getString("regdate"));
                order.setOrderTotalPrice(rs.getLong("order_total_price"));
                order.setBeforeOrderPoint(rs.getLong("before_order_point"));

                buyerOrderList.add(order);
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

            return buyerOrderList;
    }

    //나의 공동구매 주문내역 목록 요청
    public ArrayList<OrderBeans> getBuyerGroupOrderLists(String email){

        ArrayList<OrderBeans> buyerOrderList = new ArrayList<OrderBeans>();

            this.sql = "select beans.bean_img, beans.bean_name, beans.bean_price order_prod_detail.qty " +
                    "join beans on order_prod_detail.beans_num = beans.beans_num " +
                    "from order_prod_detail " +
                    "where buyer_email = ? and deadline is not null" +
                    "order by order_datetime";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            OrderBeans order = null;

            while (rs.next()) {
                order = new OrderBeans();

                order.getOrderProductDetailDO().setQty(rs.getInt("qty"));
                order.getBeansDO().setBeanPrice(rs.getInt("bean_price"));
                order.getBeansDO().setBeanImg(rs.getString("bean_img"));
                order.getBeansDO().setBeanName(rs.getString("bean_name"));

                buyerOrderList.add(order);
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

        return buyerOrderList;
    }

    // 나의 주문내역 목록 요청
    public ArrayList<OrderProductDO> getBuyerOrderLists(String email){

        ArrayList<OrderProductDO> buyerOrderList = new ArrayList<OrderProductDO>();
        this.sql = "select order_prod.order_total_price, order_prod.before_order_point,to_char(order_prod.order_datetime, 'YYYY-MM-DD HH24:MI:SS') as regdate " +
                "join order_prod_detail on order_prod.buyer_email = order_prod_detail.buyer_email " +
                "and order_prod.order_datetime = order_prod_detail.order_datetime " +
                "join beans on order_prod_detail.beans_num = beans.beans_num " +
                "from order_prod " +
                "where buyer_email = ? and deadline is null " +
                "order by order_datetime";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            OrderProductDO order = null;

            while (rs.next()) {
                order = new OrderProductDO();

                order.setOrderDatetime(rs.getString("regdate"));
                order.setOrderTotalPrice(rs.getLong("order_total_price"));
                order.setBeforeOrderPoint(rs.getLong("before_order_point"));

                buyerOrderList.add(order);
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

        return buyerOrderList;
    }

    

}
