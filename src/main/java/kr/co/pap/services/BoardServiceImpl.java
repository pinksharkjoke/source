package kr.co.pap.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.pap.DAO.BoardDAO;
import kr.co.pap.board.BoardVO;
import kr.co.pap.board.Criteria;
import kr.co.pap.board.HeartVO;
import kr.co.pap.board.ReplyVO;
import kr.co.pap.board.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardDAO dao;

	@Override
	public int insert(BoardVO boardVO) throws Exception {
		// 글 작성
		return dao.insert(boardVO);
	}

	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		// 전체조회
		return dao.list(scri);
	}

	@Override
	public BoardVO detail(int bo_num) throws Exception {
		// 선택조회 & 조회수 증가
		dao.readCnt(bo_num);
		return dao.detail(bo_num);
	}

	@Override
	public int delete(int bo_num) throws Exception {
		// 글 삭제
		return dao.delete(bo_num);
	}

	@Override
	public int update(BoardVO boardVO) throws Exception {
		// 글 수정
		return dao.update(boardVO);
	}

	@Override
	public List<ReplyVO> list3(int bo_num) throws Exception {
		// 댓글 목록
		return dao.list3(bo_num);
	}

	@Override
	public int insert3(ReplyVO reply) throws Exception {
		// 댓글 추가
		return dao.insert3(reply);
	}


	@Override
	public int update3(ReplyVO replyvo) throws Exception {
		// 댓글수정
		return dao.update3(replyvo);
	}

	@Override
	public int delete3(int co_num) throws Exception {
		// 댓글 삭제
		return dao.delete3(co_num);
	}

	@Override
	public int report3(int co_num) throws Exception {
		// 댓글 신고
		return dao.report3(co_num);
	}

	@Override
	public int report(int bo_num) throws Exception {
		// 글 신고
		return dao.report(bo_num);
	}


	
	@Override
	public int like(int bo_num) throws Exception {
		// 게시글 좋아요 카운트
		return dao.like(bo_num);
	}

	@Override
	public int dislike(int bo_num) throws Exception {
		// 게시글 좋아요 취소 카운트
		return dao.dislike(bo_num);
	}
	
	@Override
	public int like2(HeartVO heartVO) throws Exception {
		// 좋아요 테이블
		return dao.like2(heartVO);
	}
	
	@Override
	public int dislike2(int he_num) throws Exception {
		// 좋아요 취소 테이블
		return dao.dislike2(he_num);
	}

	@Override
	public int like3(int co_num) throws Exception {
		// 댓글 좋아요 카운트
		return dao.like3(co_num);
	}

	@Override
	public int dislike3(int co_num) throws Exception {
		// 댓글 좋아요 취소 카운트
		return dao.dislike3(co_num);
	}

	@Override
	public Integer findLike(HeartVO heartVO) throws Exception {
		// 글 좋아요 조회 

		return dao.findLike(heartVO);
	}



	@Override
	public Integer findLike3(HeartVO heartVO) throws Exception {
		// 댓글 좋아요 조회
		return dao.findLike3(heartVO);
	}

  @Override
	public int listCount(SearchCriteria scri) throws Exception {
		// 글카운트 
		// 전체 글 

		return dao.listCount(scri);
  }


	@Override
	public int dislike4(HeartVO heartVO) throws Exception {
		// 댓글 좋아요 취소 테이블 
		return dao.dislike4(heartVO);
	}


	@Override
	public int replyCount(int bo_num) throws Exception {
		// 댓글 총 갯수
		return dao.replyCount(bo_num);
	}

	@Override
	public List<BoardVO> listRecent(int ca_num) throws Exception {
		// 최근글 목록 조회
		return dao.listRecent(ca_num);
	}

	@Override
	public List<BoardVO> listing(SearchCriteria scri) throws Exception {
		// 판매중인 글만보기
		return dao.listing(scri);
	}

	@Override
	public int listingCount(SearchCriteria scri) throws Exception {
		// 판매 글 수
		return dao.listingCount(scri);
	}

	@Override
	public List<BoardVO> listnotice(int ca_num) throws Exception {
		// 공지글 리스트
		return dao.listnotice(ca_num);
	}

	@Override
	public String getName(String ui_id) throws Exception {
		// 글테이블 아이디로 유저테이블 닉네임 가져오기
		return dao.getName(ui_id);
	}

	@Override
	public String getGrade(String ui_id) throws Exception {
		// 글테이블 아이디로 유저테이블 등급 가져오기
		return dao.getGrade(ui_id);
	}

	@Override
	public List<BoardVO> getHot() throws Exception {
		// 인기글 7일 이내 6개 조회
		return dao.getHot();
	}

	@Override
	public List<BoardVO> monthPet() throws Exception {
		// 이달의 펫
		return dao.monthPet();
	}


	@Override
	public List<BoardVO> relatedPost(String pl_name) throws Exception {
		// 관련 글 
		return dao.relatedPost(pl_name);
	}





	
}
