package model.service;

import model.like.LikeDAO;
import model.product.*;

import javax.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;

public class LikeService {

    LikeDAO likeDAO = new LikeDAO();
    BeansDAO beansDAO = new BeansDAO();

    public void clickLike(String email, int beanNum) throws SQLException {
        if(!checkLike(email,beanNum)){
            likeDAO.insertLike(email,beanNum);
            beansDAO.beansLikeCountUpdate(beanNum, true);

        }
        else {
            likeDAO.deleteLike(email, beanNum);
            beansDAO.beansLikeCountUpdate(beanNum, false);
        }

    }

    //이미 좋아요 -> false , 좋아요X -> TRUE
    public boolean checkLike(String email, int beanNum) throws SQLException {
        return likeDAO.checkLike(email, beanNum);
    }

    //내가 찜한 목록 불러오기
    public ArrayList<LikeBeans> getLikeList(String email){
        return likeDAO.getLikeList(email);
    }

    //찜한 상품은 true로 바꾸기
    public ArrayList<LikeBeans> likeBeans(String buyerEmail, ArrayList<BeansDO> beansDO) throws SQLException {

        ArrayList<LikeBeans> likeBeansList = new ArrayList<>();

        if(buyerEmail.isEmpty()){
            for (BeansDO b : beansDO) {
                LikeBeans likeBeans = new LikeBeans();
                likeBeans.setBeansDO(b);
                likeBeans.setaBoolean(false);

                likeBeans.setCategoryName(beansDAO.getCategoryName(b.getCategoryNum()));

                System.out.println(likeBeans.getCategoryName());

                likeBeansList.add(likeBeans);
            }
        }
        else {
            for (BeansDO b : beansDO) {
                LikeBeans likeBeans = new LikeBeans();
                likeBeans.setBeansDO(b);
                likeBeans.setaBoolean(likeDAO.checkLike(buyerEmail, b.getBeansNum()));

                likeBeans.setCategoryName(beansDAO.getCategoryName(b.getCategoryNum()));

                System.out.println(likeBeans.getCategoryName());

                likeBeansList.add(likeBeans);
            }
        }

        return likeBeansList;
    }




}
