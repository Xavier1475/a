$(".vistaw").hide();
var id =$("#form_formaPago").val();
if(id==5){
    $(".vistaw").show();
    $(".chtm").addClass("col-lg-6");
    $(".chtm").removeClass("col-lg-4");
}else{
    $(".vistaw").hide();
    $(".chtm").removeClass("col-lg-6");
    $(".chtm").addClass("col-lg-4");
}

$(document).on("change","#form_formaPago",function(){
    var id =$(this).val();
    if(id==5){
        $(".vistaw").show();
        $(".chtm").addClass("col-lg-6");
    $(".chtm").removeClass("col-lg-4");
    }else{
        $(".vistaw").hide();
        $(".chtm").removeClass("col-lg-6");
    $(".chtm").addClass("col-lg-4");
    }
});