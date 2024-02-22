package model.order;

public class OrderProductDetailDO {

    private String buyerEmail;
    private String orderDatetime;
    private int beansNum;
    private int qty;

    public String getBuyerEmail() {
        return buyerEmail;
    }

    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }

    public String getOrderDatetime() {
        return orderDatetime;
    }

    public void setOrderDatetime(String orderDatetime) {
        this.orderDatetime = orderDatetime;
    }

    public int getBeansNum() {
        return beansNum;
    }

    public void setBeansNum(int beansNum) {
        this.beansNum = beansNum;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }
}
