package model.product;

import model.cart.CartDO;

public class CartBeans {
    private CartDO cartDO;
    private BeansDO beansDO;

    public CartDO getCartDO() {
        return cartDO;
    }

    public void setCartDO(CartDO cartDO) {
        this.cartDO = cartDO;
    }

    public BeansDO getBeansDO() {
        return beansDO;
    }

    public void setBeansDO(BeansDO beansDO) {
        this.beansDO = beansDO;
    }
}
