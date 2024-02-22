package model.member;

//import main.java.model.*;
import org.junit.Test;

import static org.assertj.core.api.Assertions.*;

public class BuyerDAOTest {

    BuyerDAO buyerDAO = new BuyerDAO();
    @Test
    public void insertBuyerTest() throws Exception {

        BuyerDO buyer = new BuyerDO();

        buyer.setBuyerEmail("hjjang@naver.com");
        buyer.setBuyerName("장현준");
        buyer.setNickname("현준현준");
        buyer.setPasswd("qqqqwwww");
        buyer.setTel("111222");
        buyer.setAddress("통영");
        buyer.setPoint(1000000);

        assertThat(buyerDAO.insertBuyer(buyer)).isEqualTo(1);
    }

    @Test
    public void updateBuyerTest(){

        BuyerDO buyer = new BuyerDO();

        buyer.setNickname("흥민흥민");
        buyer.setTel("777777");
        buyer.setAddress("부산시 부산진구");
        buyer.setBuyerImg("buyerImg-url");
        buyer.setBuyerEmail("hmson@naver.com");

        assertThat(buyerDAO.updateBuyer(buyer)).isEqualTo(1);

    }

    @Test
    public void getBuyerTest(){

        BuyerDO buyer = buyerDAO.getBuyer("kilee@naver.com");

        assertThat(buyer.getBuyerName()).isEqualTo("이강인");
        assertThat(buyer.getNickname()).isEqualTo("강인강인");
        assertThat(buyer.getPasswd()).isEqualTo("qqqqwwww");
        assertThat(buyer.getPoint()).isEqualTo(1000000);
        assertThat(buyer.getTel()).isEqualTo("123123");
        assertThat(buyer.getAddress()).isEqualTo("부산시 중구");

    }

    @Test
    public void checkBuyerIdTest(){

        //중복된 아이디
        assertThat(buyerDAO.checkBuyerId("hmson@naver.com")).isEqualTo(false);

        //새로운 아이디
        assertThat(buyerDAO.checkBuyerId("jhj@naver.com")).isEqualTo(true);
    }

    @Test
    public void checkBuyerPasswdTest(){

        //passwd 일치
        assertThat(buyerDAO.checkBuyerPasswd("hmson@naver.com","qqqqwwww")).isEqualTo(true);

        //passwd 불일치
        assertThat(buyerDAO.checkBuyerPasswd("hmson@naver.com","12341234")).isEqualTo(false);

    }

    @Test
    public void checkBuyerPointTest(){
        assertThat(buyerDAO.checkBuyerPoint("hmson@naver.com")).isEqualTo(10000000);
    }

    @Test
    public void deleteBuyerTest(){

        assertThat(buyerDAO.deleteBuyer("mjkim@naver.com")).isEqualTo(1);
    }

}
