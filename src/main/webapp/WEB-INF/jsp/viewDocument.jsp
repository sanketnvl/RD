<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<% String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<title>Page Title</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=appUrl %>/css/fonts_icon.css">
<link rel="stylesheet" href="<%=appUrl %>/css/style.css" />
<link rel="stylesheet" href="<%=appUrl %>/css/inner_page.css" />
<link rel="stylesheet" href="<%=appUrl %>/css/api.css" />
<style>
.navbar .btn, .navbar .btn-group {
    margin-top: 12px;
}

body{
    background: #EEE;   
}

header, .navbar-default{
    background: #FFF;
}

header{
    border-bottom: 2px solid #CCC;
}

.navbar-default{
    border: 0px;
}
/* end nav and body section every page*/



/*heading section every page*/
.headerbox {
    background-color: #EFEBFC;
    border: solid #E0DEDE 1px;
    color: #0C002E;
}

.bodybox {
    background-color: white;
    border: solid #E0DEDE 1px;
}
/* end heading section every page*/




/* button color */
.navbtnstyle {
    background-color: #24246B;
    color: white;
}
a.navbtnstyle:hover{color: white;}

.btnaddmore {
    background-color: #55555E;
    color: white;
}
a.btnaddmore:link{color: white;}
a.btnaddmore:hover{color: white;}
a.btnaddmore:visited{color:white;} 
a.btnaddmore:active{color: white;}


.btncancel {
    background-color: #31317A;
    color: white;
}
a.btncancel:link{color: white;}
a.btncancel:hover{color: white;}
a.btncancel:visited{color:white;} 
a.btncancel:active{color: white;}

.btnsave {
    background-color: #0E0E2B;
    color: white;
}
input.btnsave:hover {
    background: transparent;
    background-color: #0E0E2B;
    color: white;  
}

.btnloginsave {
    background-color: #31317A;
    color: white;
}
input.btnloginsave:hover {
    background: transparent;
    background-color: #31317A;
    color: white;  
}

.signinlink {
    color: #31317A;
}
a.signinlink:link{color: #31317A;}
a.signinlink:hover{color: #31317A;}
a.signinlink:visited{color:#31317A;} 
a.signinlink:active{color: #31317A;}
/* end button color */







/* errors in view page */
#error_explanation{
    border: 1px solid red;
    background-color: #FFDFDF;
    margin-bottom: 10px;
    padding: 5px 10px;
}

#error_explanation h2{
    font-size: 14px;
    font-weight: bold;
}

#error_explanation ul, #error_explanation li{
    margin: 0px;
    padding: 0px;
    list-style-type: none;
    color: red;
    font-size: 13px;
}

.error{
    color: red;
}
/* end errors in view page */




/*sortable drag drop*/
#sortable1, #sortable2 {
    border: 1px solid #eee;
    width: 142px;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    float: left;
    margin-right: 10px;
}

#sortable1 li, #sortable2 li {
    margin: 0 5px 5px 5px;
    padding: 5px 15px;
    font-size: 1.2em;
    width: 120px;
    background: #2E2E33;
    color: #FFF;
    text-align: center;
    border-radius: 5px;
}

#ajax_loader_big_div {
    display:none;
    height:auto;
    left:35%;
    position:fixed;
    top:40%;
    z-index:999999999999;
    padding: 10px 30px;
    background: #F1F1F1;
    border: 1px solid #111;
}


/*end sortable drag drop*/





/*responsive iframe*/
#signthis-document-viewer{
    width: 100%;
    height: 600px;
}

.document-reader img{
    border: 1px solid #CCC;
}
.page-number{
    margin-bottom: 20px;
}

.dragSigners, .dragMe{
    margin: 5px;
    padding: 5px;
   /*  background: #2E2E33; */
    color: #FFF;
    text-align: center;
    border-radius: 3px;
    cursor: move;
    font-family: Helvetica,Arial,sans-serif;
    font-size: 12px;
}
.dragSigners{
    z-index: 999;
}
.dragMe{
    position: relative;
}
.closeIt{
    background: #FFF;
    color: #111;
    padding: 0 2px;
    cursor: pointer;
}
/*end responsive iframe*/

/*table rows color*/
.even{background-color: #F5F5F5;}
/*end table rows color*/

.error{
    color: red;
    font-size: 12px;
}

#handwriting_scroll {
    height: 100px;
    position: relative;
    overflow: auto;
}

.signature-section{
    border-left: 1px solid blue;
    border-top: 1px solid blue;
    border-bottom: 1px solid blue;
    border-radius: 5px;
    padding: 5px;
}
.signature-section img{
    max-width: 75px;
}

.main-wrapper{
    max-height: 600px;
    overflow: auto;
}

.sidebar{
    position: fixed;
}

