package com.instagram.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component//스프링부트 실행시 저절로 실행

public class H2Runner implements ApplicationRunner{
	
	@Autowired
	DataSource dataSource;
	
	@Autowired
	JdbcTemplate jdbcTemplate;

	@Override
	public void run(ApplicationArguments args) throws Exception {
		try(Connection connection=dataSource.getConnection()){//connection이라는 리소스를 try안에서 사용하고 정리를 해준다
			//db의 정보를 출력
			System.out.println(connection.getMetaData().getClass());
			System.out.println(connection.getMetaData().getURL());
			System.out.println(connection.getMetaData().getUserName());
			
			
			//user테이블 생성
//			Statement statement=connection.createStatement();
//			String sql="CREATE TABLE MEMBER(ID INTEGER NOT NULL,name VARCHAR(255),PRIMARY KEY(id))";
//			statement.executeUpdate(sql);
		}
		//기본적인 jdbc api보다 좀더 편하다
//		jdbcTemplate.execute("insert into member values(2,'junseo')");
		
	}

}
