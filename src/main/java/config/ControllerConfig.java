
package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import controller.MemberController;
import controller.ProductController;
import model.product.BeansDAO;



@Configuration
public class ControllerConfig {

	@Bean
	public MemberController memberController() {
		return new MemberController();
	}
	
	@Bean
	public ProductController productController() {
		return new ProductController();
	}
	
}
