package model.member;

import java.util.HashMap;

public class BuyerDO {

    private String buyerEmail;
    private String buyerName;
    private String nickname;
    private String passwd;
    private long point;
    private String tel;
    private String regdate;
    private String buyerImg;
    private String address;
    private Salt salt = new Salt();
    HashMap<String, String> saltValues = new HashMap<>();
    
    public void setSaltValue(String buyerEmail) {
        if(!saltValues.containsKey(buyerEmail)){
            String saltValue = salt.newSalt();
            saltValues.put(buyerEmail, saltValue);
        }
    }
    
    public String getSaltValue(String buyerEmail)
    {
        return saltValues.get(buyerEmail);
    }
    
    
    public String getBuyerEmail() {
        return buyerEmail;
    }

    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public long getPoint() {
        return point;
    }

    public void setPoint(long point) {
        this.point = point;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public String getBuyerImg() {
        return buyerImg;
    }

    public void setBuyerImg(String buyerImg) {
        this.buyerImg = buyerImg;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
