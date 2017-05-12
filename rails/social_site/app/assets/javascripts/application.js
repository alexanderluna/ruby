// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require jquery.ui.widget
//= require load-image.all.min
//= require canvas-to-blob.min
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-process
//= require jquery.fileupload-image
//= require_tree .

// function loadImage(){
//   $.each($('.load-image'), function(index, obj){
//     console.log("Getting the image");
//     var img = new Image();
//     img.src = $(obj).attr('data-source');
//
//     $(img).ready(function(){
//       console.log("Inserting the image");
//       $(obj).attr('src', img.src);
//     })
//   })
// };
