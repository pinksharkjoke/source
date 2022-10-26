package kr.co.pap.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.co.pap.board.BoardVO;
import kr.co.pap.personal.CalVO;
import kr.co.pap.personal.Criteria;
import kr.co.pap.personal.MemoVO;
import kr.co.pap.personal.PagingVO;

public interface PersonalService {
	
	//占쌨몌옙 占쏙옙占쏙옙占쏙옙
	public List<MemoVO> memo(Criteria cri);
	//硫붾え 媛��닔
	public int memoCnt();
	//占쌨몌옙 占쌩곤옙
	public int insertmemo(MemoVO mv);
	//占쌨몌옙 占쏢세븝옙占쏙옙
	public MemoVO detailmemo(int mm_mno);
	//占쌨몌옙 占쏙옙占쏙옙
	public int updatememo(MemoVO mv);
	//占쌨몌옙 占쏙옙占쏙옙
	public int deletememo(int mm_mno);
	//캘占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙
	public List<CalVO> calendar(String ui_id);
	//占쏙옙占쏙옙 占쌩곤옙
	public int calinsert(CalVO cv);
	//占쏙옙占쏙옙 占쏙옙占쏙옙
	public int calupdate(CalVO cv);
	//占쏙옙占쏙옙 占쏙옙占쏙옙
	public int caldelete(int cd_id);
	// my board list all
	public List<BoardVO> myBoardList(PagingVO vo);
	// my board count
	public int myBoardCount(String ui_id);
}
