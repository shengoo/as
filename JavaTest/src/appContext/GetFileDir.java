package appContext;

public class GetFileDir {

	
	public GetFileDir(){
		//��ȡ��ǰ���ļ����ڰ��ĸ�Ŀ¼  
		System.out.println(System.getProperty("user.dir").replace("\\", "/"));  
		//��ȡ��ǰ���ļ����ڵ�Ŀ¼  
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
