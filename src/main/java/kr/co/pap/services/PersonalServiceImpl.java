package kr.co.pap.services;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.PersonalDAO;
import kr.co.pap.board.BoardVO;
import kr.co.pap.personal.CalVO;
import kr.co.pap.personal.Criteria;
import kr.co.pap.personal.MemoVO;
import kr.co.pap.personal.PagingVO;

@Service
public class PersonalServiceImpl implements PersonalService {

	@Autowired
	private PersonalDAO pdao;
	
	@Override
	public List<MemoVO> memo(Criteria cri) {
		// TODO Auto-generated method stub
		return pdao.memo(cri);
	}

	@Override
	public int insertmemo(MemoVO mv) {
		// TODO Auto-generated method stub
		return pdao.insertmemo(mv);
	}

	@Override
	public MemoVO detailmemo(int mm_mno) {
		// TODO Auto-generated method stub
		return pdao.detailmemo(mm_mno);
	}

	@Override
	public int updatememo(MemoVO mv) {
		// TODO Auto-generated method stub
		return pdao.updatememo(mv);
	}

	@Override
	public int deletememo(int mm_mno) {
		// TODO Auto-generated method stub
		return pdao.deletememo(mm_mno);
	}

	@Override
	public List<CalVO> calendar(String ui_id) {
		// TODO Auto-generated method stub
		return pdao.calendar(ui_id);
	}

	@Override
	public int calinsert(CalVO cv) {
		// TODO Auto-generated method stub
		return pdao.calinsert(cv);
	}

	@Override
	public int calupdate(CalVO cv) {
		// TODO Auto-generated method stub
		return pdao.calupdate(cv);
	}

	@Override
	public int caldelete(int cd_id) {
		// TODO Auto-generated method stub
		return pdao.caldelete(cd_id);
	}

	@Override
	public int memoCnt() {
		// TODO Auto-generated method stub
		return pdao.memoCnt();
	}

    @Override
    public List<BoardVO> myBoardList(PagingVO vo) {
        
        List<BoardVO> blist = pdao.myBoardList(vo);
        
        return blist;
    }

    @Override
    public int myBoardCount(String ui_id) {
        // TODO Auto-generated method stub
        return pdao.myBoardCount(ui_id);
    }
}
