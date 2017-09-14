package kr.or.gd.utils;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpSession;

public class RSAGenerateKey {
   //반환값(Map<String, String>) : 공개키(작성된 공개키를 가수, 지수로 구분 저장 반환)
   public Map<String, String> getGeneratePairKey(HttpSession session){
      //정수 8 : 00001000
      //공개키 : 소수점을 포함하는 실수로 변환되어 작성.
      //1.23456789 or -1.23456789
      //32bit(단정도) : 0        0000000 0          00000000 00000000 00000000
      //             |
      //             부호비트   + 지수(8)       +      가수(23)
      //             0(양수)    소수점자리 표현       실제 해당 값
      //             1(음수)
      //64bit(배정도) : 0        00000000 0000       0000 00000000 00000000 00000000 00000000 00000000 00000000
      //             |
      //             부호비트   + 지수(11)       +      가수(52)
      KeyPairGenerator generator = null;
      KeyPair keyPair = null;
      KeyFactory keyFactory = null;
      
      //공개키(클라이언트)
      PublicKey publicKey = null;
      //비밀키(서버)
      PrivateKey privateKey = null;
      
      Map<String, String> keyMap = new HashMap<String, String>();
      
      try {
         //공개키 + 비밀키 생성시 적용될 암호화 알고리즘을 전달
         generator = KeyPairGenerator.getInstance("RSA");
         //공개키 생성시의 사이즈를 설정
         generator.initialize(2048);
         keyPair = generator.genKeyPair();
         
         publicKey = keyPair.getPublic();
         // 제공되는 공개키를 해당 암호화 알고리즘을 적용하여, 지수/가수부로 재작성
         keyFactory = KeyFactory.getInstance("RSA");
         RSAPublicKeySpec rsaPublicKeySpec =
               (RSAPublicKeySpec)keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
         //가수
         String modulus = rsaPublicKeySpec.getModulus().toString(16);
         String exponent = rsaPublicKeySpec.getPublicExponent().toString(16);
         keyMap.put("modulus", modulus);
         keyMap.put("exponent", exponent);
         
         privateKey = keyPair.getPrivate();
         session.setAttribute("rsaPrivateKey", privateKey);
         
      } catch (Exception e) {
         e.printStackTrace();
      }
      return keyMap;
   }
   
   public String decryptRSA(PrivateKey privateKey, String secureValue){
      String returnValue = null;
      
      try {
         Cipher cipher = Cipher.getInstance("RSA");
         //16비트의 2048 byte 사이즈의 암호문을 평문으로 복호화 전
         //바이트코드로 변환
         byte[] encryptBytes = hexToByteArray(secureValue);
         
         cipher.init(Cipher.DECRYPT_MODE, privateKey);
         
         byte[] values = cipher.doFinal(encryptBytes);
         returnValue = new String(values,"UTF-8");
      } catch (NoSuchAlgorithmException e) {
         e.printStackTrace();
      } catch (NoSuchPaddingException e) {
         e.printStackTrace();
      } catch (InvalidKeyException e) {
         e.printStackTrace();
      } catch (IllegalBlockSizeException e) {
         e.printStackTrace();
      } catch (BadPaddingException e) {
         e.printStackTrace();
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
      return returnValue;
   }
   
   
   private byte[] hexToByteArray(String secureValue){
      if(secureValue == null || secureValue.length()%2 != 0){
         return new byte[]{};
      }
      byte[] bytes = new byte[secureValue.length()/2];
      
      for (int i = 0; i < secureValue.length(); i+=2) {
         byte value = (byte)Integer.parseInt(secureValue.substring(i, i+2),16);
         bytes[(int)Math.floor(i/2)] = value;
      }
      return bytes;
   }
}