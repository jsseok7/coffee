package model.order;

import model.service.OrderService;
import org.junit.Test;

import java.sql.SQLException;
import static org.assertj.core.api.Assertions.*;

public class OrderTest {

    OrderService orderService = new OrderService();

    @Test
    public void onlyOnePaymentTest() throws SQLException {
        OrderProductDO result = orderService.onlyOnePayment(0, 3, "hmson@naver.com");
        assertThat(result).isEqualTo(null);
    }

}
