package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.fasterxml.jackson.databind.util.JSONPObject;
import dao.DBUtil;
import model.Partner;
import redis.clients.jedis.Jedis;
import com.alibaba.fastjson.*;
import javax.json.JsonObject;

public class PartnerService {
	public static List<Partner> getPartnerService() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Connection con = null;
		List<Partner> list = null;
		// 1.1获取redis客户端
		Jedis jedis = new Jedis();
		// jedis.del("partners");
		boolean exist = false;
		boolean jedisErr = false;
		try {
			exist = jedis.exists("partners");
		} catch (Exception e) {
			e.printStackTrace();
			jedisErr = true;
		}

		if (!exist) {
			// 2.1如果为空需要从数据库中查，并存入redis
			System.out.println("从数据库中查询。。。。。");
			try {
				con = DBUtil.getCon();
				String sql = "SELECT * FROM t_partners";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				Map<String, String> map = new HashMap<>();
				list = new ArrayList<Partner>();
				while (rs.next()) {
					Partner partner = new Partner();
					partner.setPartnerName(rs.getString("partner_name"));
					String s;
					if(rs.getString("partner_link") == null){
						s = "";
					}
					else
						s = rs.getString("partner_link");
					partner.setPartnerLink(s);
					list.add(partner);
					map.put(rs.getString("partner_name"), s);
				}
				if (!jedisErr) {
					jedis.hmset("partners", map);
				}
			} catch (Exception throwables) {
				throwables.printStackTrace();
			} finally {
				if (!jedisErr) {
					jedis.close();
				}
				DBUtil.close(rs, pstmt, con);
			}
		} else {
			System.out.println("从redis中查询。。。。。");
			Map<String, String> retN = jedis.hgetAll("partners");
			list = new ArrayList<Partner>();
			for (Map.Entry<String, String> entry : retN.entrySet()) {
				Partner partner = new Partner();
				partner.setPartnerName(entry.getKey());
				partner.setPartnerLink(entry.getValue());
				list.add(partner);
			}
		}
		return list;
	}
}
