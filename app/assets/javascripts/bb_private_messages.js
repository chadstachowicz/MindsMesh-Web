/********************************
  The PMAppView Application
*********************************/

window.PMAppView = Backbone.View.extend({

     events: {
      "submit form#new-message": "sendMessage",
      "keydown form#new-message" : "handleInputFormKeyup"
     },

     initialize: function() {       
       // _.bindAll(this, 'addMessage', 'addAllMessages');

     },

     render: function() {
      // doesn't do anything at the moment, useful if wew have any global views to refresh

     }



});


////////////////////////
// DOM LOADED
////////////////////////
$(function(){

  // Start it up
  window.PMApp = new PMAppView({el: $("#mm-private-messages")});
  
});