.document-content{
    position: relative;
    left: 325px;
}
.drop-area {
    background-color:#afd1b2;
}
.hideIt {
    visibility: hidden;
}

 input[type=image]{
 height: 54px;
 width:185px;
 background: #eee;
 background-color: transparent;
 }
</style>
</head>
<body>
<input type="hidden" id="contextPath" value="<%=appUrl %>/"/>
<section>
  <div class="container">
    <div class="panel-body">
      <div class="panel-body">
          <div class="row main-wrapper" style="border: 1px solid #CCC; background-color: #FFF;">
              <div class="col-sm-3 sidebar" >
                  <div class="form-group"></div>
                  <div class="row">
                    <div class="col-sm-12">
                      <p>Signers List</p>
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <div class="row">
                      <div class="col-sm-12" id="draggable1">
                          <div class="row">
                            <div id="signer-1" class="dragMe dragSigners btn btn-light-oragne margB20" data-signer-id="1" data-document-id="1">
                                <span class="icon-menu pull-left"></span>NAME<span class="icon-menu pull-right"></span>
                            </div>

                            <div id="signer-2" class="btn btn-light-yellow margB20 dragMe dragSigners" data-signer-id="2" data-document-id="1">
                                <span class="icon-menu pull-left"></span>DATE<span class="icon-menu pull-right"></span>
                            </div>

                            <div id="signer-3" class="btn btn-light-Bermuda margB20 dragMe dragSigners" data-signer-id="3" data-document-id="1">
                                <span class="icon-menu pull-left"></span>SIGNATURE<span class="icon-menu pull-right"></span>
                            </div>
                          </div>
                      </div>
                    </div>
                  </div>


                  <div class="form-group">
                    <div class="row">
                        
                    </div>
                  </div>

                </div>


                <div class="col-sm-9 document-content">
                  <div class="form-group">
            
                  </div>
            
                  <div class="form-group">
                    <div class="row">
                      <div class="col-sm-12">
                        Document 1: &nbsp; &nbsp; &nbsp; &nbsp;
                          <span class="debug-position1"></span>
                          <span class="debug-position2"></span>
                      </div>
                    </div>
                  </div>
            
                  <div class="form-group">
                    <div class="row">
                      <div class="col-xs-12 col-sm-12">
                        <div class='document-reader' id="document-reader">
                          <div id='draggable-signature' class="fixed">
                            <!-- <div class="page_1" id="">
							<img class="image_loader" src="http://s24.postimg.org/8mwl7v1ud/image.png">
                            <div class="page-number">1</div>
                            </div>
							
							<div class="page_2">
                            <img class="image_loader" src="http://s24.postimg.org/8mwl7v1ud/image.png">
                            <div class="page-number">2</div>
                            </div>
							
							<div class="page_3">
                            <img class="image_loader" src="http://s24.postimg.org/8mwl7v1ud/image.png">
                            <div class="page-number">3</div>
							</div> -->
							
                        </div>
                      </div>
                    </div>
            
                  </div>
                </div>
              </div>
            </div>
    </div>
  </div>
  </div>
</section>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.js"></script>
<script>
$(function(){
	var fileName='${fileName}';
	getAjaxDocument(fileName);
	function getAjaxDocument(fileName){
		var contextPath=$("#contextPath").val();
		var info = "?fileName="+fileName;
		$.ajax({
			//contentType : 'application/json; charset=utf-8',
			type : "GET",
			url : contextPath+"getViewDocument"+info,
			async: false,
			//dataType : 'json',
			//data : JSON.stringify(data),
			beforeSend : function(xhr) {
				//$('#signupbtn').buttonLoader('start');
			},
			complete : function() {
				//$("#signupbtn").buttonLoader('stop');
			},
			success : function(response) {
				var numpages="";
				var filename="";
				var fileid="";
				var width="";
				var height="";
				var i=1;
				$.each( response, function( key, value ) {
					if(key == "numpages" ){
						numpages=value;
						$("#numpages").val(numpages);
					}
					
					if(key =="filename"){
						filename=value;
						//alert(filename);
					}
					
					if(key =="fileid"){
						fileid=value;
					}
					
					if(key =="pwidth"){
						width=value;
						
					}
					if(key =="pheight"){
						height=value;
						$("#pageHeight").val(height)
					}
				});
				for (var i = 1; i <= numpages; i++) {
				  		$("#document-reader").append('<div class="drop" id="pageno_'+i+'"><img width="'+width+'px" height="'+height+'px" class="image_loader" src="'+contextPath+'img?filename='+filename+'&page='+i+'"></div>');
				}
				
			},
			error: function(xhr, textStatus, errorThrown)
			 {
			 	alert('ajax loading error... ... ');
			 	return false;
			}
		})	
	}
    DragSigner();
    DragMe();
  })
  
  

  //remove the dragsigner when click on close icon
  $(document).on("click", ".closeIt", function(){
    var parent = $(this).parent();
    parent.remove();
  });
