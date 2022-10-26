package kr.co.pap.controller;

import java.io.File;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.pap.adminpage.UserboardManageService;
import kr.co.pap.services.ChartService;

@Controller
public class AdminController {
	
	@Autowired
	ChartService service;
	@Autowired
	UserboardManageService uservice;
	
	
	@RequestMapping(value="admin")
	public String adminindex(Model model) throws Exception {
		int reportcnt = uservice.reportcnt()+uservice.reportreplycnt();
		int gradeupcnt = uservice.gradeupcnt();
		model.addAttribute("reportcnt", reportcnt);
		model.addAttribute("gradeupcnt", gradeupcnt);
		return "admin/adminindex";
	}

	
	@ResponseBody
	@PostMapping(value="admin/joinday")
	public ArrayList<Integer> joinday(Date date) throws Exception {
		
		ArrayList<Integer> joinday = new ArrayList<Integer>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		DateFormat df = new SimpleDateFormat("yyyy-MM");
		//  System.out.println("current: " + df.format(cal.getTime()));
       // cal.add(Calendar.MONTH, 2);
       // cal.add(Calendar.DATE, -3);
		
		for(int i = 1;i<=31;i++) {
			int a = 0;
			if(i<10) {
			 a = service.joinstatday(df.format(cal.getTime())+"-0"+i);
			 System.out.println(df.format(cal.getTime())+"-0"+i);
			}else {
			 a = service.joinstatday(df.format(cal.getTime())+"-"+i);
			}
			joinday.add(a);
		}
		System.out.println(joinday.toString());
		return joinday;
	}
	@ResponseBody
	@PostMapping(value="admin/joinmonth")
	public ArrayList<Integer> joinmonth(String date) throws Exception{
		ArrayList<Integer> joinmonth = new ArrayList<Integer>();
		
		System.out.println(date);
		for(int i =1;i<10;i++) {
			int a = service.joinstatmonth(date+"-0"+i);
			joinmonth.add(a);
		}
		for(int i = 10; i<13;i++) {
			int a = service.joinstatmonth(date+"-"+i);
			joinmonth.add(a);
		}
		return joinmonth;
	}
	@ResponseBody
	@PostMapping(value="admin/joinyear")
	public ArrayList<Integer> joinyear(Date date)throws Exception{
		ArrayList<Integer> joinyear = new ArrayList<Integer>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		DateFormat df = new SimpleDateFormat("yyyy");
		for(int i = 1;i<11;i++) {
			int a = service.joinstatyear(df.format(cal.getTime()));
			joinyear.add(a);
			cal.add(Calendar.YEAR, -1);
		}
		
		return joinyear;
	}
	@ResponseBody
	@PostMapping(value="admin/loginyear")
	public ArrayList<Integer> loginyear(Date date)throws Exception{
		ArrayList<Integer> loginyear = new ArrayList<Integer>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		DateFormat df = new SimpleDateFormat("yyyy");
		for(int i = 1;i<11;i++) {
			int a = service.loginstatyear(df.format(cal.getTime()));
			loginyear.add(a);
			cal.add(Calendar.YEAR, -1);
		}
		
		return loginyear;
	}
	@ResponseBody
	@PostMapping(value="admin/loginmonth")
	public ArrayList<Integer> loginmonth(String date) throws Exception{
		ArrayList<Integer> loginmonth = new ArrayList<Integer>();
		
		System.out.println(date);
		for(int i =1;i<10;i++) {
			int a = service.loginstatmonth(date+"-0"+i);
			loginmonth.add(a);
		}
		for(int i = 10; i<13;i++) {
			int a = service.loginstatmonth(date+"-"+i);
			loginmonth.add(a);
		}
		return loginmonth;
	}
	@ResponseBody
	@PostMapping(value="admin/loginday")
	public ArrayList<Integer> loginday(Date date) throws Exception {
		
		ArrayList<Integer> loginday = new ArrayList<Integer>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		DateFormat df = new SimpleDateFormat("yyyy-MM");
		//  System.out.println("current: " + df.format(cal.getTime()));
       // cal.add(Calendar.MONTH, 2);
       // cal.add(Calendar.DATE, -3);
		
		for(int i = 1;i<=31;i++) {
			int a = 0;
			if(i<10) {
			 a = service.loginstatday(df.format(cal.getTime())+"-0"+i);
			 System.out.println(df.format(cal.getTime())+"-0"+i);
			}else {
			 a = service.loginstatday(df.format(cal.getTime())+"-"+i);
			}
			loginday.add(a);
		}
		System.out.println(loginday.toString());
		return loginday;
	}
	
}
