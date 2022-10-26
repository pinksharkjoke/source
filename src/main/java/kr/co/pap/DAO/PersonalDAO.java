package kr.co.pap.DAO;

import java.util.List;

import kr.co.pap.board.BoardVO;
import kr.co.pap.personal.CalVO;
import kr.co.pap.personal.Criteria;
import kr.co.pap.personal.MemoVO;
import kr.co.pap.personal.PagingVO;

public interface PersonalDAO {
	
	//�޸� ������
	public List<MemoVO> memo(Criteria cri);
	//�޸𰹼�
	public int memoCnt();
	//�޸� �߰�
	public int insertmemo(MemoVO mv);
	//�޸� �󼼺���
	public MemoVO detailmemo(int mm_mno);
	//�޸� ����
	public int updatememo(MemoVO mv);
	//�޸� ����
	public int deletememo(int mm_mno);
	//Ķ���� ������
	public List<CalVO> calendar(String ui_id);
	//���� �߰�
	public int calinsert(CalVO cv);
	//���� ����
	public int calupdate(CalVO cv);
	//���� ����
	public int caldelete(int cd_id);
	// my board list all
    public List<BoardVO> myBoardList(PagingVO vo);
    // my board count
    public int myBoardCount(String ui_id);
}
