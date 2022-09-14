package model;

public class OrderDetail {
    private int goodsId;
    private String odetailName;
    private float odetailPrice;
    private int odetailNum;
    private String odetailPic;

    public int getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(int goodsId) {
        this.goodsId = goodsId;
    }

    public String getOdetailName() {
        return odetailName;
    }

    public void setOdetailName(String odetailName) {
        this.odetailName = odetailName;
    }

    public float getOdetailPrice() {
        return odetailPrice;
    }

    public void setOdetailPrice(float odetailPrice) {
        this.odetailPrice = odetailPrice;
    }

    public int getOdetailNum() {
        return odetailNum;
    }

    public void setOdetailNum(int odetailNum) {
        this.odetailNum = odetailNum;
    }

    public String getOdetailPic() {
        return odetailPic;
    }

    public void setOdetailPic(String odetailPic) {
        this.odetailPic = odetailPic;
    }
}
