package sqlservertest;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String className = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;DatabaseName=testdb";
		String user="sa";
		String password="sa";
		try {
			Class.forName(className);
			Connection conn= DriverManager.getConnection(url,user,password);
			conn.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
