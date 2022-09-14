package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import model.Address;
import model.Partner;
import model.User;
import service.AddressService;
import service.PartnerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "AddressController", value = {"/address/getMyAddress.action", "/address/delAddress.action", "/address/getAddressById.action", "/address/handleAddress.action", "/address/setDefaultAddress.action"})
public class AddressController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getServletPath();
        request.setCharacterEncoding("utf-8");
        List<Partner> partners = PartnerService.getPartnerService();
        request.setAttribute("partners",partners);
        User logu = (User) request.getSession().getAttribute("_LOGIN_USER_");
        if (url.equals("/address/getMyAddress.action")) {
            List<Address> addresses = AddressService.getAllAddress(logu.getUserId());
            request.setAttribute("addrs", addresses);
            request.getRequestDispatcher("/address/addressList.jsp").forward(request, response);
        } else if (url.equals("/address/delAddress.action")) {
            String addrId = request.getParameter("addrId");
            AddressService.delAddressById(addrId);
            request.getRequestDispatcher("/address/getMyAddress.action").forward(request, response);
        } else if (url.equals("/address/getAddressById.action")) {
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            String addrId = request.getParameter("addrId");
            Address addr = AddressService.getAddressById(addrId);
            if (addr != null) {
                ObjectMapper mapper = new ObjectMapper();
                String jsonlist = mapper.writeValueAsString(addr);
                out.print(jsonlist);
            }
        } else if (url.equals("/address/handleAddress.action")) {
            String addrId = request.getParameter("addrId");
            String index = request.getParameter("index");
            Address addr = new Address();
            addr.setAddrArea(request.getParameter("addrArea"));
            addr.setAddrCity(request.getParameter("addrCity"));
            addr.setAddrContent(request.getParameter("addrContent"));
            addr.setAddrProvince(request.getParameter("addrProvince"));
            addr.setAddrReceiver(request.getParameter("addrReceiver"));
            addr.setAddrTel(request.getParameter("addrTel"));
            if (addrId.equals("0")) {
                addr.setUserId(logu.getUserId());
                int newaddrId = AddressService.addAddress(addr);
                PrintWriter out = response.getWriter();
                out.print("{\"index\":false,\"addrId\":" + newaddrId + "}");
            } else {
                addr.setAddrId(Integer.parseInt(addrId));
                AddressService.updateAddress(addr);
                PrintWriter out = response.getWriter();
                out.print("{\"index\":" + index + "}");

            }
        } else if (url.equals("/address/setDefaultAddress.action")) {
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            System.out.println("setDefaultAddress.action");
            String addrId = request.getParameter("addrId");
            if (AddressService.setDefaultAddress(addrId, logu.getUserId()))
                out.print("{\"setDefault\":\"success\"}");
            else
                out.print("{\"setDefault\":\"failure\"}");
            //req.getRequestDispatcher("/address/getMyAddress.action").forward(req, resp);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
