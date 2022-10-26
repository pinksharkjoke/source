package kr.co.pap.adminpage;

import java.io.PrintWriter;
import java.net.http.HttpResponse;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.pap.account.LoginVO;
import kr.co.pap.account.UserVO;
import kr.co.pap.board.BoardVO;
import kr.co.pap.board.ReplyVO;
import kr.co.pap.board.SearchCriteria;
import kr.co.pap.services.AccountService;
import kr.co.pap.services.BoardService;

@Controller
public class UserboardManageController {
	@Autowired
	UserboardManageService service;
	@Autowired
	AccountService aservice;
	@Autowired
	BoardService bservice;
	@RequestMapping(value="admin/userboardmanage")
	public String userboardmanage(Model model,ReportCriteria cri) throws Exception {
		
		List<ReplyVO>vo = service.replylist();
		model.addAttribute("boardvo",service.boardlist(cri));
		model.addAttribute("replyvo", vo);
		model.addAttribute("listsize", vo.size());
		ReportPageMaker pageMaker = new ReportPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.reportcnt());
		
		
		model.addAttribute("boardpageMaker", pageMaker);
		
		return "admin/userboard/userboardmanage";
	}
	@RequestMapping(value="admin/userboardmanage/boarddelete")
	public String boarddelete(int bo_num) throws Exception{
		
		service.boarddelete(bo_num);
		
		return "redirect:/admin/userboardmanage";
	}
	@RequestMapping(value="admin/userboardmanage/replydelete")
	public String replydelete(int co_num) throws Exception{
		
		service.replydelete(co_num);
		
		return "redirect:/admin/userboardmanage";
	}
	
	@RequestMapping(value="admin/userboardmanage/boardback")
	public String boardback(int bo_num) throws Exception{
		
		service.boardback(bo_num);
		
		return "redirect:/admin/userboardmanage";
	}
	@RequestMapping(value="admin/userboardmanage/replyback")
	public String replyback(int co_num) throws Exception{
		
		service.replyback(co_num);
		
		return "redirect:/admin/userboardmanage";
	}
	@RequestMapping(value="admin/userboardmanage/userban")
	public String userban(String ui_id,int period,HttpServletResponse response) throws Exception{ 
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserVO vo = aservice.selecOneUser(ui_id);
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        if(vo.getUi_grade().equals("관리자")||vo.getUi_grade().equals("매니저")) {
        	out.println("<script>alert('관리자나 매니저는 정지를 줄수없습니다.');location.href = ('/pap/admin/userboardmanage')</script>");
			out.flush();
			out.close();
			return "redirect:/admin/userboardmanage";
        }
        
		if(period == 3) {
			cal.add(Calendar.DATE, 3);
			vo.setUi_enprohibit(df.format(cal.getTime()));
			service.userban(vo);
			out.println("<script>alert('유저아이디 : "+vo.getUi_id()+"  3일 정지');location.href = ('/pap/admin/userboardmanage')</script>");
			out.flush();
			out.close();
		}else if(period == 7) {
			cal.add(Calendar.DATE, 7);
			vo.setUi_enprohibit(df.format(cal.getTime()));
			service.userban(vo);
			out.println("<script>alert('유저아이디 : "+vo.getUi_id()+"  7일 정지');location.href = ('/pap/admin/userboardmanage')</script>");
			out.flush();
			out.close();
			
		}else if(period == 30) {
			cal.add(Calendar.MONTH, 1);
			vo.setUi_enprohibit(df.format(cal.getTime()));
			service.userban(vo);
			out.println("<script>alert('유저아이디 : "+vo.getUi_id()+"  한달 정지');location.href = ('/pap/admin/userboardmanage')</script>");
			out.flush();
			out.close();
			
		}else if(period == 100) {
			
			vo.setUi_enprohibit("2999-12-31");
			service.userban(vo);
			out.println("<script>alert('유저아이디 : "+vo.getUi_id()+"  영구정지');location.href = ('/pap/admin/userboardmanage')</script>");
			out.flush();
			out.close();
		}else if(period == 0) {
			service.banclear(vo.getUi_id());
			
			out.println("<script>alert('유저아이디 : "+vo.getUi_id()+"  정지해제');location.href = ('/pap/admin/userboardmanage')</script>");
			out.flush();
			out.close();
		}
		
		return "redirect:/admin/userboardmanage";
	}
	@RequestMapping(value="admin/userboardmanage/writeban")
	public String writeban(String ui_id,HttpServletResponse response) throws Exception{
		UserVO vo = aservice.selecOneUser(ui_id);
		 Calendar cal = Calendar.getInstance();
	        cal.setTime(new Date());
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	        cal.add(Calendar.DATE, 7);
	        vo.setUi_enprohibit(df.format(cal.getTime()));
	        service.writeban(vo);

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
	        out.println("<script>alert('유저아이디 : "+vo.getUi_id()+"  일주일 글쓰기 정지');location.href = ('/pap/admin/userboardmanage')</script>");
			out.flush();
			out.close();
	    	
		return "redirect:/admin/userboardmanage";
	}
	
	@ResponseBody
	@PostMapping(value="admin/userboardmanage/searchuser")
	public UserVO searchuser(String ui_id) throws Exception{
		
		
		
		return aservice.selecOneUser(ui_id);
	}
	@RequestMapping(value = "admin/usergrademanage")
	public String usergrademanage(Model model) throws Exception {
		model.addAttribute("boardvo", service.gradeuplist());
		model.addAttribute("listsize",service.gradeuplist().size());
		return "admin/userboard/usergrademanage";
	}
	@RequestMapping(value = "admin/usergrademanage/usergrade")
	public String usergrade(String ui_id,String grade,HttpServletResponse response,int bo_num) throws Exception {
		if(bo_num == 0) {
		service.usergrade(grade, ui_id);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
        out.println("<script>alert('유저아이디 : "+ui_id+" 현재유저 등급: "+grade+"');location.href = ('/pap/admin/usergrademanage')</script>");
		out.flush();
		out.close();
		}else {
			service.usergrade(grade, ui_id);
			bservice.delete(bo_num);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
	        out.println("<script>alert('유저아이디 : "+ui_id+" 현재유저 등급: "+grade+"');location.href = ('/pap/admin/usergrademanage')</script>");
			out.flush();
			out.close();
		}
		
		
		
		return "redirect:/admin/usergrademanage";
	}
	@RequestMapping(value = "admin/usergrademanage/gradeupreject")
	public String gradeupreject(int bo_num) throws Exception {
		
		bservice.delete(bo_num);
		return "redirect:/admin/usergrademanage";
	}
}
