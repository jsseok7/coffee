package model.member;

import model.member.SellerDAO;
import model.member.SellerDO;
import org.junit.Test;

import static org.assertj.core.api.Assertions.*;

public class SellerDAOTest {

    SellerDAO sellerDAO = new SellerDAO();



    @Test
    public void insertSellerTest() throws Exception {

        SellerDO sellerDO = new SellerDO();

        sellerDO.setSellerEmail("qqqqqq@daum.net");
        sellerDO.setBusinessName("상호명q");
        sellerDO.setBusinessNum("1234555");
        sellerDO.setNickname("qqqqqq");
        sellerDO.setPasswd("1234qwer");
        sellerDO.setTel("12333");
        sellerDO.setAddress("부산시 사상구");

        assertThat(sellerDAO.insertSeller(sellerDO)).isEqualTo(1);
    }

    @Test
    public void updateSellerTest(){

        SellerDO sellerDO = new SellerDO();

        sellerDO.setNickname("류현진");
        sellerDO.setTel("1111");
        sellerDO.setAddress("부산시 북구");
        sellerDO.setSellerImg("img-url");
        sellerDO.setSellerEmail("hjryu@daum.net");

        assertThat(sellerDAO.updateSeller(sellerDO)).isEqualTo(1);
    }


    @Test
    public void getSellerTest(){

        SellerDO seller = sellerDAO.getSeller("hskim@daum.net");

        assertThat(seller.getBusinessName()).isEqualTo("김하성가게");
        assertThat(seller.getBusinessNum()).isEqualTo("1234567");
        assertThat(seller.getNickname()).isEqualTo("김하성");
        assertThat(seller.getPasswd()).isEqualTo("1234qwer");
        assertThat(seller.getPoint()).isEqualTo(0);
        assertThat(seller.getTel()).isEqualTo("12345");
//        assertThat(seller.getSellerImg()).isEqualTo("img-url");
        assertThat(seller.getAddress()).isEqualTo("서울");
//        assertThat(seller.getRegdate()).isEqualTo(1111);

    }

    @Test
    public void checkSellerIdTest(){

        //중복된 아이디
        assertThat(sellerDAO.checkSellerId("longlee@daum.net")).isEqualTo(false);

        //새로운 아이디
        assertThat(sellerDAO.checkSellerId("jhj@naver.com")).isEqualTo(true);
    }

    @Test
    public void checkSellerPasswdTest(){

        //passwd 일치
        assertThat(sellerDAO.checkSellerPasswd("longlee@daum.net","1234qwer")).isEqualTo(true);

        //passwd 불일치
        assertThat(sellerDAO.checkSellerPasswd("longlee@daum.net","12341234")).isEqualTo(false);

    }

    @Test
    public void checkSellerPointTest(){
        assertThat(sellerDAO.checkSellerPoint("hskim@daum.net")).isEqualTo(0);
    }

    @Test
    public void sellerPointUpdateTest(){
        assertThat(sellerDAO.sellerPointUpdate("longlee@daum.net", 10)).isEqualTo(1);
    }
    @Test
    public void deleteSellerTest(){

        assertThat(sellerDAO.deleteSeller("jspark@daum.net")).isEqualTo(1);
    }
}