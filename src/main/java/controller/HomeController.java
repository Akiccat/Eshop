package controller;

import model.Category;
import model.Goods;
import model.Partner;
import model.User;
import service.HomeService;
import service.PartnerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeController", value = {"/index.action", "/login.action", "/logout.action", "/reg.action"})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       /* HttpSession session = request.getSession();
        // 获取session中所有的键值
        Enumeration<String> attrs = session.getAttributeNames();
        // 遍历attrs中的
        while (attrs.hasMoreElements()) {
        // 获取session键值
            String name = attrs.nextElement().toString();
            // 根据键值取session中的值
            Object vakue = session.getAttribute(name);
            // 打印结果
            System.out.println("------" + name + ":" + vakue + "--------\n");
        }*/
        List<Partner> partners = PartnerService.getPartnerService();
        request.setAttribute("partners",partners);

        List<Map<String, String>> list = HomeService.getTodayGoodsList();
        List<Category> catelist = HomeService.getCateList();
        List<Goods> hotgoodslist = HomeService.getHotGoodsList();
        request.setAttribute("hotgoodslist", hotgoodslist);
        request.setAttribute("catelist", catelist);
        request.setAttribute("todaylist", list);
        String url = request.getServletPath();
        if (url.equals("/index.action")) {
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } else if (url.equals("/login.action")) {
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            String username = request.getParameter("userName");
            String password = request.getParameter("userPass");
//			int num=HomeService.getCheckUser(username,password);
            User loginuser = new User();
            loginuser = HomeService.getCheckUser(username, password);

            if (loginuser != null) {
                request.getSession().setAttribute("_LOGIN_USER_", loginuser);
                out.print("{\"login\":true,\"username\":\"" + username + "\"}");
            } else {
                out.print("{\"login\":false,\"msg\":\"用户名或密码错误\"}");
            }
            out.flush();
        } else if (url.equals("/logout.action")) {
            request.getSession().removeAttribute("_LOGIN_USER_");

        } else if (url.equals("/reg.action")) {
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            String username = request.getParameter("userName");
            String password = request.getParameter("userPass");

            int i = HomeService.regUser(request.getParameterMap());

            if (i >= 1) {
                User loginuser = new User();
                loginuser.setUserName(username);
                boolean register = true;
                request.getSession().setAttribute("_REGISTER_SUCCESS_", register);
                request.getSession().setAttribute("_LOGIN_USER_", loginuser);
                out.print("{\"reg\":true,\"username\":\"" + username + "\"}");
            } else {
                out.print("{\"reg\":false}");
            }

            out.flush();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
