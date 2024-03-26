package model.service;

import com.oreilly.servlet.MultipartRequest;
import model.member.BuyerDAO;
import model.member.SellerDAO;
import model.product.BeansDAO;

import java.io.File;
import java.util.Enumeration;

public class ImgUpload {

    BuyerDAO buyerDAO = new BuyerDAO();
    SellerDAO sellerDAO = new SellerDAO();
    BeansDAO beansDAO = new BeansDAO();

    //이미지 저장
    public String[] saveImg(MultipartRequest multi, String directory){

        String[] name = {"", ""};

        System.out.println(directory);
        // 파일 업로드 액션
        
        File uploadDir = new File(directory);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();// 디렉토리 생성
        }
        String savedName = "";
        String savedName1 = "";
        @SuppressWarnings("unchecked")
        Enumeration<String> fileNames = multi.getFileNames();
        if (fileNames.hasMoreElements()) {
            String paramName = fileNames.nextElement();
            savedName = multi.getFilesystemName(paramName);
        }
        if (fileNames.hasMoreElements()) {
            String paramName = fileNames.nextElement();
            savedName1 = multi.getFilesystemName(paramName);
        }

        name[0] = savedName;
        name[1] = savedName1;

        return name;
    }
}
