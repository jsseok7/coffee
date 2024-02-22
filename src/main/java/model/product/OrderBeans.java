package model.product;

import model.order.OrderProductDO;
import model.order.OrderProductDetailDO;

public class OrderBeans {
    private BeansDO beansDO;

    private OrderProductDetailDO orderProductDetailDO;

    private OrderProductDO orderProductDO;
    private String categoryName;

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public OrderProductDO getOrderProductDO() {
        return orderProductDO;
    }

    public void setOrderProductDO(OrderProductDO orderProductDO) {
        this.orderProductDO = orderProductDO;
    }

    public BeansDO getBeansDO() {
        return beansDO;
    }

    public OrderProductDetailDO getOrderProductDetailDO() {
        return orderProductDetailDO;
    }

    public void setBeansDO(BeansDO beansDO) {
        this.beansDO = beansDO;
    }

    public void setOrderProductDetailDO(OrderProductDetailDO orderProductDetailDO) {
        this.orderProductDetailDO = orderProductDetailDO;
    }

}
