package appContext;

public class GetFileDir {

	
	public GetFileDir(){
		//获取当前类文件所在包的根目录  
		System.out.println(System.getProperty("user.dir").replace("\\", "/"));  
		//获取当前类文件所在的目录  
		System.out.println(this.getClass().getResource("").getPath().replaceAll("%20", " "));  
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		new GetFileDir();
	}

}
