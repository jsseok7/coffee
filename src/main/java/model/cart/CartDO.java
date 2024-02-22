package model.cart;

import model.member.BuyerDO;
import model.product.BeansDO;

public class CartDO {

	private BuyerDO buyerDO;
	private BeansDO beansDO;
	private int qty;
	
	public BuyerDO getBuyerDO() {
		return buyerDO;
	}
	public void setBuyerDO(BuyerDO buyerDO) {
		this.buyerDO = buyerDO;
	}
	public BeansDO getBeansDO() {
		return beansDO;
	}
	public void setBeansDO(BeansDO beansDO) {
		this.beansDO = beansDO;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}	
}
