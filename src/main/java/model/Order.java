package model;

import java.util.Date;
import java.util.List;

public class Order {
    private int orderId;
    private String orderCode;
    private float orderPostalfee;
    private int orderStatus;
    private String orderAddress;
    private Date orderDate;
    private String orderPostcode;
    private String orderPostname;
    private List<OrderDetail> odetails;
    private int userId;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public float getOrderPostalfee() {
        return orderPostalfee;
    }

    public void setOrderPostalfee(float orderPostalfee) {
        this.orderPostalfee = orderPostalfee;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderAddress() {
        return orderAddress;
    }

    public void setOrderAddress(String orderAddress) {
        this.orderAddress = orderAddress;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderPostcode() {
        return orderPostcode;
    }

    public void setOrderPostcode(String orderPostcode) {
        this.orderPostcode = orderPostcode;
    }

    public String getOrderPostname() {
        return orderPostname;
    }

    public void setOrderPostname(String orderPostname) {
        this.orderPostname = orderPostname;
    }

    public List<OrderDetail> getOdetails() {
        return odetails;
    }

    public void setOdetails(List<OrderDetail> odetails) {
        this.odetails = odetails;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
