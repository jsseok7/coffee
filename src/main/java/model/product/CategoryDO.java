package model.product;

public class CategoryDO {

		private int categoryNum;
		private String categoryName;
		private String categoryImg;
	
		public String getCategoryImg() {
			return categoryImg;
		}

		public void setCategoryImg(String categoryImg) {
			this.categoryImg = categoryImg;
		}

		CategoryDO(){
			
		}

		public int getCategoryNum() {
			return categoryNum;
		}

		public void setCategoryNum(int categoryNum) {
			this.categoryNum = categoryNum;
		}

		public String getCategoryName() {
			return categoryName;
		}

		public void setCategoryName(String categoryName) {
			this.categoryName = categoryName;
		}
		
		
}
