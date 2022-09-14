package controller;

import model.*;
import service.HomeService;
import service.OrderService;
import service.PartnerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderController", value = {"/order/addOrder.action","/order/payOrders.action", "/order/handleOrderStatus.action", "/order/cancelOrder.action", "/order/payOrder.action", "/order/delOrder.action", "/order/getMyOrders.action", "/order/getOrderDetailById.action"})
public class OrderController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getServletPath();
        request.setCharacterEncoding("utf-8");
        List<Category> catelist = HomeService.getCateList();
        request.setAttribute("catelist", catelist);
        Object ob = request.getSession().getAttribute("goodslist");
        User logu = (User) request.getSession().getAttribute("_LOGIN_USER_");
        List<Partner> partners = PartnerService.getPartnerService();
        request.setAttribute("partners",partners);
        if (logu == null) {
            request.setAttribute("msg", "登录已过期，请重新登录！！");
            request.getRequestDispatcher("/usercenter/index.jsp").forward(request, response);
            // 生成订单
        } else if (url.equals("/order/addOrder.action")) {
            if (ob == null) {
                request.setAttribute("msg", "购物车为空，请先选购商品！！！");
                request.getRequestDispatcher("/usercenter/index.jsp").forward(request, response);
            } else {
                String address = request.getParameter("address");
                Order order = new Order();
                order.setUserId(logu.getUserId());
                order.setOrderAddress(address);
                List<Goods> goodslist = new ArrayList<Goods>();
                goodslist = (List<Goods>) ob;
                List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
                float postalfee = goodslist.get(0).getGoodsPostalfee();
                for (Goods g : goodslist) {
                    OrderDetail od = new OrderDetail();
                    od.setGoodsId(g.getGoodsId());
                    od.setOdetailName(g.getGoodsName());
                    od.setOdetailPrice(g.getGoodsPrice());
                    od.setOdetailNum(g.getGoodsSales());
                    od.setOdetailPic(g.getGoodsPic());
                    float temp = g.getGoodsPostalfee();
                    if (postalfee > temp)
                        postalfee = temp;
                    orderDetails.add(od);
                }
                order.setOrderPostalfee(postalfee);
                request.setAttribute("orderId", OrderService.addOrder(order, orderDetails));
                request.getSession().removeAttribute("goodslist");
                request.getRequestDispatcher("/order/payOrders.jsp").forward(request, response);
            }

            //
        } else if (url.equals("/order/handleOrderStatus.action")) {
            String status = request.getParameter("status");
            /*System.out.println("handleOrderStatus.action:status=" + status);*/
            String orderId = request.getParameter("orderId");
            OrderService.changeOrderStatus(orderId, status);
            request.getRequestDispatcher("/order/getMyOrders.action").forward(request, response);
            // 取消订单
        } else if (url.equals("/order/cancelOrder.action")) {
            String orderId = request.getParameter("orderId");
            int result = OrderService.changeOrderStatus(orderId, "3");
            PrintWriter out = response.getWriter();
            if (result > 0) {
                out.print("{\"success\":true}");
            } else {
                out.print("{\"success\":false}");
            }

            out.flush();
            // 支付订单
        } else if (url.equals("/order/payOrder.action")) {
            String orderId = request.getParameter("orderId");
            System.out.println("Orderid"+orderId);
            OrderService.payOrder(orderId);
            request.getRequestDispatcher("/order/getMyOrders.action").forward(request, response);
        }
        else if (url.equals("/order/payOrders.action")) {
        String orderId = request.getParameter("orderId");
        request.setAttribute("orderId",orderId);
        request.getRequestDispatcher("/order/payOrders.jsp").forward(request, response);
    }
        // 删除订单
        else if (url.equals("/order/delOrder.action")) {
            String orderId = request.getParameter("orderId");
            OrderService.delOrder(orderId);
            request.getRequestDispatcher("/order/getMyOrders.action").forward(request, response);
        }
        // 获取全部订单
        else if (url.equals("/order/getMyOrders.action")) {
            String status = request.getParameter("status");
            /*System.out.println("getMyOrders.action:status=" + status);*/
            List<Order> orderlist = OrderService.getAllOrders(logu.getUserId(), status);
            request.setAttribute("orders", orderlist);
            /*System.out.println("getMyOrders.action:orderlist=" + orderlist.size());*/
            request.getRequestDispatcher("/order/orderList.jsp").forward(request, response);
        }
        // 获取订单详情
        else if (url.equals("/order/getOrderDetailById.action")) {
            String orderId = request.getParameter("orderId");
            Order orderDetail = OrderService.getOrderDetailById(orderId);
            request.setAttribute("orderDetail", orderDetail);
            request.getRequestDispatcher("/order/orderDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
