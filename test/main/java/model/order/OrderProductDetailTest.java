package model.order;

import model.product.OrderBeans;
import org.junit.Test;

import java.sql.SQLException;
import java.util.ArrayList;

import static org.assertj.core.api.Assertions.*;

public class OrderProductDetailTest {

    OrderProductDetailDAO orderProductDetailDAO = new OrderProductDetailDAO();

    @Test
    public void insertOrderProductDetailTest() throws SQLException{
        OrderProductDetailDO order = new OrderProductDetailDO();

        order.setBuyerEmail("hmson@naver.com");
        order.setBeansNum(1);
        order.setQty(3);

        assertThat(orderProductDetailDAO.insertOrderProductDetail(order)).isEqualTo(1);
    }

    @Test
    public void getOrderProdDetailListTest() {
        ArrayList<OrderBeans> list = orderProductDetailDAO.getOrderProductDetailList("hmson@naver.com", "2023-11-01 14:06:03");
        for(OrderBeans i : list){
            assertThat(i.getOrderProductDetailDO().getBeansNum()).isEqualTo(0);
            assertThat(i.getOrderProductDetailDO().getQty()).isEqualTo(3);
            assertThat(i.getBeansDO().getBeanPrice()).isEqualTo(9999);

        }
    }
}
