
  var  currentHours;
  var currentMinutes;
  var currentSeconds;

var a = [2,3,5,6,7,8,9,0],
    b = [1,2,3,4,7,8,9,0],
    c = [1,3,4,5,6,7,8,9,0],
    d = [2,3,5,6,8,0],
    e = [6,8,2,0],
    f = [4,5,6,8,9,0],
    g = [2,3,4,5,6,8,9];

var constants = [ [2,3,5,6,7,8,9,0],[1,2,3,4,7,8,9,0],[1,3,4,5,6,7,8,9,0],[2,3,5,6,8,0],[6,8,2,0],[4,5,6,8,9,0],[2,3,4,5,6,8,9] ];

var hours = [],
    minutes = [],
    seconds = [];

var map = ['a','b','c','d','e','f'];


function updateDate(){
    currentDate = new Date();
    currentHours = currentDate.getHours();
    if (currentHours < 10){
        currentHours = '0' + currentHours;
    }
    currentMinutes = currentDate.getMinutes();
    if (currentMinutes < 10){
        currentMinutes = '0' + currentMinutes;
    }
    currentSeconds = currentDate.getSeconds();
    if (currentSeconds < 10){
        currentSeconds = '0' + currentSeconds;
    }

}

function splitDigits(stringVal,array){
    var tempString = stringVal.toString();
    array.length = 0
    for (var i = 0; i < tempString.length; i++) {
        array.push(+tempString.charAt(i));
    }
}

function checkVal(val,array){
    for (var k = 0; k < array.length; k++){
        if (val == array[k]){
            return true;
        }
    }
    return false;
}

function printDigits(array, elem){
    for (var count = 0; count < array.length; count++) {
        for (var segmentCount = 0; segmentCount < 7; segmentCount++){
            if ( checkVal(array[count], constants[segmentCount] ) == true){
                turnOn(elem+(count+1)+' div:nth-of-type('+(segmentCount+1)+')');
            } else {
                turnOff(elem+(count+1)+' div:nth-of-type('+(segmentCount+1)+')');
            }
        }
    };
}

function turnOn(elem){
    $(elem).addClass('on');
}

function turnOff(elem){
    $(elem).removeClass('on');
}

$( document ).ready(function() {
    setInterval(function(){
         $('.dot').toggleClass('on');
    },1000);

    console.log( checkVal(7,constants[4]) );

    setInterval(function(){
        updateDate();
        splitDigits(currentSeconds,seconds);
        printDigits(seconds,'.s');

        splitDigits(currentMinutes,minutes);
        printDigits(minutes,'.m');

        splitDigits(currentHours,hours);
        printDigits(hours,'.h');
    },1000);

});
