/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function() {
    setInterval( function() {
    var seconds = new Date().getSeconds();
    var sdegree = seconds * 6;
    var srotate = "rotate(" + sdegree + "deg)";
    $("#secA").css({"-moz-transform" : srotate, "-webkit-transform" : srotate});}, 1000 );
    setInterval( function() {
    var hours = new Date().getHours();
    var mins = new Date().getMinutes();
    var hdegree = hours * 30 + (mins / 2);
    var hrotate = "rotate(" + hdegree + "deg)";
    $("#hourA").css({"-moz-transform" : hrotate, "-webkit-transform" : hrotate});}, 1000 );
    setInterval( function() {
    var mins = new Date().getMinutes();
    var mdegree = mins * 6;
    var mrotate = "rotate(" + mdegree + "deg)";
    $("#minA").css({"-moz-transform" : mrotate, "-webkit-transform" : mrotate});}, 1000 );
}); 
$(document).ready(function() {
    // Create two variable with the names of the months and days in an array
    var monthNames = [ "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Juliio", "Agosto", "Septiembre", "Ocubre", "Noviembre", "Diciembre" ]; 
    var dayNames= ["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"];

    // Create a newDate() object
    var newDate = new Date();
    // Extract the current date from Date object
    newDate.setDate(newDate.getDate());
    // Output the day, date, month and year    
    $('#Date').html(dayNames[newDate.getDay()] + " " + newDate.getDate() + ' de ' + monthNames[newDate.getMonth()] + ' del ' + newDate.getFullYear());

    setInterval( function() {
            // Create a newDate() object and extract the seconds of the current time on the visitor's
            var seconds = new Date().getSeconds();
            // Add a leading zero to seconds value
            $("#sec").html(( seconds < 10 ? "0" : "" ) + seconds);
            },1000);

    setInterval( function() {
            // Create a newDate() object and extract the minutes of the current time on the visitor's
            var minutes = new Date().getMinutes();
            // Add a leading zero to the minutes value
            $("#min").html(( minutes < 10 ? "0" : "" ) + minutes);
        },1000);

    setInterval( function() {
            // Create a newDate() object and extract the hours of the current time on the visitor's
            var hours = new Date().getHours();
            // Add a leading zero to the hours value
            $("#hours").html(( hours < 10 ? "0" : "" ) + hours);
        }, 1000);
}); 
$(document).ready(function() {
    $("#jqxWidgetCalendar").jqxCalendar({ 
        enableTooltips: true, 
        width: 180,
        height: 180,
        culture: 'es-MX'
    });
    $("#jqxWidgetCalendar").hide();
    $("#triegerCalendar").click(function (){
        $("#jqxWidgetCalendar").animate({height: "toggle",width: "toggle"
                }, 500);
    });
});

