package model.member;

import java.security.SecureRandom;

public class Salt {
	
	public String newSalt(String email) {
		SecureRandom sr = new SecureRandom();
		byte[] temp = new byte[32];
		sr.nextBytes(temp);
		
		StringBuilder sb = new StringBuilder();
		for(byte b : temp) {
			sb.append(String.format("%02x", b));
		}
		return sb.toString();
	}

}
