/********************************
  Private Message Model
*********************************/
window.PrivateMessage = Backbone.Model.extend({
  
  initialize: function(){
    console.log("Message User", this.get("user"));
  },
  
  isYou: function() {
    return this.get("user").id == APP.current_user.id; 
  }

});

/********************************
  Private Messages Collection
*********************************/
window.PrivateMessageList = Backbone.Collection.extend({

  model: PrivateMessage
  
  // new_chats: 0

});

window.PrivateMessages = new PrivateMessageList();

/********************************
  Private Message View
*********************************/
var PrivateMessageView = Backbone.View.extend({

  model: PrivateMessage,

  tagName: "li",
  
  events: {
    // no events yet
  },

  initialize: function() {
    // _.bindAll(this, 'render', 'unlikePrivateMessage', 'likePrivateMessage');
    this.model.bind('change', this.render);
    this.model.view = this;
  },
  
  render: function() {
    // var msg = _.template TODO message_template(this.model.toJSON());
    // $(this.el).html(msg);
    return this;
  }


});



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