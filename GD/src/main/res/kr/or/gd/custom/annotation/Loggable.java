/**
 * 
 */
package kr.or.gd.custom.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @ClassName	Loggable.java
 * @Description	
 * @Modification Information
 * @author		박예연
 * @since		2017. 8. 3.
 * @version		1.0
 * @see
 * <pre>
 * <<개정이력(Modification Information)>>
 * 수정일		수정자	수정내용
 * -------------------------------------
 * 2017. 8. 3.	박예연	최초 작성
 * </pre>
 * class: @시점
 * source : 
 * RUNTIME: 메모리 상에 올라갔을때 
 * 
 * 
 * FIELD	 : 전역변수에만
 * CONTRUCTOR : 생성자 위에만 선언
 * METHOD: 일반 메소드 상단에만
 * PACKAGE : 
 * PARAMETER : 지역변수
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@Documented
public @interface Loggable {
	//	@Controller("memberCtrl")-- 이름 바꾸려고 한다면
	//	class MemberController{}
	//	public String value;
	//  @Loggable("val")

	//root context의 등록 빈을 대상으로 로거 인젝션
	// 1. 사용자 정의 어노테이션 작성
	// 2. application-beanpostprocessor.xml의 사용자 정의 BeanPostProcessor작성
	// 3. 인젝션 및 활용
	//    @Loggable
	//    private Logger logger;

}
