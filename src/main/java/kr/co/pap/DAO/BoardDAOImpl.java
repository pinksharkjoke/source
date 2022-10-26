package kr.co.pap.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.board.BoardVO;
import kr.co.pap.board.Criteria;
import kr.co.pap.board.HeartVO;
import kr.co.pap.board.ReplyVO;
import kr.co.pap.board.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;

	// 접근하는 파일 이름
	private static final String namespace = "kr.co.pap.boardMapper";

	@Override
	public int insert(BoardVO boardVO) throws Exception {
		// 글 작성
		return sqlSession.insert(namespace + ".insert", boardVO);
	}

	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		// 전체조회
		return sqlSession.selectList(namespace + ".listPage", scri);
	}

	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		// 글수
		return sqlSession.selectOne(namespace + ".listCount", scri);
	}

	@Override
	public BoardVO detail(int bo_num) throws Exception {
		// 상세조회
		return sqlSession.selectOne(namespace + ".detail", bo_num);
	}

	@Override
	public int readCnt(int bo_num) throws Exception {
		// 조회수 증가
		return sqlSession.update(namespace + ".readCnt", bo_num);
	}

	@Override
	public int delete(int bo_num) throws Exception {
		// 글 삭제
		return sqlSession.update(namespace + ".delete", bo_num);
	}

	@Override
	public int update(BoardVO boardVO) throws Exception {
		// 글 수정
		return sqlSession.update(namespace + ".update", boardVO);
	}

	@Override
	public List<ReplyVO> list3(int bo_num) throws Exception {
		// 댓글목록
		return sqlSession.selectList(namespace + ".listAll3", bo_num);
	}

	@Override
	public int insert3(ReplyVO reply) throws Exception {
		// 댓글 쓰기
		return sqlSession.insert(namespace + ".insert3", reply);
	}

	@Override
	public int update3(ReplyVO replyvo) throws Exception {
		// 댓 수
		return sqlSession.update(namespace + ".update3", replyvo);
	}

	@Override
	public int delete3(int co_num) throws Exception {
		// 댓 삭
		return sqlSession.delete(namespace + ".delete3", co_num);
	}

	@Override
	public int report3(int co_num) throws Exception {
		// TODO 댓 신
		return sqlSession.update(namespace + ".report3", co_num);
	}

	@Override
	public int report(int bo_num) throws Exception {
		// 글 신고 메소드
		return sqlSession.update(namespace + ".report", bo_num);
	}

	@Override
	public int like(int bo_num) throws Exception {
		// 글 좋아요 카운트 메소드
		return sqlSession.update(namespace + ".like", bo_num);
	}

	@Override
	public int dislike(int bo_num) throws Exception {
		// 글 좋아요 취소 카운트 메소드
		return sqlSession.update(namespace + ".dislike", bo_num);
	}

	@Override
	public int like2(HeartVO heartVO) throws Exception {
		// 좋아요 테이블 메소드
		return sqlSession.insert(namespace + ".like2", heartVO);
	}

	@Override
	public int dislike2(int he_num) throws Exception {
		// 좋아요 취소 테이블 메소드
		return sqlSession.delete(namespace + ".dislike2", he_num);
	}

	@Override
	public int like3(int co_num) throws Exception {
		// 댓글 좋아요 카운트 메소드
		return sqlSession.update(namespace + ".like3", co_num);
	}

	@Override
	public int dislike3(int co_num) throws Exception {
		// 댓글 좋아요 취소 카운트 메소드
		return sqlSession.update(namespace + ".dislike3", co_num);
	}

	@Override
	public Integer findLike(HeartVO heartVO) throws Exception {
		// 글 좋아요 조회 메소드
		return sqlSession.selectOne(namespace + ".findLike", heartVO);
	}

	@Override
	public Integer findLike3(HeartVO heartVO) throws Exception {
		// 댓글 좋아요 조회 메소드
		return sqlSession.selectOne(namespace + ".findLike3", heartVO);
	}

	@Override
	public int dislike4(HeartVO heartVO) throws Exception {
		// 댓글 좋아요 삭제 테이블 메소드
		return sqlSession.delete(namespace + ".dislike4", heartVO);
	}

	@Override
	public int replyCount(int bo_num) throws Exception {
		// 댓글 총 갯수
		return sqlSession.selectOne(namespace + ".replyCount", bo_num);
	}

	@Override
	public List<BoardVO> listRecent(int ca_num) throws Exception {
		// 최근 글 목록
		return sqlSession.selectList(namespace + ".listRecent", ca_num);
	}

	@Override
	public List<BoardVO> listing(SearchCriteria scri) throws Exception {
		// 판매중인 글만 보기
		return sqlSession.selectList(namespace + ".listing", scri);
	}

	@Override
	public int listingCount(SearchCriteria scri) throws Exception {
		// 판매중 글 수
		return sqlSession.selectOne(namespace + ".listingCount", scri);
	}

	@Override
	public List<BoardVO> listnotice(int ca_num) throws Exception {
		// 공지 글 보기
		return sqlSession.selectList(namespace + ".listnotice", ca_num);
	}

	@Override
	public String getName(String ui_id) throws Exception {
		// 게시글 테이블에서 유저테이블 닉네임가져오기
		return sqlSession.selectOne(namespace + ".getName", ui_id);
	}

	@Override
	public String getGrade(String ui_id) throws Exception {
		// 게시글 테이블에서 유저테이블 등급가져오기
		return sqlSession.selectOne(namespace + ".getGrade", ui_id);
	}

	@Override
	public List<BoardVO> getHot() throws Exception {
		// 인기글 7일 이내 6개 조회
		return sqlSession.selectList(namespace + ".getHot");
	}

	@Override
	public List<BoardVO> monthPet() throws Exception {
		// 이달의 펫
		return sqlSession.selectList(namespace + ".monthPet");
	}

	@Override
	public List<BoardVO> relatedPost(String pl_name) throws Exception {
		// 관련글

		return sqlSession.selectList(namespace + ".relatedPost", pl_name);
	}

	


}