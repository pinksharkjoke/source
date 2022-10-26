package kr.co.pap.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.board.BoardVO;
import kr.co.pap.personal.CalVO;
import kr.co.pap.personal.Criteria;
import kr.co.pap.personal.MemoVO;
import kr.co.pap.personal.PagingVO;

@Repository
public class PersonalDAOImpl implements PersonalDAO{
	
	private static final String NAMESPACE = "kr.co.pap.personalMapper";
	
	@Autowired
	private SqlSession sqlSession; 
	
	//�޸� ������
	@Override
	public List<MemoVO> memo(Criteria cri) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".memo", cri);
	}

	@Override
	public int insertmemo(MemoVO mv) {
		// TODO Auto-generated method stub
		return sqlSession.insert(NAMESPACE + ".insertmemo", mv);
	}
	@Override
	public MemoVO detailmemo(int mm_mno) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".detailmemo", mm_mno);
	}

	@Override
	public int updatememo(MemoVO mv) {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".updatememo", mv);
	}

	@Override
	public int deletememo(int mm_mno) {
		// TODO Auto-generated method stub
		return sqlSession.delete(NAMESPACE + ".deletememo", mm_mno);
	}
	
	@Override
	public List<CalVO> calendar(String ui_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".calenList", ui_id);
	}

	@Override
	public int calinsert(CalVO cv) {
		// TODO Auto-generated method stub
		return sqlSession.insert(NAMESPACE + ".calinsert", cv);
	}

	@Override
	public int calupdate(CalVO cv) {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + ".calupdate", cv);
	}

	@Override
	public int caldelete(int cd_id) {
		// TODO Auto-generated method stub
		return sqlSession.delete(NAMESPACE + ".caldelete", cd_id);
	}

	@Override
	public int memoCnt() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".memoCnt");
	}

    @Override
    public List<BoardVO> myBoardList(PagingVO vo) {
        // TODO Auto-generated method stub
        return sqlSession.selectList(NAMESPACE + ".myBoardList", vo);
    }

    @Override
    public int myBoardCount(String ui_id) {
        // TODO Auto-generated method stub
        return sqlSession.selectOne(NAMESPACE + ".myBoardCount", ui_id);
    }

	
}
