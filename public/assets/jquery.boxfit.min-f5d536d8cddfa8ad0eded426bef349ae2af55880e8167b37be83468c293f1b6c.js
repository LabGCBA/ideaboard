!function(t,i){"use strict";"function"==typeof define&&define.amd?define(["jquery"],function(e){return i(t,e)}):"object"==typeof exports?module.exports=i(t,require("jquery")):i(t,jQuery)}(this,function(t,i){"use strict";var e=function(e,s){return e.each(function(){var e,n,h,l,o,c,f,r;if(f={width:null,height:null,step_size:1,step_limit:200,align_middle:!0,align_center:!0,multiline:!1,minimum_font_size:5,maximum_font_size:null,line_height:"100%"},i.extend(f,s),f.width?(c=f.width,i(this).width(c+"px")):c=i(this).width(),f.height?(l=f.height,i(this).height(l+"px")):l=i(this).height(),c&&l){for(f.multiline||i(this).css("white-space","nowrap"),o=i(this).html(),0===i("<div>"+o+"</div>").find("span.boxfitted").length?(r=i(i("<span></span>").addClass("boxfitted").html(o)),i(this).html(r)):r=i(i(this).find("span.boxfitted")[0]),e=0,n=r,i(this).css("display","table"),n.css("display","table-cell"),f.align_middle&&n.css("vertical-align","middle"),f.align_center&&(i(this).css("text-align","center"),n.css("text-align","center")),n.css("line-height",f.line_height),n.css("font-size",f.minimum_font_size);i(this).width()<=c&&i(this).height()<=l&&!(e++>f.step_limit)&&(h=parseInt(n.css("font-size"),10),!(f.maximum_font_size&&h>f.maximum_font_size));)n.css("font-size",h+f.step_size);return n.css("font-size",parseInt(n.css("font-size"),10)-f.step_size),i(this)}return null!==t.console?console.info("Set static height/width on target DIV before using boxfit! Detected width: "+c+" height: "+l):void 0})};return i.fn.boxfit=function(t){return e(this,t)},e});