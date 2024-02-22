package model.like;

import model.product.BeansDAO;
import model.product.BeansDO;
import model.product.CartDO;
import model.product.LikeBeans;


import java.sql.*;
import java.util.ArrayList;

public class LikeDAO {
    private Connection conn;
    private Statement stmt;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private String sql;

    BeansDAO beansDAO = new BeansDAO();

    public LikeDAO(){

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

    //Like 테이블 확인
    public boolean checkLike(String email, int beanNum) throws SQLException {

        this.sql = "select buyer_email from bean_like where buyer_email = ? and " +
                "beans_num = ?";
        boolean result= false;

        try{
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setInt(2,beanNum);
        this.rs = pstmt.executeQuery();
        result = rs.next();


        }catch(Exception e) {
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
        return result;
    }

    //Like 테이블 등록
    public int insertLike(String email, int beanNum) {
        int rowCount = 0;
        try {
            this.sql = "insert into bean_like (buyer_email, beans_num) values (? , ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setInt(2, beanNum);

            rowCount = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                this.conn.setAutoCommit(true);

                if (!pstmt.isClosed()) {
                    pstmt.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return rowCount;
    }

    //Like 테이블 삭제
    public int deleteLike(String email, int beanNum){
        int rowCount = 0;
        this.sql = "delete from bean_like where buyer_email = ? " +
                "and beans_num = ?";
        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setInt(2, beanNum);
            rowCount = pstmt.executeUpdate();
        }
        catch (Exception e){
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

    //내가 찜한 목록 불러오기
    public ArrayList<LikeBeans> getLikeList(String email){

        ArrayList<LikeBeans> likeBeansList = new ArrayList<>();


        this.sql = "select beans.bean_name, beans.bean_price, beans.beans_num, beans.category_num, " +
                "beans.bean_img, beans.like_count " +
                "from bean_like " +
                "join beans on bean_like.beans_num = beans.beans_num " +
                "where bean_like.buyer_email = ?";

        try {
            this.pstmt = conn.prepareStatement(sql);
            this.pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            BeansDO beansDO;
            LikeBeans likeBeans;


            while(rs.next()) {
                beansDO = new BeansDO();
                likeBeans = new LikeBeans();
                beansDO.setBeanName(rs.getString("bean_name"));
                beansDO.setLikeCount(rs.getInt("like_count"));
                beansDO.setBeanImg(rs.getString("bean_img"));
                beansDO.setBeanPrice(rs.getInt("bean_price"));
                beansDO.setBeansNum(rs.getInt("beans_num"));


                likeBeans.setBeansDO(beansDO);
                likeBeansList.add(likeBeans);
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

        return likeBeansList;
    }
}
