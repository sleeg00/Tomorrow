package com.example.Tomorrow.Repository;

import com.example.Tomorrow.Dao.Member;
import com.example.Tomorrow.Dao.Post;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;


import javax.persistence.EntityManager;
import java.util.List;

import static com.example.Tomorrow.Dao.QPost.post;



public class PostRepositoryImpl {
    @Autowired
    MemberRepository memberRepository;
    private final EntityManager em;
    private final JPAQueryFactory query;

    public PostRepositoryImpl(EntityManager em, JPAQueryFactory query) {
        this.em = em;
        this.query = query;
    }


    public Slice<Post> searchBySlice(Long lastPostId, Long member_id,  Pageable pageable)
    {
        Member member = memberRepository.findById(member_id).orElseGet(Member::new);
        List<Post> results = query.selectFrom(post)
                .where(
                        // no-offset 페이징 처리
                        ltPostId(lastPostId),
                        // 기타 조건들
                        post.member.eq(member)
                )
                .orderBy(post.post_id.desc())
                .limit(pageable.getPageSize()+1)
                .fetch();

        // 무한 스크롤 처리
        return checkLastPage(pageable, results);
    }

    // no-offset 방식 처리하는 메서드
    private BooleanExpression ltPostId(Long lastPostId) {
        if (lastPostId==null) {
            return null;
        }

        return post.post_id.lt(lastPostId);
    }

    // 무한 스크롤 방식 처리하는 메서드
    private Slice<Post> checkLastPage(Pageable pageable, List<Post> results) {

        boolean hasNext = false;

        // 조회한 결과 개수가 요청한 페이지 사이즈보다 크면 뒤에 더 있음, next = true
        if (results.size() > pageable.getPageSize()) {
            hasNext = true;
            results.remove(pageable.getPageSize());
        }

        return new SliceImpl<>(results, pageable, hasNext);
    }
}
