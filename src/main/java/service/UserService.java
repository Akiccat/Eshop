package service;

import dao.DBUtil;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserService {
    public static User getUserByUserId(int userId) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Connection con = null;

        try {
            con = DBUtil.getCon();

            String sql = "select * from t_user where userid=?";

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, String.valueOf(userId));
            rs = pstmt.executeQuery();
            rs.next();
            User user = new User();
            user.setUserName(rs.getString("user_name"));
            user.setUserId(rs.getInt("user_id"));
            user.setUserAge(rs.getInt("user_age"));
            user.setUserSex(rs.getInt("user_sex"));
            user.setUserEmail(rs.getString("user_email"));
            return user;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            DBUtil.close(rs, pstmt, con);
        }
    }

    public static int UpdateUserInfo(User newu) {
        PreparedStatement pstmt = null;
        Connection con = null;

        try {
            con = DBUtil.getCon();

            String sql = "update t_user set user_name = ?,user_age = ?,user_sex=?,user_email=? where user_id = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newu.getUserName());
            pstmt.setInt(2, newu.getUserAge());
            pstmt.setInt(3, newu.getUserSex());
            pstmt.setString(4, newu.getUserEmail());
            pstmt.setInt(5, newu.getUserId());
            int i = pstmt.executeUpdate();
            return i;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            DBUtil.close(null, pstmt, con);
        }
    }

    public static boolean UpdateUserPass(String userName, String newUserPass) {
        PreparedStatement pstmt = null;
        Connection con = null;

        try {
            con = DBUtil.getCon();

            String sql = "update t_user set user_pass = ? where user_name = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newUserPass);
            pstmt.setString(2, userName);
            int i = pstmt.executeUpdate();
            if(i>0){
                return true;
            }
            else
                return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(null, pstmt, con);
        }
    }

    public static boolean CheckUserPass(String userName, String userPass) {
        User user = new User();
        user = HomeService.getCheckUser(userName, userPass);
        return user != null;
    }
}
