// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require activestorage
//= require jquery.jpostal
//= require_tree .
/*global $*/
/*global jQuery*/

$(function() {
  return $('#customer_postcode').jpostal({
      postcode: ['#customer_postcode'],
      address: {
        "#customer_address": "%3%4%5",
      },
    });
});


jQuery(function() {
    jQuery('.slide').slick({
        dots: true,
        autoplay: true,
        autoplaySpeed: 3000,
    });
});
