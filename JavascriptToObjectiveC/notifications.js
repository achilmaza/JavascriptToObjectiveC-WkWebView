var buttonClickNotification = function () {
    
     var messageToPost = {'buttonId': 'pressMe'};
    
      /* window.webkit.messageHandlers.<msgname>.postMessage(<message body>)*/
      window.webkit.messageHandlers.buttonClicked.postMessage(messageToPost); 
};

var displayNotification = function () {
    
    var button = document.getElementById('pressMe');
    button.style.backgroundColor='#5c45f0';
    
    alert("Hello.. Button Pressed!");
}