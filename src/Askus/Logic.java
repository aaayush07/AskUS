package Askus;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Logic {
	public Connection getConnection()throws IllegalAccessException,
    ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AskUS","root","Aayush07@");
		return conn;
	}
	public int validateLogin(String email,String password) throws Exception {
		Connection con = getConnection();
		PreparedStatement ps=con.prepareStatement("select id from UserInfo where email = ? and password = ?");  
        ps.setString(1,email);  
		ps.setString(2,password);
		ResultSet rs=ps.executeQuery();
		int id = 0;
		while(rs.next()){
			id = rs.getInt(1);
		}
		rs.close();
		ps.close();
		con.close();
		return id;
	}
	public int newUser(String username, String password)throws Exception {
		  Connection con = getConnection();
		  PreparedStatement ps=con.prepareStatement("insert into UserInfo(email , password) values ( ? , ?)");
	      ps.setString(1,username);
	      ps.setString(2,password);
	      int x = ps.executeUpdate();
	      if(x > 0) {
				PreparedStatement ps1 = con.prepareStatement("Select * from UserInfo where email = ? and password = ? ");
				ps1.setString(1, username);
				ps1.setString(2, password);
				ResultSet rs1 = ps1.executeQuery();
				while(rs1.next()) {
					x = rs1.getInt(1);
				}
				rs1.close();
				ps1.close();
			}
	      ps.close();
	      con.close();
	      return x;
	}
	public int addQuestion(String question, int id) throws IllegalAccessException, ClassNotFoundException, SQLException {
		 Connection con = getConnection();
		  PreparedStatement ps=con.prepareStatement("insert into Question(question , id , date) values ( ? , ? , ? )");
	      ps.setString(1,question);
	      ps.setInt(2, id);
	      ps.setString(3, getCurrentTime());
	      int x = ps.executeUpdate();
	      ps.close();
	      con.close();
	      if(x > 0) {
	    	  return x;
	      }
	      else return -1;
	}
	public int addAnswer(String answer,int id , int qid) throws IllegalAccessException, ClassNotFoundException, SQLException {
		 Connection con = getConnection();
		  PreparedStatement ps=con.prepareStatement("insert into Answer(answer , id , qid , likes , date) values ( ? , ? , ? , ? , ?)");
	      ps.setString(1,answer);
	      ps.setInt(2, id);
	      ps.setInt(3, qid);
	      ps.setInt(4, 0);
	      ps.setString(5, getCurrentTime());
	      int x = ps.executeUpdate();
	      ps.close();
	      con.close();
	      if(x > 0) {
	    	  return x;
	      }
	      else return -1;
	}
	public String getCurrentTime() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    Date date = new Date();  
	    String date2 = formatter.format(date);
	    return date2;
	}
	public String getAnswerWriterName(int id) throws IllegalAccessException, ClassNotFoundException, SQLException {
		Connection con = getConnection();
		PreparedStatement ps = con.prepareStatement("Select email from userinfo where id = ? ");
		ps.setInt(1, id);
		ResultSet rs = ps.executeQuery();
		String username = new String("");
		while(rs.next()) {
			username = rs.getString(1);
		}
		rs.close();
		ps.close();
		con.close();
		return username;
	}
}
