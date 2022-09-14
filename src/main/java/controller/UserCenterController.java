package controller;

import model.Partner;
import model.User;
import service.PartnerService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserCenterController", value = {"/usercenter/index.action", "/usercenter/getPersonalInfo.action", "/usercenter/updatePersonalInfo.action", "/usercenter/getPersonalPassword.action", "/usercenter/updatePersonalPassword.action"})
public class UserCenterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getServletPath();
        request.setCharacterEncoding("utf-8");
        User logu = (User) request.getSession().getAttribute("_LOGIN_USER_");
        /*System.out.println(logu);*/
        List<Partner> partners = PartnerService.getPartnerService();
        request.setAttribute("partners",partners);
        if (url.equals("/usercenter/index.action")) {
            request.getRequestDispatcher("/usercenter/index.jsp").forward(request, response);
        } else if (url.equals("/usercenter/getPersonalInfo.action")) {
            User u = UserService.getUserByUserId(logu.getUserId());
            request.setAttribute("user", u);
            request.getRequestDispatcher("/usercenter/updatePersonalInfo.jsp").forward(request, response);
        } else if (url.equals("/usercenter/updatePersonalInfo.action")) {
            String uid = request.getParameter("userId");
            String usex = request.getParameter("userSex");
            String uage = request.getParameter("userAge");
            String uemail = request.getParameter("userEmail");
            String username = request.getParameter("userName");
            if(username == null){
                username = logu.getUserName();
            }
            User newu = new User();
            newu.setUserName(username);
            newu.setUserId(Integer.parseInt(uid));
            newu.setUserSex((usex == null) ? 0 : Integer.parseInt(usex));
            newu.setUserEmail(uemail);
            newu.setUserAge(Integer.parseInt(uage));
            int i = UserService.UpdateUserInfo(newu);
            request.setAttribute("msg", "个人信息修改成功,重新登陆以应用修改");
            request.getRequestDispatcher("/usercenter/index.jsp").forward(request, response);
        } else if (url.equals("/usercenter/getPersonalPassword.action")) {
            request.getRequestDispatcher("/usercenter/updatePersonalPassword.jsp").forward(request, response);
        } else if (url.equals("/usercenter/updatePersonalPassword.action")) {
            String newUserPass = request.getParameter("newUserPass");
            String userPass = request.getParameter("userPass");
            String userName = logu.getUserName() + "";
            boolean result = UserService.CheckUserPass(userName, userPass);
            if (result) {
                result = UserService.UpdateUserPass(userName, newUserPass);
                if (result) {
                    request.setAttribute("msg", "密码修改成功");
                } else {
                    request.setAttribute("msg", "密码修改失败");
                }
            } else {
                request.setAttribute("msg", "原密码错误，密码修改失败");
            }
            request.getRequestDispatcher("/usercenter/index.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
