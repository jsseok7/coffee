package model.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class HashPw {

	public String hashPw(String password, String salt){
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            Random random = new Random();
            
            int hashTry = random.nextInt(500, 1000);
            
            for (int i = 0; i < hashTry; i++) {
                String temp = password + salt;
                md.update(temp.getBytes());
            }
            byte[] hashed = md.digest();

            StringBuilder hexString = new StringBuilder();
            for(byte b : hashed){
                String hex = Integer.toHexString(b & 0xff);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        }
        catch (NoSuchAlgorithmException e){
            throw new RuntimeException("Hashing Error", e);
        }
    }
}
