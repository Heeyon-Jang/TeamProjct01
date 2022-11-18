package com.awoo.config;

import java.util.Properties;

import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.transaction.managed.ManagedTransactionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.awoo.interceptor.LoginInterceptor;

// Spring MVC 프로젝트에 관련된 설정을 하는 클래스
@Configuration
// Controller 어노테이션이 셋팅되어 있는 클래스를 Controller로 등록한다.
@EnableWebMvc
// 스캔할 패키지를 지정한다.
@ComponentScan("com.awoo")
@MapperScan(basePackages = { "com.awoo.dao" }, annotationClass = org.apache.ibatis.annotations.Mapper.class)
@PropertySource("/META-INF/properties/db.properties")	
@EnableTransactionManagement
public class ServletAppContext implements WebMvcConfigurer {

	@Value("${db.classname}")
	private String db_classname;

	@Value("${db.url}")
	private String db_url;

	@Value("${db.username}")
	private String db_username;

	@Value("${db.password}")
	private String db_password;

	// Controller의 메서드가 반환하는 jsp의 이름 앞뒤에 경로와 확장자를 붙혀주도록 설정한다.
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	// 정적 파일의 경로를 매핑한다.
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addResourceHandlers(registry);
		//상위 경로를 resource(내부 파일 경로 태움), upload(외부 파일 경로 태움)로 지정
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		registry.addResourceHandler("/upload/**").addResourceLocations("file:///C:/sample/");

	}

	// 데이터베이스 접속 정보 관리
	@Bean
	public BasicDataSource dataSource() {
		BasicDataSource source = new BasicDataSource();
		source.setDriverClassName(db_classname);
		source.setUrl(db_url);
		source.setUsername(db_username);
		source.setPassword(db_password);
		return source;
	}

	// 쿼리문과 접속 관리하는 객체
	@Bean("SqlSessionFactory")
	public SqlSessionFactory factory(BasicDataSource source, ApplicationContext applicationContext) throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(source);
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("/META-INF/mappers/*.xml"));
		sqlSessionFactoryBean.setTypeAliasesPackage("com.awoo.vo");
		
		org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
		configuration.setMapUnderscoreToCamelCase(true);
		configuration.setCacheEnabled(false);
		configuration.setUseGeneratedKeys(true);
		configuration.setDefaultExecutorType(org.apache.ibatis.session.ExecutorType.REUSE);
		
		sqlSessionFactoryBean.setConfiguration(configuration);
		sqlSessionFactoryBean.setTransactionFactory(new ManagedTransactionFactory());

		return sqlSessionFactoryBean.getObject();
	}
	
	// 파일 업로드 세팅
	private final int MAX_SIZE = 10 * 1024 * 1024;
	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		// 디폴트 인코딩 타입 설정
		multipartResolver.setDefaultEncoding("UTF-8");
		// 전체 올릴 수 있는 파일들의 총 용량 최대치
		multipartResolver.setMaxUploadSize(MAX_SIZE*10);
		// 파일 한개 당 올릴 수 있는 용량 최대치
		multipartResolver.setMaxUploadSizePerFile(MAX_SIZE);
		return multipartResolver;
	}
	
	//로그인 검증(인터셉터)
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addInterceptors(registry);
		
		LoginInterceptor loginInter = new LoginInterceptor();
		InterceptorRegistration reg = registry.addInterceptor(loginInter);
		
		reg.addPathPatterns("/login/home");
	}
	
	@Bean
    public JavaMailSenderImpl javaMailService() {
          JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
          // 구글
          javaMailSender.setHost("smtp.gmail.com");
          javaMailSender.setPort(587);
          javaMailSender.setProtocol("smtp");
          javaMailSender.setUsername("awoogof@gmail.com");
          javaMailSender.setPassword("nbqvddvjbuqbddgw");

          
          Properties mailProperties = new Properties();
          mailProperties.put("mail.debug", true);
          mailProperties.put("mail.smtp.auth", "true");
          mailProperties.put("mail.smtp.starttls.enable", true);
          mailProperties.put("mail.smtp.debug", "true");
          javaMailSender.setJavaMailProperties(mailProperties);
          return javaMailSender;
   }

}
