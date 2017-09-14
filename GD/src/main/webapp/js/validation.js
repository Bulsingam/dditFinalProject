// 패스워드 유효성 검사
String.prototype.validationPWD = function(){
	return /^[a-zA-Z0-9]+$/.test(this);
};
// 성명 유효성 검사
String.prototype.validationNM = function(){
	return /^[가-힣]{2,4}$/.test(this);
};
// 주민번호 유효성 검사
// '111111-1111118'.validationREGNO()
String.prototype.validationREGNO = function(){
	// 1 1 1 1 1 1 - 1 1 1 1 1 1               8(매직넘버)
	// * * * * * *   * * * * * * 
	// 2+3+4+5+6+7 + 8+9+2+3+4+5 = 값
	// => (11-(값%11))%10 = 산술값
	// 산술값 == 매직넘버  유효
	// 산술값 != 매직넘버  무효
	var target = this.replace('-', '');
	var magicNum = this.substr(13,1);
	var checkSum = '234567892345';
	var sum = 0;
	
	for(var i=0; i<12; i++){
		sum += target.charAt(i) * checkSum.charAt(i);
	}
	
	var finalValue = (11-(sum%11))%10;
	
	if(finalValue == parseInt(magicNum)){
		return true;
	}else{
		return false;
	}
};
// 휴대폰 유효성 검사
String.prototype.validationHP = function(){
	return /^01(0|1|6|7|8|9)-\d{3,4}-\d{4}$/.test(this);
};
// 메일 유효성 검사
String.prototype.validationMAIL = function(){
	return /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/.test(this);
};





