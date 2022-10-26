package kr.co.pap.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pap.account.UserVO;
import kr.co.pap.chat.ChatVO;

@Repository
public class chatDAOImpl implements chatDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private static final String namespace = "kr.co.pap.chatMapper";
	
	@Override
	public int addChat(ChatVO chatVO) throws Exception {
		// 대화내용추가
		return sqlSession.insert(namespace+".addChat", chatVO);
	}

	@Override
	public List<UserVO> listUsers() throws Exception {
		// 회원목록조회
		return sqlSession.selectList(namespace+".listUsers");
	}

	@Override
	public List<ChatVO> getChat(ChatVO chatVO) throws Exception {
		// 대화목록불러오기
		return sqlSession.selectList(namespace+".getChat", chatVO);
	}

}
