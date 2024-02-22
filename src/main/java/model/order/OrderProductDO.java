package model.order;

public class OrderProductDO {

    private String buyerEmail;
    private String orderDatetime;
    private long orderTotalPrice;
    private long beforeOrderPoint;

    public long getOrderTotalPrice() {
        return orderTotalPrice;
    }

    public void setOrderTotalPrice(long orderTotalPrice) {
        this.orderTotalPrice = orderTotalPrice;
    }

    public long getBeforeOrderPoint() {
        return beforeOrderPoint;
    }

    public void setBeforeOrderPoint(long beforeOrderPoint) {
        this.beforeOrderPoint = beforeOrderPoint;
    }

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
}
