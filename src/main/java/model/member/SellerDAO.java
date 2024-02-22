package model.member;

import java.sql.*;
import java.util.Objects;

public class SellerDAO {

    private Connection conn;
    private Statement stmt;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private String sql;

    public SellerDAO(){
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

    //판매자 회원 가입
    public int insertSeller(SellerDO seller) throws Exception{

        int rowCount = 0;
        boolean isIdDuplicate = false;

        try{
            this.conn.setAutoCommit(false);

            this.sql = "select seller_email from seller where seller_email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, seller.getSellerEmail());
            this.rs = pstmt.executeQuery();

            if(!rs.next()){
                this.sql = "insert into seller (seller_email, business_name, business_num, nickname, passwd, tel, adr, seller_img) values (?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, seller.getSellerEmail());
                pstmt.setString(2, seller.getBusinessName());
                pstmt.setString(3, seller.getBusinessNum());
                pstmt.setString(4, seller.getNickname());
                pstmt.setString(5, seller.getPasswd());
                pstmt.setString(6, seller.getTel());
                pstmt.setString(7, seller.getAddress());
                pstmt.setString(8, seller.getSellerImg());

                rowCount = pstmt.executeUpdate();
                this.conn.commit();
            }
            else{
                isIdDuplicate = true;
                this.conn.rollback();
            }

        }
        catch (Exception e){
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

        if(isIdDuplicate){
            throw new Exception("아이디가 중복되었습니다");
        }

        return rowCount;
    }

    //판매자 회원 정보 수정 - 수정 가능한 항목 판단후 진행 판매자명, 폰번호, 주소, 이미지
    public int updateSeller(SellerDO seller){
        int rowCount = 0;
        this.sql = "update seller set nickname = ? , tel = ?, adr = ?, seller_img = ? where seller_email = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, seller.getNickname());
            pstmt.setString(2, seller.getTel());
            pstmt.setString(3, seller.getAddress());
            pstmt.setString(4, seller.getSellerImg());
            pstmt.setString(5, seller.getSellerEmail());


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

    //판매자 회원 정보 삭제
    public int deleteSeller(String email){

        int rowCount = 0;
        this.sql = "delete from seller where seller_email = ?";

        try{
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
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

    //판매자 회원 정보 요청
    public SellerDO getSeller(String email){

        SellerDO seller = new SellerDO();
        this.sql = "select seller_email, business_name, business_num, nickname, passwd, point, tel, to_char(regdate, 'YYYY-MM-DD HH24:MI:SS') as regdate," +
                "seller_img, adr from seller where seller_email = ?";

        try{
            this.pstmt = conn.prepareStatement(sql);
            this.pstmt.setString(1, email);
            rs = this.pstmt.executeQuery();

            if(rs.next()){
                seller.setSellerEmail(email);
                seller.setBusinessName(this.rs.getString("business_name"));
                seller.setBusinessNum(this.rs.getString("business_num"));
                seller.setNickname(this.rs.getString("nickname"));
                seller.setPasswd(this.rs.getString("passwd"));
                seller.setPoint(this.rs.getLong("point"));
                seller.setTel(this.rs.getString("tel"));
                seller.setRegdate(this.rs.getString("regdate"));
                seller.setSellerImg(this.rs.getString("seller_img"));
                seller.setAddress(this.rs.getString("adr"));
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

        return seller;
    }

    //판매자 포인트 확인
    public long checkSellerPoint(String email){
        long point = 0;
        this.sql = "select point from seller where seller_email = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,email);
            rs = pstmt.executeQuery();

            rs.next();

            point = rs.getLong("point");
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

        return point;
    }

    //판매자 결제시 POINT 변경
    public int sellerPointUpdate(String email, long point){
        int rowCount = 0;
        this.sql = "update seller set point = point + ? where seller_email = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, point);
            pstmt.setString(2,email);

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

    //아이디 중복확인 - 중복 시 false 중복 아닐 시 true
    public boolean checkSellerId(String email){
        boolean isCheckSellerId = true;

        this.sql = "select seller_email from seller where seller_email = ?";

        try{
            this.pstmt = conn.prepareStatement(sql);
            this.pstmt.setString(1, email);
            rs = this.pstmt.executeQuery();

            //아이디 중복
            if(rs.next()){
                isCheckSellerId = false;
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

        return isCheckSellerId;
    }

    //로그인 - 비밀번호 확인 , 비밀번호 일치 시 true, 불일치 시 false
    public boolean checkSellerPasswd(String email, String passwd){

        boolean isCheckSellerPasswd = false;

        this.sql = "select passwd from seller where seller_email = ?";
        try{
            this.pstmt = conn.prepareStatement(sql);
            this.pstmt.setString(1, email);
            rs = this.pstmt.executeQuery();

            if(rs.next()){
                if(Objects.equals(this.rs.getString("passwd"), passwd)){
                    isCheckSellerPasswd = true;
                }
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

        return isCheckSellerPasswd;
    }

    //conn 종료
    public void closeConn(){
        try {
            if (!conn.isClosed()){
                conn.close();
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}
