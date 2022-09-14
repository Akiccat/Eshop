package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import model.*;
import service.AddressService;
import service.GoodService;
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
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

@WebServlet(name = "GoodsController", value = "*.action")
public class GoodsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getServletPath();
        request.setCharacterEncoding("utf-8");
        List<Partner> partners = PartnerService.getPartnerService();
        request.setAttribute("partners",partners);
        //导航菜单商品分类下拉列表
        List<Category> catelist = HomeService.getCateList();
        request.setAttribute("catelist", catelist);

        if (url.equals("/goods/goodsDetail.action")) {//商品详情页面
            Goods goodsDetail = new Goods();
            int goods_id = Integer.parseInt(request.getParameter("goods_id"));
            goodsDetail = GoodService.getGoodsDetail(goods_id);
            request.setAttribute("goodsDetail", goodsDetail);
            /*System.out.println(goodsDetail);*/
            Category cate = new Category();
            cate = GoodService.getCateName(goods_id);
            request.setAttribute("cate", cate);
            request.getRequestDispatcher("/goods/goods_detail.jsp").forward(request, response);
            //新到商品
        } else if (url.equals("/goods/newGoods.action")) {//新到商品页面数据
            List<Map<String, String>> newGoods = HomeService.getNewGoodList();
            request.setAttribute("newgoodslist", newGoods);
            /*System.out.println(newGoods);*/
            request.getRequestDispatcher("/goods/new_goods.jsp").forward(request, response);
        } else if (url.equals("/goods/saleGoods.action")) {//热销商品页面

            List<Goods> hotgoodslist = HomeService.getHotGoodsList();
            request.setAttribute("hotgoodslist", hotgoodslist);
            /*System.out.println(hotgoodslist);*/
            request.getRequestDispatcher("/goods/sale_goods.jsp").forward(request, response);
        } else if (url.equals("/goods/goodsCate.action")) {//物品排序
            List<Goods> goodslist = new ArrayList<Goods>();
            int childid = Integer.parseInt(request.getParameter("childid"));
            int sort = Integer.parseInt(request.getParameter("sort"));
            /*System.out.println(sort);*/
            goodslist = GoodService.getCategoods(childid, sort);
            request.setAttribute("catelist", catelist);//导航菜单商品分类下拉列表
            request.setAttribute("childid", childid);
            request.setAttribute("goods", goodslist);
            /*System.out.println(goodslist);
            System.out.println(catelist);*/
            request.getRequestDispatcher("/goods/goods_list.jsp").forward(request, response);
        } else if (url.equals("/goods/searchGoods.action")) {//搜索数据返回
            String searchText = request.getParameter("SearchText");
            /*System.out.println(searchText);*/
            List<Map<String, String>> SearchList = HomeService.getSearchGoodList(searchText);
            request.setAttribute("searchlist", SearchList);
            request.getRequestDispatcher("/goods/searchGoods.jsp").forward(request, response);
        } else if (url.equals("/goods/addCart.action")) {
            List<Goods> goodslist = new ArrayList<Goods>();
            Object ob = request.getSession().getAttribute("goodslist");
            /*System.out.println(goodslist);*/
            if (ob != null) {
                goodslist = (List<Goods>) ob;
            }
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            try {
                int goodsId = Integer.parseInt(request.getParameter("goodsId"));
                /*System.out.println(goodsId);*/
                String goodsName = request.getParameter("goodsName");
                String goodsPic = request.getParameter("goodsPic");
                Float goodsPrice = Float.parseFloat(request.getParameter("goodsPrice"));
                Float goodsDiscount = Float.parseFloat(request.getParameter("goodsDiscount"));
                int goodsPostalfee = Integer.parseInt(request.getParameter("goodsPostalfee"));
                int goodsSales = Integer.parseInt(request.getParameter("goodsSales"));

                Goods good = new Goods();
                good.setGoodsId(goodsId);
                good.setGoodsName(goodsName);
                good.setGoodsPrice(goodsPrice);
                good.setGoodsDiscount(goodsDiscount);
                good.setGoodsPostalfee(goodsPostalfee);
                good.setGoodsPic(goodsPic);

                if (ob != null) {
                    for (int i = 0; i < goodslist.size(); i++) {
                        int goods_id = goodslist.get(i).getGoodsId();
                        if (goods_id == goodsId) {
//                    		System.out.println("--相等---"+i);
                            good.setGoodsSales(goodslist.get(i).getGoodsSales() + goodsSales);
                            goodslist.remove(i);
                        } else {
                            good.setGoodsSales(goodsSales);
                        }
                    }
                } else {
                    good.setGoodsSales(goodsSales);
                }
                goodslist.add(good);

                request.getSession().setAttribute("goodslist", goodslist);

                out.print("{\"success\":true,\"cartnum\":" + goodslist.size() + "}");

            } catch (Exception e) {
                e.printStackTrace();
                out.print("{\"success\":false}");
            }
            out.flush();
        } else if (url.equals("/goods/deleteCart.action")) {
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            String index = request.getParameter("index");
            List<Goods> goodslist = new ArrayList<Goods>();
            Object ob = request.getSession().getAttribute("goodslist");
            if (ob != null && index != null) {
                goodslist = (List<Goods>) ob;
                goodslist.remove(Integer.parseInt(index));
            }
            request.getSession().setAttribute("goodslist", goodslist);
            out.print("{\"success\":true,\"cartnum\":" + goodslist.size() + "}");

            // 清空购物车
        } else if (url.equals("/goods/clearCart.action")) {
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            request.getSession().removeAttribute("goodslist");
            out.print("{\"success\":true}");

            // 修改购物车中商品数量
        } else if (url.equals("/goods/changeCart.action")) {
            List<Goods> goodslist = new ArrayList<Goods>();
            Object ob = request.getSession().getAttribute("goodslist");
            if (ob != null) {
                goodslist = (List<Goods>) ob;
            }
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            String index = request.getParameter("index");
            String goodsSales = request.getParameter("goodsSales");
            float totalAmount = 0;
            float totalPrice = 0;
            if (ob != null) {
                for (int i = 0; i < goodslist.size(); i++) {
                    if (i == Integer.parseInt(index)) {
                        goodslist.get(i).setGoodsSales(Integer.parseInt(goodsSales));
                        totalPrice = goodslist.get(i).getGoodsSales() * goodslist.get(i).getGoodsDiscount();
                    }
                    totalAmount = totalAmount + goodslist.get(i).getGoodsSales() * goodslist.get(i).getGoodsDiscount();
                }
            }

            out.print("{\"success\":true,\"totalAmount\":" + totalAmount + ",\"totalPrice\":" + totalPrice + "}");
        }else if(url.equals("/goods/buyGoods.action")){
            request.setAttribute("catelist", catelist);
            User logu=(User)request.getSession().getAttribute("_LOGIN_USER_");
            if(logu!=null){
                List<Address> addresses= AddressService.getAllAddress(logu.getUserId());
                request.setAttribute("addrs",addresses);
            }
            request.getRequestDispatcher("/order/buyGoods.jsp").forward(request, response);
        }//新到商品移动端接口json
         else if(url.equals("/goods/newGoodsForMobile.action")){
            response.setContentType("text/json; charset=utf-8");
            PrintWriter out = response.getWriter();

            List<Goods> goodslist=new ArrayList<Goods>();
            goodslist=HomeService.getNewGoodList();

            ObjectMapper mapper = new ObjectMapper();
            String jsonlist = mapper.writeValueAsString(goodslist);
            System.out.println(jsonlist);
            out.print(jsonlist);
            out.flush();
        }



}

        @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
