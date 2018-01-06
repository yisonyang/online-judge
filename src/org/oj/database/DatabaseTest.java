package org.oj.database;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.oj.model.javaBean.TestPointBean;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

/**
 * Created by xanarry on 17-4-22.
 */
public class DatabaseTest {
    public static void main(String[] argv) throws IOException {
        String resource = "org/oj/database/mybatis-config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);

        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

        SqlSession sqlSession = sqlSessionFactory.openSession();
        try {

            TestPoint testPoint = sqlSession.getMapper(TestPoint.class);
            List<TestPointBean> v = testPoint.getTestPointList(5);
            System.out.println(v);

            TestPointBean t = testPoint.getTestPoint(5, 3);
            System.out.println(t);
        } finally {
            sqlSession.close();
        }
    }
}
