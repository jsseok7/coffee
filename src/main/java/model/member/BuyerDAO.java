package model.member;

import java.sql.*;
import java.util.Objects;

public class BuyerDAO {

    private Connection conn;
    private Statement stmt;
    private PreparedStatement pstmt;
    private ResultSet rs;
    private String sql;

    public BuyerDAO(){

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

    //구매자 회원 가입
    public int insertBuyer(BuyerDO buyer) throws Exception{

        int rowCount = 0;
        boolean isIdDuplicate = false;

        try{
            this.conn.setAutoCommit(false);

            this.sql = "select buyer_email from buyer where buyer_email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, buyer.getBuyerEmail());
            this.rs = pstmt.executeQuery();

            if(!rs.next()){
                this.sql = "insert into buyer (buyer_email, buyer_name, nickname, passwd, tel, adr, buyer_img) values (?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, buyer.getBuyerEmail());
                pstmt.setString(2, buyer.getBuyerName());
                pstmt.setString(3, buyer.getNickname());
                pstmt.setString(4, buyer.getPasswd());
                pstmt.setString(5, buyer.getTel());
                pstmt.setString(6, buyer.getAddress());
                pstmt.setString(7, buyer.getBuyerImg());
                
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

    //구매자 회원 정보 수정 - 구매자명, 주소, 폰번호, 이미지
    public int updateBuyer(BuyerDO buyer){
        int rowCount = 0;
        this.sql = "update buyer set nickname = ?,  tel = ?, adr = ?, buyer_img = ? where buyer_email = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, buyer.getNickname());
            pstmt.setString(2, buyer.getTel());
            pstmt.setString(3, buyer.getAddress());
            pstmt.setString(4, buyer.getBuyerImg());
            pstmt.setString(5, buyer.getBuyerEmail());


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

    //구매자 회원 정보 삭제
    public int deleteBuyer(String email){
        int rowCount = 0;
        this.sql = "delete from buyer where buyer_email = ?";

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

    //구매자 회원 정보 요청
    public BuyerDO getBuyer(String email){

        BuyerDO buyer = new BuyerDO();
        this.sql = "select buyer_email, buyer_name, nickname, passwd, point, tel, to_char(regdate, 'YYYY-MM-DD HH24:MI:SS') as regdate," +
                "buyer_img, adr from buyer where buyer_email = ?";

        try{
            this.pstmt = conn.prepareStatement(sql);
            this.pstmt.setString(1, email);
            rs = this.pstmt.executeQuery();

            if(rs.next()){
                buyer.setBuyerEmail(this.rs.getString("buyer_email"));
                buyer.setBuyerName(this.rs.getString("buyer_name"));
                buyer.setNickname(this.rs.getString("nickname"));
                buyer.setPasswd(this.rs.getString("passwd"));
                buyer.setPoint(this.rs.getLong("point"));
                buyer.setTel(this.rs.getString("tel"));
                buyer.setRegdate(this.rs.getString("regdate"));
                buyer.setBuyerImg(this.rs.getString("buyer_img"));
                buyer.setAddress(this.rs.getString("adr"));
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

        return buyer;
    }

    //아이디 중복확인 - 중복 시 false 중복 아닐 시 true
    public boolean checkBuyerId(String email){
        boolean isCheckBuyerId = true;

        this.sql = "select buyer_email from buyer where buyer_email = ?";

        try{
            this.pstmt = conn.prepareStatement(sql);
            this.pstmt.setString(1, email);
            rs = this.pstmt.executeQuery();

            //아이디 중복
            if(rs.next()){
                isCheckBuyerId = false;
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

        return isCheckBuyerId;
    }

    //로그인 - 비밀번호 확인 ,비밀번호 일치 시 true, 불일치 시 false
    public boolean checkBuyerPasswd(String email, String passwd){

        boolean isCheckBuyerPasswd = false;

        this.sql = "select passwd from buyer where buyer_email = ?";

        try{
            this.pstmt = conn.prepareStatement(sql);
            this.pstmt.setString(1, email);
            rs = this.pstmt.executeQuery();

            if(rs.next()){
                if(Objects.equals(this.rs.getString("passwd"), passwd)){
                    isCheckBuyerPasswd = true;
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

        return isCheckBuyerPasswd;
    }

    //구매자 포인트 확인
    public  long checkBuyerPoint(String email){
        long point = 0;
        this.sql = "select point from buyer where buyer_email = ?";

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

    //구매자 결제시 포인트 변경
    public int buyerPointUpdate(String email, long point){
        int rowCount = 0;
        this.sql = "update buyer set point = point - ? where buyer_email = ?";

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
