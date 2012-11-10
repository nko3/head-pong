// Generated by CoffeeScript 1.4.0
(function() {
  var URL, fallback, getUserMedia, got_camera, hasGetUserMedia, not_supported, show_msg, _stream, _video;

  _video = _stream = null;

  URL = window.URL || window.webkitURL;

  hasGetUserMedia = function() {
    return navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
  };

  getUserMedia = function(options, success, error) {
    getUserMedia = navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia || function(options, success, error) {
      return error();
    };
    return getUserMedia.call(navigator, options, success, error);
  };

  if (!hasGetUserMedia()) {
    not_supported;

  }

  $("#camerabutton").on("click", function() {
    _stream = null;
    return getUserMedia({
      video: true,
      audio: false
    }, function(x) {
      return got_camera(x);
    }, function(e) {
      return fallback(e);
    });
  });

  $("#stopbutton").on("click", function() {
    _video.get(0).pause();
    return _stream.stop();
  });

  got_camera = function(stream) {
    _video = $("#camvideo");
    _video.attr("src", URL.createObjectURL(stream));
    return _stream = stream;
  };

  fallback = function(e) {
    alert("err: " + e);
    return show_msg("Not able to connect with your camera device, did you authorized us?");
  };

  not_supported = function() {
    return show_msg("We're using cool stuff, so you need to move to a decent browser, like chrome.");
  };

  show_msg = function(message) {
    return $("#message").html(message);
  };

}).call(this);