function hideTextbox(id) {
    $("#fieldPosition" + id).remove();
}
function DragSigner(){

    $(".dragSigners").draggable({
      helper: 'clone',
      cursor: 'move',
      tolerance: 'fit',
      revert: true 
    });

    $(".drop").droppable({
      accept: '.dragSigners',
      activeClass: "drop-area",

      drop: function(e, ui) {
        dragEl = ui.helper.clone();
        ui.helper.remove();

        document_id   = dragEl.data("document-id");
        signer_id     = dragEl.data("signer-id");
        leftPosition  = ui.offset.left - $(this).offset().left;
        alert(leftPosition)
        topPosition   = ui.offset.top - $(this).offset().top;
        var droppableId = $(this).attr("id");
      	//  alert("top: " + topPosition + ", left: " + leftPosition); 
        var uniqueGenerator = $("#generator").val();
        if (document_id == 1 && signer_id == 1) {
        	
			//$(this).find('.drop').attr("id",'fieldPosition'+uniqueGenerator);
			
			$("#"+droppableId).append(ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group name"><a class="close" style=" text-decoration: none;" id="field'+uniqueGenerator+'" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a><span style="position:relative;" class="add-clear-span"><input name="name" type="text" class="form-control" id="field'+uniqueGenerator+'" data-top="'+topPosition+'" data-left="'+leftPosition+'" onchange="getfieldValue(this.value,'+uniqueGenerator+')" placeholder="Name" value="" type="text"></span><span class="input-group-btn"></span></div></div>'));
			//$("#"+droppableId)($(ui.helper).attr("id",'fieldPosition'+uniqueGenerator));
			//$("#"+droppableId).removeClass("btn btn-light-Bermuda margB20");
		}else if (document_id == 1 && signer_id == 3) {
			var signature=$("#signature").val();
			if(signature !=''){
				
				dragEl = ui.helper.clone().html('<div class="input-drop-fild"><div class="input-group signatureb"><a class="close" style=" text-decoration: none;" id="" onclick="hideTextbox('+uniqueGenerator+')" href="#clear"><span class="icon-close"></span></a> <span style="position:relative;" class="add-clear-span"><input name="signature" type="image"  id="field'+uniqueGenerator+'" onclick="openMySignature('+uniqueGenerator+')" class="" placeholder="Signature here" src="'+signature+'" readonly></span><span class="input-group-btn"></span></div></div>');
			}
			dragEl.attr('id', 'fieldPosition'+uniqueGenerator+'');
			dragEl.removeClass("btn btn-light-Bermuda margB20");
		}
        dragEl.data("signer-id", signer_id);
		dragEl.draggable({
          helper: 'original',
          cursor: 'move',
          tolerance: 'fit',
          drop: function (event, ui) {
            $(ui.draggable).remove();
          }
        });

        // append element to #document-reader
        //dragEl.addClass("dragMe");
        //dragEl.attr('id', 'fieldPosition'+uniqueGenerator+''); 
        //dragEl.removeClass("dragSigners col-sm-6 parent");
        //$('.dragMe').attr('id', 'fieldPosition'+uniqueGenerator+''); 
        //dragEl.find("span.closeIt").removeClass("hideIt");
        ///dragEl.appendTo('#document-reader');
		
        
        var incremented = parseInt(uniqueGenerator) + 1;
        $("#generator").val(incremented);
        // update draged element position to database
        // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)

        // activate dragging for cloned element
        DragMe();
      }
    });
  }



  function DragMe(){
    var document_id;
    $(".dragMe").draggable({
      containment: "#document-reader",
      cursor: 'move',
      // opacity: 0.35,
      stack: $('#document-reader'),
      scroll: false,
      appendTo: $("#document-reader"),
      start: function(event, ui) {
        startPosition = $(this).position();
      },
      stop: function(event, ui) {
        dragEl        = $(this);
        stopPosition  = dragEl.position();
        document_id   = dragEl.data("document-id");
        signer_id     = dragEl.data("signer-id");
        
        // debug current dropped position
        // this position is working perfectly fine.
        // above drag, drop and clone position should behave like this
       // alert("top: " + stopPosition.top + ", left: " + stopPosition.left); 
          
        console.log(dragEl.hasClass("parent"))
        if(!dragEl.hasClass("parent")){
         // updateDraggedPosition(dragEl, stopPosition, document_id, signer_id)
        }
      }
    });
  }

 
  
  
</script> 
<input type="hidden" id="generator" value="1" />
<input type="hidden" id="signature" value="data:image/png;base64,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">
</body>
</html>
