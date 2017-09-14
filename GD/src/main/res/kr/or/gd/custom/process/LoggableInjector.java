package kr.or.gd.custom.process;

import java.lang.reflect.Field;

import kr.or.gd.custom.annotation.Loggable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.stereotype.Component;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.ReflectionUtils.FieldCallback;

//BeanPostProcessor : 스프링 프레임웍이 관리하는 모든 빈들의 인스턴스화를 관장.
//(DefaultBeanPostProcessor )가 이때까지 쓰여졌음
//
//** 사용자 정의 BeanPostProcessor는 implement BeanPostProcessor{}					
//빈 등록시 DefaultBeanPostProcessor 를 대신하여 모든 빈들의 인스턴스화를 관장
//
@Component
public class LoggableInjector implements BeanPostProcessor {

   @Override
   public Object postProcessAfterInitialization(Object bean, String beanName)
         throws BeansException {
      return bean;
   }

   @Override
   public Object postProcessBeforeInitialization(final Object bean, String beanName)
         throws BeansException {
      System.out.println("Bean 네임 : "+bean.getClass());
      ReflectionUtils.doWithFields(bean.getClass(), new FieldCallback(){
         @Override
         public void doWith(Field field) throws IllegalArgumentException,
               IllegalAccessException {
            ReflectionUtils.makeAccessible(field);
            if(field.getAnnotation(Loggable.class) != null){
               Logger logger = LoggerFactory.getLogger(bean.getClass());
               field.set(bean, logger);
            }
         }
      });
      return bean;
   }

}