package kr.co.pap.DAO;

import java.util.List;


import kr.co.pap.board.BoardVO;
import kr.co.pap.board.Criteria;
import kr.co.pap.board.HeartVO;
import kr.co.pap.board.ReplyVO;
import kr.co.pap.board.SearchCriteria;

public interface BoardDAO {

	// 글 쓰기 메소드
	public int insert(BoardVO boardVO) throws Exception;
	
	// 전체목록 메소드
	public List<BoardVO> list(SearchCriteria scri) throws Exception;


	
	//판매중인 글만보기
	public List<BoardVO> listing(SearchCriteria scri) throws Exception;
	
	// 글 수
	public int listCount(SearchCriteria scri) throws Exception;

	// 판매중글 수
	public int listingCount(SearchCriteria scri) throws Exception;
	
	// 글테이블 아이디로 유저테이블 닉네임 가져오기
	public String getName(String ui_id) throws Exception; 
	
	// 상세조회 메소드
	public BoardVO detail(int bo_num) throws Exception;
	
	// 조회수 증가 메소드
	public int readCnt(int bo_num) throws Exception;
	
	// 글 삭제 메소드
	public int delete(int bo_num) throws Exception;

	// 글 수정 메소드
	public int update(BoardVO boardVO) throws Exception;
	
	// 글 신고 메소드
	public int report(int bo_num) throws Exception;
	
	
	// 글 좋아요 조회 메소드
	public Integer findLike(HeartVO heartVO) throws Exception;
	
	// 글 좋아요 카운트 메소드
	public int like(int bo_num) throws Exception;
	
	// 글 좋아요취소 카운트 메소드
	public int dislike(int bo_num) throws Exception;
	
	// 좋아요 테이블 메소드
	public int like2(HeartVO heartVO) throws Exception;
	
	// 게시글 좋아요 취소 테이블 메소드
	public int dislike2(int he_num) throws Exception;
	
	// 댓글 좋아요 취소 테이블 메소드
	public int dislike4(HeartVO heartVO) throws Exception;
	
	// 댓글 좋아요 조회 메소드
	public Integer findLike3(HeartVO heartVO) throws Exception;
	
	// 댓글 좋아요 카운트 메소드
	public int like3(int co_num) throws Exception;
	
	// 댓글 좋아요 취소 카운트 메소드
	public int dislike3(int co_num) throws Exception;
	
	
	//댓글 목록 보기
	public List<ReplyVO> list3(int bo_num) throws Exception;
	//댓글 쓰기
	public int insert3(ReplyVO reply) throws Exception; 

	//댓글 수정
	public int update3(ReplyVO replyvo) throws Exception;
	//댓글 삭제
	public int delete3(int co_num) throws Exception;
	//댓글 신고
	public int report3(int co_num) throws Exception;

	// 댓글 총 갯수
	public int replyCount(int bo_num) throws Exception;
	
	// 최근글 조회
	public List<BoardVO> listRecent(int ca_num) throws Exception;
	//공지 글 조회
	public List<BoardVO> listnotice(int ca_num) throws Exception;
	
	// 글테이블 아이디로 유저테이블 등급 가져오기
	public String getGrade(String ui_id) throws Exception; 
	
	// 인기글 7일 이내 6개 조회 
	public List<BoardVO> getHot() throws Exception;
	// 이달의 펫 7일 이내 2개 조회 
	public List<BoardVO> monthPet() throws Exception;
	// 관련 글
	public List<BoardVO> relatedPost(String pl_name) throws Exception;
	
	
}
