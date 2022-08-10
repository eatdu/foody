var check = (function(){
    function email(email){
        var regex=/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return (email != '' && email != 'undefined' && regex.test(email));
    }

    function pwd(pwd){
        var num = pwd.search(/[0-9]/g);
        var eng = pwd.search(/[a-z]/ig);
        var spe = pwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
        
        if(pwd === ''){
            return {success: false, msg: '비밀번호는 숫자, 영문 조합으로 8자 이상으로 입력해주세요.'};
        }else if(pwd.length < 8 || pwd.length > 20){
            return {success: false, msg: "8자리 ~ 20자리 이내로 입력해주세요."};
        }else if(pwd.search(/\s/) != -1){
            return {success: false, msg: "비밀번호는 공백 없이 입력해주세요."};
        }else if(num < 0 || eng < 0 || spe < 0 ){
            return {success: false, msg: "영문,숫자, 특수문자를 혼합하여 입력해주세요."};
        }else {
            return {success: true, msg: "적합한 비밀번호"};
        }
    }

    function birth(birth){

    }

    function tel(tel){
        var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
        if (regPhone.test(tel) === false) {
            return {success: false, msg: '부적합한 휴대폰번호'};
        } else {
            return {success: true, msg: '적합한 휴대폰번호'};
        }
    }

    return {
        email: email,
        pwd: pwd,
        birth: birth,
        tel: tel
    };
})();