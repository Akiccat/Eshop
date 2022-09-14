package model;

public class Address {
    private int addrId;
    private int userId;
    private String addrProvince;
    private String addrCity;
    private String addrArea;
    private String addrContent;
    private String addrReceiver;
    private String addrTel;
    private int addrIsdefault;

    public int getAddrId() {
        return addrId;
    }

    public void setAddrId(int addrId) {
        this.addrId = addrId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAddrProvince() {
        return addrProvince;
    }

    public void setAddrProvince(String addrProvince) {
        this.addrProvince = addrProvince;
    }

    public String getAddrCity() {
        return addrCity;
    }

    public void setAddrCity(String addrCity) {
        this.addrCity = addrCity;
    }

    public String getAddrArea() {
        return addrArea;
    }

    public void setAddrArea(String addrArea) {
        this.addrArea = addrArea;
    }

    public String getAddrContent() {
        return addrContent;
    }

    public void setAddrContent(String addrContent) {
        this.addrContent = addrContent;
    }

    public String getAddrReceiver() {
        return addrReceiver;
    }

    public void setAddrReceiver(String addrReceiver) {
        this.addrReceiver = addrReceiver;
    }

    public String getAddrTel() {
        return addrTel;
    }

    public void setAddrTel(String addrTel) {
        this.addrTel = addrTel;
    }

    public int getAddrIsdefault() {
        return addrIsdefault;
    }

    public void setAddrIsdefault(int addrIsdefault) {
        this.addrIsdefault = addrIsdefault;
    }
}
