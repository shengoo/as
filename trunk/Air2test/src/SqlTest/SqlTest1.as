package SqlTest
{
	
	import flash.data.*;
	import flash.filesystem.File;
	
	
	public class SqlTest1
	{
		public function SqlTest1()
		{
			var dbFile:File = File.applicationDirectory.resolvePath("db.db");
			var sqlConn:SQLConnection = new SQLConnection();
			var sqlStatement:SQLStatement = new SQLStatement();
			
			sqlConn.open(dbFile);
			
			sqlStatement.sqlConnection = sqlConn;
			sqlStatement.text = "";
			sqlStatement.executing();
			
			var result:Array = sqlStatement.getResult().data;
		}
	}
}