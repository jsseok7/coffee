package model.cart;

public class CartDTO {

	private int beansNum;
	private int qty;

	public CartDTO(){

	}

	public CartDTO(int beansNum, int qty) {
		this.beansNum = beansNum;
		this.qty = qty;
	}
		
	 public int getBeansNum() {
		return beansNum;
	}

	public void setBeansNum(int beansNum) {
		this.beansNum = beansNum;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}


	@Override
	    public String toString() {
	        return "CartDTO{" +
	                "beansNum='" + beansNum + '\'' +
	                ", qty='" + qty + '\'' +
	                '}';
	 }
}
