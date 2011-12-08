// This example requires callback.php to be enabled and coded.





    FB.init({appId: 249365405125992, status: true, cookie: true});

    function placeOrder() {
      // If using mobile, this is where you place the
      // iOS native app check for credits (see below)

      // Assign an internal ID that points to a database record
      var order_info = 'abc123';

      // calling the API ...
      var obj = {
        method: 'pay',
        order_info: order_info,
        purchase_type: 'item'//,
       // dev_purchase_params: {'oscif': true}
      };
    console.log("facebook callback before");
      FB.ui(obj, callback);
    }
    
    var callback = function(data) {
    console.log("facebook callback");
    console.log(data);
    
    
      if (data['order_id']) {
        return true;
      } else {
        //handle errors here
        return false;
      }
    };

    function writeback(str) {
      document.getElementById('output').innerHTML=str;
    }
